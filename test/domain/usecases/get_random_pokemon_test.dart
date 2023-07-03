import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex_egsys/core/error/failures.dart';
import 'package:pokedex_egsys/core/usecases/usecase.dart';
import 'package:pokedex_egsys/data/models/podemon_model.dart';
import 'package:pokedex_egsys/domain/entities/pokemon.dart';
import 'package:pokedex_egsys/domain/repositories/pokemons_repository.dart';
import 'package:pokedex_egsys/domain/usecases/get_random_pokemon.dart';

import '../../fixtures/fixture_reader.dart';
import 'get_random_pokemon_test.mocks.dart';

@GenerateMocks([PokemonsRepository])
void main() {
  late MockPokemonsRepository mockPokemonsRepository;
  late GetRandomPokemon getRandomPokemon;
  late Pokemon pokemon;

  setUp(() {
    pokemon = PokemonModel.fromJson(
      (json.decode(
        fixture(
          'pokemon_response.json',
        ),
      ) as Map<String, dynamic>),
    ).toEntity();

    mockPokemonsRepository = MockPokemonsRepository();
    getRandomPokemon = GetRandomPokemon(mockPokemonsRepository);
  });

  group('Get Random Pokemon', () {
    test("Should get a random pokemon from repository", () async {
      /// arrange
      when(
        mockPokemonsRepository.getRandomPokemon(),
      ).thenAnswer(
        (_) async => Right(pokemon),
      );

      /// act
      final result = await getRandomPokemon(NoParams());

      /// assert
      verify(mockPokemonsRepository.getRandomPokemon());
      expect(
        result,
        equals(Right(pokemon)),
      );
    });

    test("Should return error when repo throw an exception", () async {
      /// arrange
      when(
        mockPokemonsRepository.getRandomPokemon(),
      ).thenAnswer((_) async => const Left(ServerFailure('')));

      /// act
      final result = await getRandomPokemon(NoParams());

      /// assert
      verify(mockPokemonsRepository.getRandomPokemon());
      expect(result, equals(const Left(ServerFailure(''))));
    });
  });
}
