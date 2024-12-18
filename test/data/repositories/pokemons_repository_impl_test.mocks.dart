// Mocks generated by Mockito 5.4.2 from annotations
// in pokedex_egsys/test/data/repositories/pokemons_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:pokedex_egsys/core/error/failures.dart' as _i5;
import 'package:pokedex_egsys/data/datasources/pokemons_remote_datasource.dart'
    as _i3;
import 'package:pokedex_egsys/data/models/get_all_types_response.dart' as _i10;
import 'package:pokedex_egsys/data/models/get_pokemon_by_types_response.dart'
    as _i9;
import 'package:pokedex_egsys/data/models/podemon_model.dart' as _i8;
import 'package:pokedex_egsys/data/models/pokemons_response.dart' as _i6;
import 'package:pokedex_egsys/domain/usecases/get_pokemons.dart' as _i7;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [PokemonsRemoteDatasource].
///
/// See the documentation for Mockito's code generation for more information.
class MockPokemonsRemoteDatasource extends _i1.Mock
    implements _i3.PokemonsRemoteDatasource {
  MockPokemonsRemoteDatasource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.PokemonsResponse>> getPokemons(
          _i7.GetPokemonsParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPokemons,
          [params],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, _i6.PokemonsResponse>>.value(
                _FakeEither_0<_i5.Failure, _i6.PokemonsResponse>(
          this,
          Invocation.method(
            #getPokemons,
            [params],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.PokemonsResponse>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i8.PokemonModel>> getPokemonByIdentify(
          String? name) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPokemonByIdentify,
          [name],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, _i8.PokemonModel>>.value(
                _FakeEither_0<_i5.Failure, _i8.PokemonModel>(
          this,
          Invocation.method(
            #getPokemonByIdentify,
            [name],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i8.PokemonModel>>);
  @override
  _i4.Future<
      _i2.Either<_i5.Failure, _i9.GetPokemonsByTypeResponse>> getPokemonByType(
          String? type) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPokemonByType,
          [type],
        ),
        returnValue: _i4.Future<
                _i2.Either<_i5.Failure, _i9.GetPokemonsByTypeResponse>>.value(
            _FakeEither_0<_i5.Failure, _i9.GetPokemonsByTypeResponse>(
          this,
          Invocation.method(
            #getPokemonByType,
            [type],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i9.GetPokemonsByTypeResponse>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i10.GetAllTypesResponse>> getAllTypes() =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllTypes,
          [],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, _i10.GetAllTypesResponse>>.value(
                _FakeEither_0<_i5.Failure, _i10.GetAllTypesResponse>(
          this,
          Invocation.method(
            #getAllTypes,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i10.GetAllTypesResponse>>);
}
