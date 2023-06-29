import 'package:dartz/dartz.dart';
import 'package:pokedex_egsys/core/error/failures.dart';
import 'package:pokedex_egsys/core/usecases/usecase.dart';
import 'package:pokedex_egsys/domain/repositories/pokemons_repository.dart';

class GetAllTypes extends UseCase<List<String>, NoParams> {
  final PokemonsRepository _repo;

  GetAllTypes(this._repo);

  @override
  Future<Either<Failure, List<String>>> call(NoParams params) =>
      _repo.getAllTypes();
}
