import 'package:equatable/equatable.dart';
import 'package:pokedex_egsys/data/models/podemon_model.dart';

class PokemonsResponse extends Equatable {
  final List<PokemonModel>? pokemons;

  const PokemonsResponse({
    this.pokemons,
  });

  static PokemonsResponse fromJson(Map<String, dynamic> json) {
    return PokemonsResponse(
      pokemons: json['results'] != null
          ? (json['results'] as List)
              .map(
                (i) => PokemonModel.fromJson(i),
              )
              .toList()
          : [],
    );
  }

  static Map<String, dynamic> toJson(PokemonsResponse pokemonsResponse) {
    final Map<String, dynamic> data = {};
    if (pokemonsResponse.pokemons != null) {
      data['pokemons'] = pokemonsResponse.pokemons!
          .map((item) => PokemonModel.toJson(item))
          .toList();
    }

    return data;
  }

  @override
  List<Object?> get props => [pokemons];
}
