import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex_egsys/core/di/injection_container.dart' as di;
import 'package:pokedex_egsys/core/error/failures.dart';
import 'package:pokedex_egsys/data/datasources/pokemons_remote_datasource.dart';
import 'package:pokedex_egsys/data/models/podemon_model.dart';
import 'package:pokedex_egsys/data/models/pokemons_response.dart';
import 'package:pokedex_egsys/data/repositories/pokemons_repository_impl.dart';
import 'package:pokedex_egsys/domain/usecases/get_pokemons.dart';

import '../../fixtures/fixture_reader.dart';
import 'pokemons_repository_impl_test.mocks.dart';

@GenerateMocks([PokemonsRemoteDatasource])
void main() {
  late MockPokemonsRemoteDatasource mockPokemonsRemoteDatasource;
  late PokemonsRepositoryImpl pokemonsRepositoryImpl;

  setUp(() async {
    await di.init(isUnitTest: true);
    mockPokemonsRemoteDatasource = MockPokemonsRemoteDatasource();
    pokemonsRepositoryImpl = PokemonsRepositoryImpl(
      mockPokemonsRemoteDatasource,
    );
  });

  group("Get Pokemons", () {
    final getPokemonsParams = GetPokemonsParams(limit: 10, offset: 10);

    final pokemonsResponse = PokemonsResponse.fromJson(
      json.decode(fixture('pokemons_success_response.json'))
          as Map<String, dynamic>,
    );

    final pokemonResponse = PokemonModel.fromJson(
      json.decode(fixture('pokemon_response.json')) as Map<String, dynamic>,
    );

    test('should return a PokemonsResponse when call data is successful',
        () async {
      // arrange

      when(mockPokemonsRemoteDatasource.getPokemonByIdentify(any)).thenAnswer(
        (_) async => Right(pokemonResponse),
      );
      when(mockPokemonsRemoteDatasource.getPokemons(getPokemonsParams))
          .thenAnswer(
        (_) async => Right(pokemonsResponse),
      );

      // act
      final result =
          await pokemonsRepositoryImpl.getPokemons(getPokemonsParams);

      // getPokemonsParams
      verify(mockPokemonsRemoteDatasource.getPokemons(getPokemonsParams));

      expect(result.isRight(), true);
    });

    test(
      'should return server failure when call data is unsuccessful',
      () async {
        // arrange
        when(mockPokemonsRemoteDatasource.getPokemons(getPokemonsParams))
            .thenAnswer(
          (_) async => const Left(
            ServerFailure(''),
          ),
        );

        // act
        final result =
            await pokemonsRepositoryImpl.getPokemons(getPokemonsParams);

        // assert
        verify(mockPokemonsRemoteDatasource.getPokemons(getPokemonsParams));
        expect(result, const Left(ServerFailure('')));
      },
    );
  });

  group("Get Random Pokemon", () {
    final pokemonResponse = PokemonModel.fromJson(
      json.decode(fixture('pokemon_response.json')) as Map<String, dynamic>,
    );

    test('should return a PokemonResponse when call data is successful',
        () async {
      // arrange
      when(mockPokemonsRemoteDatasource.getPokemonByIdentify(any)).thenAnswer(
        (_) async => Right(pokemonResponse),
      );

      // act
      final result = await pokemonsRepositoryImpl.getRandomPokemon();

      // assert
      verify(mockPokemonsRemoteDatasource.getPokemonByIdentify(any));

      expect(result, Right(pokemonResponse.toEntity()));
    });

    test(
      'should return server failure when call data is unsuccessful',
      () async {
        // arrange
        when(mockPokemonsRemoteDatasource.getPokemonByIdentify(any)).thenAnswer(
          (_) async => const Left(
            ServerFailure(''),
          ),
        );

        // act
        final result = await pokemonsRepositoryImpl.getRandomPokemon();

        // assert
        verify(mockPokemonsRemoteDatasource.getPokemonByIdentify(any));
        expect(result, const Left(ServerFailure('')));
      },
    );
  });
}
