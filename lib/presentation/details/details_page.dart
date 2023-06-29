// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
            Hero(
              tag: args.pokemon.name!,
              child: CachedNetworkImage(
                height: 200,
                imageUrl: args.pokemon.pokemonImageUrl,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
