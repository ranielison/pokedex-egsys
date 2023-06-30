import 'package:pokedex_egsys/domain/entities/pokemon.dart';

class PokemonModel {
  int? id;
  String? name;
  int? height;
  int? weight;
  int? order;
  int? baseExperience;
  SpritesModel? sprites;
  List<TypeModel>? types;
  List<AbilityModel>? abilities;

  PokemonModel({
    this.id,
    this.name,
    this.height,
    this.weight,
    this.order,
    this.baseExperience,
    this.sprites,
    this.types,
    this.abilities,
  });

  Pokemon toEntity() => Pokemon(
        id: id,
        name: name,
        height: height,
        weight: weight,
        order: order,
        baseExperience: baseExperience,
        sprites: sprites?.toEntity(),
        types: types?.map((item) => item.toEntity()).toList(),
        abilities: abilities?.map((item) => item.toEntity()).toList(),
      );

  static PokemonModel fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      id: json['id'],
      name: json['name'],
      height: json['height'],
      weight: json['weight'],
      order: json['order'],
      baseExperience: json['base_experience'],
      sprites: json['sprites'] != null
          ? SpritesModel.fromJson(json['sprites'])
          : null,
      types: json['types'] != null
          ? (json['types'] as List)
              .map((item) => TypeModel.fromJson(item))
              .toList()
          : null,
      abilities: json['abilities'] != null
          ? (json['abilities'] as List)
              .map((item) => AbilityModel.fromJson(item))
              .toList()
          : null,
    );
  }

  static Map<String, dynamic> toJson(PokemonModel pokemonModel) {
    final Map<String, dynamic> data = {};
    data['id'] = pokemonModel.id;
    data['name'] = pokemonModel.name;
    data['height'] = pokemonModel.height;
    data['weight'] = pokemonModel.weight;
    data['order'] = pokemonModel.order;
    data['base_experience'] = pokemonModel.baseExperience;

    if (pokemonModel.sprites != null) {
      data['sprites'] = SpritesModel.toJson(pokemonModel.sprites!);
    }

    if (pokemonModel.types != null) {
      data['types'] =
          pokemonModel.types!.map((v) => TypeModel.toJson(v)).toList();
    }
    if (pokemonModel.abilities != null) {
      data['abilities'] =
          pokemonModel.abilities!.map((v) => AbilityModel.toJson(v)).toList();
    }
    return data;
  }
}

class AbilityModel {
  String? name;
  bool? isHidden;
  int? slot;

  AbilityModel({this.name, this.isHidden, this.slot});

  Ability toEntity() => Ability(
        name: name,
        isHidden: isHidden,
        slot: slot,
      );

  static AbilityModel fromJson(Map<String, dynamic> json) {
    return AbilityModel(
      name: json['ability'] != null ? json['ability']['name'] : null,
      isHidden: json['is_hidden'],
      slot: json['slot'],
    );
  }

  static Map<String, dynamic> toJson(AbilityModel abilityModel) {
    final Map<String, dynamic> data = {};
    data['name'] = abilityModel.name;
    data['is_hidden'] = abilityModel.isHidden;
    data['slot'] = abilityModel.slot;
    return data;
  }
}

class SpritesModel {
  String? backDefault;
  String? backFemale;
  String? backShiny;
  String? backShinyFemale;
  String? frontDefault;
  String? frontFemale;
  String? frontShiny;
  String? frontShinyFemale;
  OtherModel? other;

  SpritesModel({
    this.backDefault,
    this.backFemale,
    this.backShiny,
    this.backShinyFemale,
    this.frontDefault,
    this.frontFemale,
    this.frontShiny,
    this.frontShinyFemale,
    this.other,
  });

  Sprites toEntity() => Sprites(
        backDefault: backDefault,
        backFemale: backFemale,
        backShiny: backShiny,
        backShinyFemale: backShinyFemale,
        frontDefault: frontDefault,
        frontFemale: frontFemale,
        frontShiny: frontShiny,
        frontShinyFemale: frontShinyFemale,
        other: other?.toEntity(),
      );

  static SpritesModel fromJson(Map<String, dynamic> json) {
    return SpritesModel(
      backDefault: json['back_default'],
      backFemale: json['back_female'],
      backShiny: json['back_shiny'],
      backShinyFemale: json['back_shiny_female'],
      frontDefault: json['front_default'],
      frontFemale: json['front_female'],
      frontShiny: json['front_shiny'],
      frontShinyFemale: json['front_shiny_female'],
      other: json['other'] != null ? OtherModel.fromJson(json['other']) : null,
    );
  }

