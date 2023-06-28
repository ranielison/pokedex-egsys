import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_egsys/core/routes/constants_routes.dart';
import 'package:pokedex_egsys/domain/entities/pokemon.dart';
import 'package:pokedex_egsys/presentation/details/details_page.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonCard({
    super.key,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          DETAILS_ROUTE,
          arguments: DetailsPageArguments(pokemon: pokemon),
        );
      },
      child: Card(
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Hero(
                    tag: pokemon.name!,
                    child: CachedNetworkImage(
                      height: 100,
                      imageUrl: pokemon.pokemonImageUrl,
                    ),
                  ),
                ),
              ),
              Container(
                height: 20,
                width: double.infinity,
                color: Colors.red,
                alignment: Alignment.center,
                child: Text(
                  pokemon.name?.toUpperCase() ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              //Text('${pokemon.height}'),
            ],
          ),
        ),
      ),
    );
  }
}
