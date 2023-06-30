import 'package:dartz/dartz.dart';
import 'package:pokedex_egsys/core/api/dio_client.dart';
import 'package:pokedex_egsys/core/error/failures.dart';
import 'package:pokedex_egsys/data/models/get_all_types_response.dart';
import 'package:pokedex_egsys/data/models/get_pokemon_by_types_response.dart';
import 'package:pokedex_egsys/data/models/podemon_model.dart';
import 'package:pokedex_egsys/data/models/pokemons_response.dart';
import 'package:pokedex_egsys/domain/usecases/get_pokemons.dart';

abstract class PokemonsRemoteDatasource {
  Future<Either<Failure, PokemonsResponse>> getPokemons(
      GetPokemonsParams params);

  Future<Either<Failure, PokemonModel>> getPokemonByIdentify(String name);

  Future<Either<Failure, GetPokemonsByTypeResponse>> getPokemonByType(
      String type);

  Future<Either<Failure, GetAllTypesResponse>> getAllTypes();
}

class PokemonsRemoteDatasourceImpl implements PokemonsRemoteDatasource {
  final DioClient _client;

  PokemonsRemoteDatasourceImpl(this._client);

  @override
  Future<Either<Failure, PokemonsResponse>> getPokemons(
      GetPokemonsParams params) async {
    final response = await _client.getRequest(
      params.limit != null && params.offset != null
          ? '/pokemon?limit=${params.limit}&offset=${params.offset}'
          : '/pokemon',
      converter: (response) => PokemonsResponse.fromJson(
        response,
      ),
    );

    return response;
  }

  @override
  Future<Either<Failure, PokemonModel>> getPokemonByIdentify(
      String identify) async {
    final response = await _client.getRequest(
      '/pokemon/$identify',
      converter: (response) => PokemonModel.fromJson(
        response,
      ),
    );

    return response;
  }

  @override
  Future<Either<Failure, GetPokemonsByTypeResponse>> getPokemonByType(
      String type) async {
    final response = await _client.getRequest(
      '/type/$type',
      converter: (response) => GetPokemonsByTypeResponse.fromJson(
        response,
      ),
    );

    return response;
  }

  @override
  Future<Either<Failure, GetAllTypesResponse>> getAllTypes() async {
    final response = await _client.getRequest(
      '/type',
      converter: (response) => GetAllTypesResponse.fromJson(response),
    );

    return response;
  }
}
