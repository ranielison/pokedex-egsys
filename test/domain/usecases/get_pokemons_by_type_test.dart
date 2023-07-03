import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex_egsys/core/error/failures.dart';
import 'package:pokedex_egsys/data/models/pokemons_response.dart';
import 'package:pokedex_egsys/domain/repositories/pokemons_repository.dart';
import 'package:pokedex_egsys/domain/usecases/get_pokemons_by_type.dart';

import '../../fixtures/fixture_reader.dart';
import 'get_pokemons_by_type_test.mocks.dart';

@GenerateMocks([PokemonsRepository])
void main() {
  late MockPokemonsRepository mockPokemonsRepository;
  late GetPokemonsByType getPokemonsByType;
  late PokemonsResponse pokemonsResponse;
  late String pokemonType;

  setUp(() {
    pokemonsResponse = PokemonsResponse.fromJson(
      (json.decode(
        fixture(
          'pokemons_success_response.json',
        ),
      ) as Map<String, dynamic>),
    );

    mockPokemonsRepository = MockPokemonsRepository();
    getPokemonsByType = GetPokemonsByType(mockPokemonsRepository);
    pokemonType = 'fire';
  });

  group('Get Pokemons By Type', () {
    test("Should get a list of pokemon from repository", () async {
      final pokemons =
          pokemonsResponse.pokemons!.map((item) => item.toEntity()).toList();

      /// arrange
      when(
        mockPokemonsRepository.searchPokemonByType(pokemonType),
      ).thenAnswer(
        (_) async => Right(pokemons),
      );

      /// act
      final result = await getPokemonsByType(pokemonType);

      /// assert
      verify(mockPokemonsRepository.searchPokemonByType(any));
      expect(
        Right(ilist(result.fold((l) => [], (r) => r))),
        Right(ilist(pokemons)),
      );
    });

    test("Should return error when repo throw an exception", () async {
      /// arrange
      when(
        mockPokemonsRepository.searchPokemonByType(pokemonType),
      ).thenAnswer((_) async => const Left(ServerFailure('')));

      /// act
      final result = await getPokemonsByType(pokemonType);

      /// assert
      verify(mockPokemonsRepository.searchPokemonByType(any));
      expect(result, equals(const Left(ServerFailure(''))));
    });
  });
}
