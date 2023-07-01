import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex_egsys/core/api/dio_client.dart';
import 'package:pokedex_egsys/data/datasources/pokemons_remote_datasource.dart';
import 'package:pokedex_egsys/data/repositories/pokemons_repository_impl.dart';
import 'package:pokedex_egsys/domain/repositories/pokemons_repository.dart';
import 'package:pokedex_egsys/domain/usecases/get_all_types.dart';
import 'package:pokedex_egsys/domain/usecases/get_pokemons.dart';
import 'package:pokedex_egsys/domain/usecases/get_pokemons_by_type.dart';
import 'package:pokedex_egsys/domain/usecases/get_random_pokemon.dart';
import 'package:pokedex_egsys/domain/usecases/searh_pokemon_by_name.dart';
import 'package:pokedex_egsys/presentation/details/bloc/details_bloc.dart';
import 'package:pokedex_egsys/presentation/home/bloc/home_bloc.dart';

GetIt sl = GetIt.instance;

Future<void> init({bool isUnitTest = false}) async {
  /// For unit testing only
  if (isUnitTest) {
    WidgetsFlutterBinding.ensureInitialized();
    sl.reset();
    // ignore: invalid_use_of_visible_for_testing_member

    sl.registerSingleton<DioClient>(DioClient(isUnitTest: true));
    dataSources();
    repositories();
    useCase();
    bloc();
  } else {
    sl.registerSingleton<DioClient>(DioClient());
    dataSources();
    repositories();
    useCase();
    bloc();
  }
}

/// Register repositories
void repositories() {
  sl.registerLazySingleton<PokemonsRepository>(
    () => PokemonsRepositoryImpl(sl()),
  );
}

/// Register dataSources
void dataSources() {
  sl.registerLazySingleton<PokemonsRemoteDatasource>(
    () => PokemonsRemoteDatasourceImpl(sl()),
  );
}

void useCase() {
  sl.registerLazySingleton(() => GetPokemons(sl()));
  sl.registerLazySingleton(() => GetRandomPokemon(sl()));
  sl.registerLazySingleton(() => SearchPokemonByName(sl()));
  sl.registerLazySingleton(() => GetAllTypes(sl()));
  sl.registerLazySingleton(() => GetPokemonsByType(sl()));
}

void bloc() {
  sl.registerFactory(
    () => HomeBloc(
      getPokemons: sl(),
      getRandomPokemon: sl(),
      searchPokemonByName: sl(),
      getAllTypes: sl(),
      getPokemonsByType: sl(),
    ),
  );

  sl.registerFactory(
    () => DetailsBloc(
      searchPokemonByName: sl(),
    ),
  );
}
