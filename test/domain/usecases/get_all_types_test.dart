import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex_egsys/core/error/failures.dart';
import 'package:pokedex_egsys/core/usecases/usecase.dart';
import 'package:pokedex_egsys/domain/repositories/pokemons_repository.dart';
import 'package:pokedex_egsys/domain/usecases/get_all_types.dart';

import 'get_all_types_test.mocks.dart';

@GenerateMocks([PokemonsRepository])
void main() {
  late MockPokemonsRepository mockPokemonsRepository;
  late GetAllTypes getAllTypes;

  setUp(() {
    mockPokemonsRepository = MockPokemonsRepository();
    getAllTypes = GetAllTypes(mockPokemonsRepository);
  });

  group('GetAllTypes Usecase', () {
    test("Should get all pokemons types from repository", () async {
      List<String> typesList = ['fire', 'water'];

      /// arrange
      when(mockPokemonsRepository.getAllTypes())
          .thenAnswer((_) async => Right(typesList));

      /// act
      final result = await getAllTypes(NoParams());

      /// assert
      verify(mockPokemonsRepository.getAllTypes());
      expect(Right(ilist(result.fold((l) => [], (r) => r))),
          (Right(ilist(typesList))));
    });

    test("RequestSupport should return error when repo throw an exception",
        () async {
      /// arrange
      when(
        mockPokemonsRepository.getAllTypes(),
      ).thenAnswer((_) async => const Left(ServerFailure('')));

      /// act
      final result = await getAllTypes(NoParams());

      /// assert
      verify(mockPokemonsRepository.getAllTypes());
      expect(result, equals(const Left(ServerFailure(''))));
    });
  });
}
