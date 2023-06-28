import 'package:dartz/dartz.dart';
import 'package:pokedex_egsys/core/error/failures.dart';
import 'package:pokedex_egsys/core/usecases/usecase.dart';
import 'package:pokedex_egsys/domain/entities/pokemon.dart';
import 'package:pokedex_egsys/domain/repositories/pokemons_repository.dart';

class GetPokemons extends UseCase<List<Pokemon>, GetPokemonsParams> {
  final PokemonsRepository _repo;

  GetPokemons(this._repo);

  @override
  Future<Either<Failure, List<Pokemon>>> call(GetPokemonsParams params) =>
      _repo.getPokemons(params);
}

class GetPokemonsParams {
  final int? limit;
  final int? offset;

  GetPokemonsParams({
    this.limit,
    this.offset,
  });
}
