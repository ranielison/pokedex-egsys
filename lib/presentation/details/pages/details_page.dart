// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_egsys/core/theme/text_syles.dart';
import 'package:pokedex_egsys/core/utils/string_first_letter_captalize_extension.dart';
import 'package:pokedex_egsys/core/widgets/data_shimmer.dart';
import 'package:pokedex_egsys/core/widgets/default_app_bar.dart';
import 'package:pokedex_egsys/core/widgets/default_screen.dart';
import 'package:pokedex_egsys/domain/entities/pokemon.dart';
import 'package:pokedex_egsys/presentation/details/bloc/details_bloc.dart';

class DetailsPageArguments {
  Pokemon? pokemon;
  String? identify;

  DetailsPageArguments({
    this.pokemon,
    this.identify,
  });
}

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final detailsBloc = BlocProvider.of<DetailsBloc>(context);

    final args =
        ModalRoute.of(context)!.settings.arguments as DetailsPageArguments;

    detailsBloc.add(
      InitDetailsEvent(
        pokemon: args.pokemon,
        identify: args.identify,
      ),
    );

    return Scaffold(
      body: DefaultScreen(
        child: BlocBuilder<DetailsBloc, DetailsState>(
          builder: (context, state) {
            if (state is DetailsLoading) {
              return const Column(
                children: [
                  DataShimmer(height: 200),
                  SizedBox(height: 8),
                  DataShimmer(height: 50),
                  SizedBox(height: 8),
                  DataShimmer(height: 50),
                  SizedBox(height: 8),
                  DataShimmer(height: 50),
                  SizedBox(height: 8),
                  DataShimmer(height: 50),
                  SizedBox(height: 8),
                ],
              );
            }
            if (state is DetailsSuccess) {
              return Column(
                children: [
                  DefaultAppBar(
                    title: state.pokemon?.name?.toUpperCase() ?? '',
                  ),
                  if (state.pokemon?.pokemonImageUrl != null)
                    Hero(
                      tag: state.pokemon!.name!,
                      child: CachedNetworkImage(
                        height: 200,
                        imageUrl: state.pokemon!.pokemonImageUrl!,
                      ),
                    ),
                  const SizedBox(height: 20),
                  const Divider(),
                  Row(
                    children: [
                      Text(
                        'Name:',
                        style: TextStyles.h4Style.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        state.pokemon?.name?.capitalizeFirstLetter() ?? '',
                        style: TextStyles.h4Style,
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Text(
                        'Types:',
                        style: TextStyles.h4Style.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        state.pokemon!.types!
                            .map((t) => t.name!.capitalizeFirstLetter())
                            .toList()
                            .join(", "),
                        style: TextStyles.h4Style,
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Text(
                        'Height:',
                        style: TextStyles.h4Style.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        state.pokemon!.height?.toString() ?? '',
                        style: TextStyles.h4Style,
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Text(
                        'Weight:',
                        style: TextStyles.h4Style.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        state.pokemon!.weight?.toString() ?? '',
                        style: TextStyles.h4Style,
                      ),
                    ],
                  )
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
