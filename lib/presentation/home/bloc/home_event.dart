// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetPokemonsEvent extends HomeEvent {}

class SearchPokemonsByNameEvent extends HomeEvent {
  final String name;

  const SearchPokemonsByNameEvent(this.name);

  @override
  List<Object> get props => [name];
}

class GetPokemonsByTypeEvent extends HomeEvent {
  final String type;

  const GetPokemonsByTypeEvent(this.type);

  @override
  List<Object> get props => [type];
}

class GetRandomPokemonEvent extends HomeEvent {}

class PrepareStateEvent extends HomeEvent {}

class ToggleEnabledFilterEvent extends HomeEvent {}

class ResetFiltersEvent extends HomeEvent {}

class SelectTypeEvent extends HomeEvent {
  final FilterType type;

  const SelectTypeEvent(this.type);

  @override
  List<Object> get props => [type];
}
