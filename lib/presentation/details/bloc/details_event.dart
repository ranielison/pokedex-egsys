part of 'details_bloc.dart';

abstract class DetailsEvent extends Equatable {
  const DetailsEvent();

  @override
  List<Object?> get props => [];
}

class InitDetailsEvent extends DetailsEvent {
  final Pokemon? pokemon;
  final String? identify;

  const InitDetailsEvent({this.pokemon, this.identify});

  @override
  List<Object?> get props => [pokemon, identify];
}

class ResetStateEvent extends DetailsEvent {}
