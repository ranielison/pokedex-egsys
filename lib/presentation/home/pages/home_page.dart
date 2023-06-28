import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:pokedex_egsys/presentation/home/bloc/home_bloc.dart';
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
      appBar: AppBar(
        title: const Text('My Pokedex'),
        backgroundColor: Colors.red,
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeInitial) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    SearchInput(
                      hint: 'Busque por nome ou id',
                      onChange: (value) {
                        _homeBloc.add(SearchPokemonsByName(value));
                      },
                    ),
                    Expanded(
                      child: GridView(
                        controller: _scrollController,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          //childAspectRatio: 4 / 2,
                        ),
                        children: state.filteredPokemons != null
                            ? state.filteredPokemons!
                                .map((item) => PokemonCard(pokemon: item))
                                .toList()
                            : state.pokemons
                                .map((item) => PokemonCard(pokemon: item))
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
