import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:pokedex_egsys/core/routes/constants_routes.dart';
import 'package:pokedex_egsys/core/theme/app_colors.dart';
import 'package:pokedex_egsys/core/theme/text_syles.dart';
import 'package:pokedex_egsys/core/widgets/default_app_bar.dart';
import 'package:pokedex_egsys/core/widgets/default_screen.dart';
import 'package:pokedex_egsys/presentation/details/pages/details_page.dart';
import 'package:pokedex_egsys/presentation/home/bloc/home_bloc.dart';
import 'package:pokedex_egsys/presentation/home/widgets/filter_selector.dart';
import 'package:pokedex_egsys/presentation/home/widgets/pokemon_card.dart';
import 'package:pokedex_egsys/presentation/home/widgets/search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late HomeBloc _homeBloc;
  late final AnimationController _controller;
  final ScrollController _scrollController = ScrollController();
  final _searchBarController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _controller = AnimationController(vsync: this);
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        _homeBloc.add(GetPokemonsEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey8,
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeSuccess && state.randomPokemonSelected != null) {
            Navigator.of(context).pushNamed(
              DETAILS_ROUTE,
              arguments: DetailsPageArguments(
                pokemon: state.randomPokemonSelected!,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is HomeSuccess) {
            return DefaultScreen(
              child: Column(
                children: [
                  DefaultAppBar(
                    title: 'My Pokedex',
                    actions: [
                      if (state.enabledFilters)
                        IconButton(
                          onPressed: () {
                            _homeBloc.add(
                              ToggleEnabledFilterEvent(),
                            );
                          },
                          icon: const Icon(
                            Icons.filter_alt_off,
                            color: AppColors.grey3,
                          ),
                        ),
                      if (!state.enabledFilters)
                        IconButton(
                          onPressed: () {
                            _homeBloc.add(
                              ToggleEnabledFilterEvent(),
                            );
                          },
                          icon: const Icon(
                            Icons.filter_alt,
                            color: AppColors.grey3,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: SafeArea(
                      child: Column(
                        children: [
                          AnimatedSize(
                            duration: const Duration(milliseconds: 500),
                            child: state.enabledFilters
                                ? Column(
                                    children: [
                                      const FilterSelector(),
                                      const SizedBox(height: 8),
                                      if (state.filterTypeSelected ==
                                          FilterType.search)
                                        SearchInput(
                                          hint: 'Busque por nome ou id',
                                          controller: _searchBarController,
                                          onClean: () {
                                            _homeBloc.add(ResetFiltersEvent());
                                            setState(() {});
                                          },
                                          onChange: (value) {
                                            setState(() {
                                              _homeBloc.add(
                                                SearchPokemonsByNameEvent(
                                                  value,
                                                ),
                                              );
                                            });
                                          },
                                        ),
                                      if (state.filterTypeSelected ==
                                          FilterType.type)
                                        DropdownButton(
                                          isExpanded: true,
                                          value: state.pokemonTypeSelected,
                                          items: state.types!
                                              .map(
                                                (item) => DropdownMenuItem(
                                                  value: item,
                                                  child:
                                                      Text(item.toUpperCase()),
                                                ),
                                              )
                                              .toList(),
                                          onChanged: (String? value) {
                                            if (value == 'all') {
                                              _homeBloc.add(
                                                ResetFiltersEvent(),
                                              );
                                            } else {
                                              _homeBloc.add(
                                                GetPokemonsByTypeEvent(value!),
                                              );
                                            }
                                          },
                                        )
                                    ],
                                  )
                                : const SizedBox(),
                          ),
                          const SizedBox(height: 12),
                          Expanded(
                            child: _searchBarController.text.isNotEmpty &&
                                    state.filteredPokemons!.isEmpty
                                ? Center(
                                    child: Text(
                                      'Nenum resultado encontrado',
                                      style: TextStyles.h5Style.copyWith(
                                        color: AppColors.grey3,
                                      ),
                                    ),
                                  )
                                : GridView(
                                    controller: _scrollController,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 4,
                                      crossAxisSpacing: 4,
                                      //childAspectRatio: 4 / 2,
                                    ),
                                    children:
                                        state.filteredPokemons?.isNotEmpty ??
                                                false
                                            ? state.filteredPokemons!
                                                .map((item) =>
                                                    PokemonCard(pokemon: item))
                                                .toList()
                                            : state.pokemons
                                                .map((item) =>
                                                    PokemonCard(pokemon: item))
                                                .toList(),
                                  ),
                          ),
                          if (state.loadingMore)
                            const SpinKitThreeBounce(
                              color: Colors.red,
                              size: 25,
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _controller.reverse();
          await Future.delayed(const Duration(milliseconds: 700));
          _controller.forward();
          _homeBloc.add(GetRandomPokemonEvent());
        },
        child: Lottie.asset(
          'assets/animations/pokeball.json',
          controller: _controller,
          onLoaded: (composition) {
            _controller
              ..duration = composition.duration
              ..forward();
          },
        ),
      ),
    );
  }
}
