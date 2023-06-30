// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_egsys/core/theme/text_syles.dart';
import 'package:pokedex_egsys/core/utils/string_first_letter_captalize_extension.dart';
import 'package:pokedex_egsys/core/widgets/default_app_bar.dart';
import 'package:pokedex_egsys/core/widgets/default_screen.dart';
import 'package:pokedex_egsys/domain/entities/pokemon.dart';

class DetailsPageArguments {
  Pokemon pokemon;

  DetailsPageArguments({
    required this.pokemon,
  });
}

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as DetailsPageArguments;
    return Scaffold(
      body: DefaultScreen(
        child: Column(
          children: [
            DefaultAppBar(
              title: args.pokemon.name?.toUpperCase() ?? '',
            ),
            if (args.pokemon.pokemonImageUrl != null)
              Hero(
                tag: args.pokemon.name!,
                child: CachedNetworkImage(
                  height: 200,
                  imageUrl: args.pokemon.pokemonImageUrl!,
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
                  args.pokemon.name?.capitalizeFirstLetter() ?? '',
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
                  args.pokemon.types!
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
                  args.pokemon.height?.toString() ?? '',
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
                  args.pokemon.weight?.toString() ?? '',
                  style: TextStyles.h4Style,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
