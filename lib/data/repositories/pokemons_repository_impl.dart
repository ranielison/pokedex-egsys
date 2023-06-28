import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:pokedex_egsys/core/error/failures.dart';
import 'package:pokedex_egsys/core/usecases/usecase.dart';
import 'package:pokedex_egsys/data/datasources/pokemons_remote_datasource.dart';
import 'package:pokedex_egsys/domain/entities/pokemon.dart';
import 'package:pokedex_egsys/domain/repositories/pokemons_repository.dart';
import 'package:pokedex_egsys/domain/usecases/get_pokemons.dart';

class PokemonsRepositoryImpl implements PokemonsRepository {
  /// Data Source
  final PokemonsRemoteDatasource pokemonsRemoteDatasource;

  const PokemonsRepositoryImpl(this.pokemonsRemoteDatasource);

  @override
  Future<Either<Failure, List<Pokemon>>> getPokemons(
    GetPokemonsParams params,
  ) async {
    final response = await pokemonsRemoteDatasource.getPokemons(params);

    return response.fold(
      (failure) => Left(failure),
      (pokemonsResponse) async {
        List<Pokemon> pokemons = [];
        for (var item in pokemonsResponse.pokemons!) {
          final pokemon = await pokemonsRemoteDatasource.getPokemonByIdentify(
            item.name!,
          );
          pokemon.fold((l) {}, (r) {
            pokemons.add(r.toEntity());
          });
        }
        return Right(pokemons);
      },
    );
  }

  @override
  Future<Either<Failure, Pokemon>> getRandomPokemon(NoParams params) async {
    final randomNumber = 1 + (Random().nextInt(1010 - 1));

    final response =
        await pokemonsRemoteDatasource.getPokemonByIdentify('$randomNumber');
    return response.fold(
      (failure) => Left(failure),
      (pokemonsResponse) async {
        return Right(pokemonsResponse.toEntity());
      },
    );
  }
}
