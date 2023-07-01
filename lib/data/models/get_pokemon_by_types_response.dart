import 'package:equatable/equatable.dart';

class GetPokemonsByTypeResponse extends Equatable {
  final List<String>? pokemons;

  const GetPokemonsByTypeResponse({required this.pokemons});

  static GetPokemonsByTypeResponse fromJson(Map<String, dynamic> json) {
    final dataList = json['pokemon'] != null
        ? (json['pokemon'] as List)
            .map((item) => item['pokemon']['name'])
            .toList()
        : null;

    return GetPokemonsByTypeResponse(
      pokemons: dataList != null ? List<String>.from(dataList) : null,
    );
  }

  static Map<String, dynamic> toJson(
      GetPokemonsByTypeResponse getPokemonsByTypeResponse) {
    final Map<String, dynamic> data = {};

    data['pokemons'] = getPokemonsByTypeResponse.pokemons;

    return data;
  }

  @override
  List<Object?> get props => [pokemons];
}
