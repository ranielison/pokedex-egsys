import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_egsys/core/routes/constants_routes.dart';
import 'package:pokedex_egsys/core/theme/app_colors.dart';
import 'package:pokedex_egsys/domain/entities/pokemon.dart';
import 'package:pokedex_egsys/presentation/details/pages/details_page.dart';

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
        margin: EdgeInsets.zero,
        elevation: 4,
        child: Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (pokemon.pokemonImageUrl != null)
                Expanded(
                  child: Center(
                    child: Hero(
                      tag: pokemon.name!,
                      child: CachedNetworkImage(
                        height: 100,
                        imageUrl: pokemon.pokemonImageUrl!,
                      ),
                    ),
                  ),
                ),
              Text(
                pokemon.name?.toUpperCase() ?? '',
                style: const TextStyle(
                  color: AppColors.grey3,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
              //Text('${pokemon.height}'),
            ],
          ),
        ),
      ),
    );
  }
}
