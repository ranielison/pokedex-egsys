import 'package:dartz/dartz.dart';
import 'package:pokedex_egsys/core/error/failures.dart';
import 'package:pokedex_egsys/core/usecases/usecase.dart';
import 'package:pokedex_egsys/domain/entities/pokemon.dart';
import 'package:pokedex_egsys/domain/repositories/pokemons_repository.dart';

class SearchPokemonByName extends UseCase<Pokemon, String> {
  final PokemonsRepository _repo;

  SearchPokemonByName(this._repo);

  @override
  Future<Either<Failure, Pokemon>> call(String params) =>
      _repo.searchPokemonByName(params);
}
