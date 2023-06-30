// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

enum FilterType { type, search }

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeFailure extends HomeState {}

class HomeSuccess extends HomeState {
  final int page;
  final List<Pokemon> pokemons;
  final List<Pokemon>? filteredPokemons;
  final bool loadingMore;
  final bool enabledFilters;
  final String? pokemonTypeSelected;
  final List<String>? types;
  final FilterType? filterTypeSelected;

  const HomeSuccess({
    required this.pokemons,
    this.filteredPokemons,
    this.page = 1,
    this.loadingMore = false,
    this.enabledFilters = false,
    this.pokemonTypeSelected,
    this.types,
    this.filterTypeSelected = FilterType.search,
  });

  HomeSuccess copyWith({
    List<Pokemon>? pokemons,
    List<Pokemon>? filteredPokemons,
    int? page,
    bool? loadingMore,
    bool? enabledFilters,
    String? pokemonTypeSelected,
    List<String>? types,
    FilterType? filterTypeSelected,
  }) {
    return HomeSuccess(
      page: page ?? this.page,
      pokemons: pokemons ?? this.pokemons,
      filteredPokemons: filteredPokemons ?? this.filteredPokemons,
      loadingMore: loadingMore ?? this.loadingMore,
      enabledFilters: enabledFilters ?? this.enabledFilters,
      pokemonTypeSelected: pokemonTypeSelected ?? this.pokemonTypeSelected,
      types: types ?? this.types,
      filterTypeSelected: filterTypeSelected ?? this.filterTypeSelected,
    );
  }

  @override
  List<Object?> get props => [
        page,
        pokemons,
        filteredPokemons,
        loadingMore,
        enabledFilters,
        pokemonTypeSelected,
        types,
        filterTypeSelected,
      ];
}
