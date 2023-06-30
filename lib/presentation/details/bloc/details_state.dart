part of 'details_bloc.dart';

abstract class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object?> get props => [];
}

class DetailsInitial extends DetailsState {}

class DetailsLoading extends DetailsState {}

class DetailsFailure extends DetailsState {}

class DetailsSuccess extends DetailsState {
  final Pokemon? pokemon;

  const DetailsSuccess({
    this.pokemon,
  });

  DetailsSuccess copyWith({
    Pokemon? pokemon,
  }) {
    return DetailsSuccess(
      pokemon: pokemon ?? this.pokemon,
    );
  }

  @override
  List<Object?> get props => [pokemon];
}
