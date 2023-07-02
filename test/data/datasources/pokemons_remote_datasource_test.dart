import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:pokedex_egsys/core/api/dio_client.dart';
import 'package:pokedex_egsys/core/di/injection_container.dart' as di;
import 'package:pokedex_egsys/core/error/failures.dart';
import 'package:pokedex_egsys/data/datasources/pokemons_remote_datasource.dart';
import 'package:pokedex_egsys/data/models/pokemons_response.dart';
import 'package:pokedex_egsys/domain/usecases/get_pokemons.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  late PokemonsRemoteDatasourceImpl dataSourceImpl;
  late DioAdapter dioAdapter;

  setUp(() async {
    await di.init(isUnitTest: true);
    dioAdapter = DioAdapter(dio: di.sl<DioClient>().dio);
    dataSourceImpl = PokemonsRemoteDatasourceImpl(di.sl<DioClient>());
  });

  group('Get Pokemons', () {
    final getPokemonsParams = GetPokemonsParams(
      limit: 10,
      offset: 0,
    );

    final getPokemonsResponse = PokemonsResponse.fromJson(
      json.decode(fixture('pokemons_success_response.json'))
          as Map<String, dynamic>,
    );

    test('should return a PokemonResponse object if the status code is 200',
        () async {
      /// arrange
      final decode = json.decode(fixture('pokemons_success_response.json'));

      dioAdapter.onGet(
        '/pomekon',
        (server) => server.reply(
          200,
          decode,
        ),
      );

      /// act
      final result = await dataSourceImpl.getPokemons(getPokemonsParams);

      /// assert
      result.fold(
        (l) => expect(l, null),
        (r) => expect(r, getPokemonsResponse),
      );
    });

    test(
      'should return server faulure when response code is 400',
      () async {
        /// arrange
        dioAdapter.onPost(
          '/pokemon',
          (server) => server.reply(
            400,
            {},
          ),
        );

        /// act
        final result = await dataSourceImpl.getPokemons(getPokemonsParams);

        /// assert
        result.fold(
          (l) => expect(l, isA<ServerFailure>()),
          (r) => expect(r, null),
        );
      },
    );
  });
}
