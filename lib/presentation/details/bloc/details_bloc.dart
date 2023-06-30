import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex_egsys/core/error/failures.dart';
import 'package:pokedex_egsys/domain/entities/pokemon.dart';
import 'package:pokedex_egsys/domain/usecases/searh_pokemon_by_name.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final SearchPokemonByName searchPokemonByName;

  DetailsBloc({
    required this.searchPokemonByName,
  }) : super(DetailsInitial()) {
    on<InitDetailsEvent>((event, emit) async {
      if (event.pokemon != null) {
        emit(DetailsSuccess(pokemon: event.pokemon));
      } else {
        emit(DetailsLoading());
        final pokemon = await searchPokemonByName.call(event.identify!);
        pokemon.fold((l) {
          if (l is ServerFailure) {
            emit(DetailsFailure());
          }
        }, (r) {
          emit(DetailsSuccess(pokemon: r));
        });
      }
    });

    on<ResetStateEvent>((event, emit) async {
      emit(DetailsInitial());
    });
  }
}
