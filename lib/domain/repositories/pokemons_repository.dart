import 'package:dartz/dartz.dart';
import 'package:pokedex_egsys/core/error/failures.dart';
import 'package:pokedex_egsys/domain/entities/pokemon.dart';
import 'package:pokedex_egsys/domain/usecases/get_pokemons.dart';

abstract class PokemonsRepository {
  Future<Either<Failure, List<Pokemon>>> getPokemons(
    GetPokemonsParams params,
  );

  Future<Either<Failure, Pokemon>> getRandomPokemon();

  Future<Either<Failure, Pokemon>> searchPokemonByName(String name);

  Future<Either<Failure, List<Pokemon>>> searchPokemonByType(String type);

  Future<Either<Failure, List<String>>> getAllTypes();
}
