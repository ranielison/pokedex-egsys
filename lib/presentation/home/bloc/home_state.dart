// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {
  final int page;
  final List<Pokemon> pokemons;
  final bool loadingMore;

  const HomeInitial({
    required this.pokemons,
    this.page = 1,
    this.loadingMore = false,
  });

  HomeInitial copyWith({
    List<Pokemon>? pokemons,
    int? page,
    bool? loadingMore,
  }) {
    return HomeInitial(
      page: page ?? this.page,
      pokemons: pokemons ?? this.pokemons,
      loadingMore: loadingMore ?? this.loadingMore,
    );
  }

  @override
  List<Object> get props => [page, pokemons, loadingMore];
}

class HomeLoading extends HomeState {}

class HomeFailure extends HomeState {}
