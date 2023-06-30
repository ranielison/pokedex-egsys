import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pokedex_egsys/core/error/failures.dart';
import 'package:pokedex_egsys/core/usecases/usecase.dart';
import 'package:pokedex_egsys/domain/entities/pokemon.dart';
import 'package:pokedex_egsys/domain/usecases/get_all_types.dart';
import 'package:pokedex_egsys/domain/usecases/get_pokemons.dart';
import 'package:pokedex_egsys/domain/usecases/get_pokemons_by_type.dart';
import 'package:pokedex_egsys/domain/usecases/get_random_pokemon.dart';
import 'package:pokedex_egsys/domain/usecases/searh_pokemon_by_name.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetPokemons getPokemons;
  final GetRandomPokemon getRandomPokemon;
  final SearchPokemonByName searchPokemonByName;
  final GetAllTypes getAllTypes;
  final GetPokemonsByType getPokemonsByType;

  HomeBloc({
    required this.getPokemons,
    required this.getRandomPokemon,
    required this.searchPokemonByName,
    required this.getAllTypes,
    required this.getPokemonsByType,
  }) : super(HomeInitial()) {
    on<PrepareStateEvent>((event, emit) async {
      final data = await getAllTypes(NoParams());

      data.fold((l) {
        if (l is ServerFailure) {}
      }, (r) {
        r.insert(0, "all");
        emit(
          HomeSuccess(
            pokemons: const [],
            filteredPokemons: const [],
            enabledFilters: false,
            types: r,
            pokemonTypeSelected: r.first,
          ),
        );

        add(GetPokemonsEvent());
      });
    });

    on<GetPokemonsEvent>((event, emit) async {
      if ((state as HomeSuccess).loadingMore) return;

      emit((state as HomeSuccess).copyWith(loadingMore: true));

      int page = (state as HomeSuccess).page;

      final data = await getPokemons.call(
        GetPokemonsParams(
          limit: 8,
          offset: page > 1 ? (page - 1) * 8 : 0,
        ),
      );

      data.fold((l) {
        if (l is ServerFailure) {}
      }, (r) {
        emit(
          (state as HomeSuccess).copyWith(
            pokemons: [...(state as HomeSuccess).pokemons, ...r],
            loadingMore: false,
            page: page + 1,
          ),
        );
        if (page == 1) add(GetPokemonsEvent());
      });
    });

    on<GetRandomPokemonEvent>((event, emit) async {
      final pokemon = await getRandomPokemon.call(NoParams());

      pokemon.fold((l) {
        if (l is ServerFailure) {}
      }, (r) {
        emit((state as HomeSuccess).copyWith(randomPokemonSelected: r));
        debugPrint('POKEMON: ${r.name}');
      });
    });

    on<SearchPokemonsByNameEvent>((event, emit) async {
      final pokemon = await searchPokemonByName.call(event.name);
      if (event.name.isEmpty) return;
      pokemon.fold((l) {
        if (l is ServerFailure) {
          emit((state as HomeSuccess).copyWith(filteredPokemons: []));
        }
      }, (r) {
        emit((state as HomeSuccess).copyWith(filteredPokemons: [r]));
      });
    });

    on<SelectTypeEvent>((event, emit) async {
      emit((state as HomeSuccess).copyWith(filterTypeSelected: event.type));
    });

    on<ToggleEnabledFilterEvent>((event, emit) async {
      emit(
        (state as HomeSuccess).copyWith(
          enabledFilters: !(state as HomeSuccess).enabledFilters,
        ),
      );
    });

    on<ResetFiltersEvent>((event, emit) async {
      emit(
        (state as HomeSuccess).copyWith(
          filteredPokemons: [],
          pokemonTypeSelected: 'none',
        ),
      );
    });

    on<GetPokemonsByTypeEvent>((event, emit) async {
      final pokemon = await getPokemonsByType.call(event.type);

      pokemon.fold((l) {
        if (l is ServerFailure) {
          emit((state as HomeSuccess).copyWith(filteredPokemons: []));
        }
      }, (r) {
        emit(
          (state as HomeSuccess).copyWith(
            filteredPokemons: r,
            pokemonTypeSelected: event.type,
          ),
        );
      });
    });
  }
}
