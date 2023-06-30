import 'package:dartz/dartz.dart';
import 'package:pokedex_egsys/core/error/failures.dart';
import 'package:pokedex_egsys/core/usecases/usecase.dart';
import 'package:pokedex_egsys/domain/entities/pokemon.dart';
import 'package:pokedex_egsys/domain/repositories/pokemons_repository.dart';

class GetPokemonsByType extends UseCase<List<Pokemon>, String> {
  final PokemonsRepository _repo;

  GetPokemonsByType(this._repo);

  @override
  Future<Either<Failure, List<Pokemon>>> call(String params) =>
      _repo.searchPokemonByType(params);
}
