part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetPokemonsEvent extends HomeEvent {}

class SearchPokemonsByName extends HomeEvent {
  final String name;

  const SearchPokemonsByName(this.name);

  @override
  List<Object> get props => [name];
}

class GetRandomPokemonEvent extends HomeEvent {}

class PrepareStateEvent extends HomeEvent {}