  static Map<String, dynamic> toJson(SpritesModel spritesModel) {
    final Map<String, dynamic> data = {};
    data['back_default'] = spritesModel.backDefault;
    data['back_female'] = spritesModel.backFemale;
    data['back_shiny'] = spritesModel.backShiny;
    data['back_shiny_female'] = spritesModel.backShinyFemale;
    data['front_default'] = spritesModel.frontDefault;
    data['front_female'] = spritesModel.frontFemale;
    data['front_shiny'] = spritesModel.frontShiny;
    data['front_shiny_female'] = spritesModel.frontShinyFemale;
    if (spritesModel.other != null) {
      data['other'] = OtherModel.toJson(spritesModel.other!);
    }

    return data;
  }
}

class OtherModel {
  HomeModel? home;
  OfficialArtworkModel? officialArtwork;

  OtherModel({this.home, this.officialArtwork});

  Other toEntity() => Other(
        home: home?.toEntity(),
        officialArtwork: officialArtwork?.toEntity(),
      );

  static OtherModel fromJson(Map<String, dynamic> json) {
    return OtherModel(
      home: json['home'] != null ? HomeModel.fromJson(json['home']) : null,
      officialArtwork: json['official-artwork'] != null
          ? OfficialArtworkModel.fromJson(json['official-artwork'])
          : null,
    );
  }

  static Map<String, dynamic> toJson(OtherModel otherModel) {
    final Map<String, dynamic> data = {};

    if (otherModel.home != null) {
      data['home'] = HomeModel.toJson(otherModel.home!);
    }
    if (otherModel.officialArtwork != null) {
      data['official-artwork'] = OfficialArtworkModel.toJson(
        otherModel.officialArtwork!,
      );
    }
    return data;
  }
}

class HomeModel {
  String? frontDefault;
  String? frontFemale;
  String? frontShiny;
  String? frontShinyFemale;

  HomeModel({
    this.frontDefault,
    this.frontFemale,
    this.frontShiny,
    this.frontShinyFemale,
  });

  Home toEntity() => Home(
        frontDefault: frontDefault,
        frontFemale: frontFemale,
        frontShiny: frontShiny,
        frontShinyFemale: frontShinyFemale,
      );

  static HomeModel fromJson(Map<String, dynamic> json) {
    return HomeModel(
      frontDefault: json['front_default'],
      frontFemale: json['front_female'],
      frontShiny: json['front_shiny'],
      frontShinyFemale: json['front_shiny_female'],
    );
  }

  static Map<String, dynamic> toJson(HomeModel homeModel) {
    final Map<String, dynamic> data = {};
    data['front_default'] = homeModel.frontDefault;
    data['front_female'] = homeModel.frontFemale;
    data['front_shiny'] = homeModel.frontShiny;
    data['front_shiny_female'] = homeModel.frontShinyFemale;
    return data;
  }
}

class OfficialArtworkModel {
  String? frontDefault;
  String? frontShiny;

  OfficialArtworkModel({this.frontDefault, this.frontShiny});

  OfficialArtwork toEntity() => OfficialArtwork(
        frontDefault: frontDefault,
        frontShiny: frontShiny,
      );

  static OfficialArtworkModel fromJson(Map<String, dynamic> json) {
    return OfficialArtworkModel(
      frontDefault: json['front_default'],
      frontShiny: json['front_shiny'],
    );
  }

  static Map<String, dynamic> toJson(
      OfficialArtworkModel officialArtworkModel) {
    final Map<String, dynamic> data = {};
    data['front_default'] = officialArtworkModel.frontDefault;
    data['front_shiny'] = officialArtworkModel.frontShiny;
    return data;
  }
}

class TypeModel {
  int? slot;
  String? name;

  TypeModel({this.slot, this.name});

  Type toEntity() => Type(
        slot: slot,
        name: name,
      );

  static TypeModel fromJson(Map<String, dynamic> json) {
    return TypeModel(
      slot: json['slot'],
      name: json['type'] != null ? json['type']['name'] : null,
    );
  }

  static Map<String, dynamic> toJson(TypeModel typeModel) {
    final Map<String, dynamic> data = {};
    data['slot'] = typeModel.slot;
    if (typeModel.name != null) {
      data['type'] = typeModel.name;
    }
    return data;
  }
}
