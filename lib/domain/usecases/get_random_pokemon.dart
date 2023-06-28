import 'package:dartz/dartz.dart';
import 'package:pokedex_egsys/core/error/failures.dart';
import 'package:pokedex_egsys/core/usecases/usecase.dart';
import 'package:pokedex_egsys/domain/entities/pokemon.dart';
import 'package:pokedex_egsys/domain/repositories/pokemons_repository.dart';

class GetRandomPokemon extends UseCase<Pokemon, NoParams> {
  final PokemonsRepository _repo;

  GetRandomPokemon(this._repo);

  @override
  Future<Either<Failure, Pokemon>> call(NoParams params) =>
      _repo.getRandomPokemon(params);
}
