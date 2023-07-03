import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex_egsys/core/error/failures.dart';
import 'package:pokedex_egsys/data/models/podemon_model.dart';
import 'package:pokedex_egsys/domain/entities/pokemon.dart';
import 'package:pokedex_egsys/domain/repositories/pokemons_repository.dart';
import 'package:pokedex_egsys/domain/usecases/searh_pokemon_by_name.dart';

import '../../fixtures/fixture_reader.dart';
import 'searh_pokemon_by_name_test.mocks.dart';

@GenerateMocks([PokemonsRepository])
void main() {
  late MockPokemonsRepository mockPokemonsRepository;
  late SearchPokemonByName searchPokemonByName;
  late Pokemon pokemon;
  late String pokemonName;

  setUp(() {
    pokemon = PokemonModel.fromJson(
      (json.decode(
        fixture(
          'pokemons_success_response.json',
        ),
      ) as Map<String, dynamic>),
    ).toEntity();

    mockPokemonsRepository = MockPokemonsRepository();
    searchPokemonByName = SearchPokemonByName(mockPokemonsRepository);
    pokemonName = 'pikachu';
  });

  group('Get Pokemons By Name', () {
    test("Should get a pokemon from repository", () async {
      /// arrange
      when(
        mockPokemonsRepository.searchPokemonByName(pokemonName),
      ).thenAnswer(
        (_) async => Right(pokemon),
      );

      /// act
      final result = await searchPokemonByName(pokemonName);

      /// assert
      verify(mockPokemonsRepository.searchPokemonByName(any));
      expect(result, Right(pokemon));
    });

    test("Should return error when repo throw an exception", () async {
      /// arrange
      when(
        mockPokemonsRepository.searchPokemonByName(pokemonName),
      ).thenAnswer((_) async => const Left(ServerFailure('')));

      /// act
      final result = await searchPokemonByName(pokemonName);

      /// assert
      verify(mockPokemonsRepository.searchPokemonByName(any));
      expect(result, equals(const Left(ServerFailure(''))));
    });
  });
}
