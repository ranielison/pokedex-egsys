class Pokemon {
  int? id;
  String? name;
  int? height;
  int? weight;
  int? order;
  int? baseExperience;
  Sprites? sprites;
  List<Types>? types;
  List<Ability>? abilities;

  Pokemon({
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

  String get pokemonImageUrl {
    List<String> spritesUrl = [];
    if (sprites?.other != null) {
      if (sprites!.other!.home != null) {
        spritesUrl.addAll(sprites!.other!.home!.spritesInOrder());
      }
      if (sprites!.other!.officialArtwork != null) {
        spritesUrl.addAll(
          sprites!.other!.officialArtwork!.spritesInOrder(),
        );
      }
    }
    if (sprites!.frontDefault?.isNotEmpty ?? false) {
      spritesUrl.add(sprites!.frontDefault!);
    }
    if (sprites!.frontFemale?.isNotEmpty ?? false) {
      spritesUrl.add(sprites!.frontFemale!);
    }
    if (sprites!.frontShiny?.isNotEmpty ?? false) {
      spritesUrl.add(sprites!.frontShiny!);
    }
    return spritesUrl.first;
  }
}

class Ability {
  String? name;
  bool? isHidden;
  int? slot;

  Ability({this.name, this.isHidden, this.slot});
}

class Sprites {
  String? backDefault;
  String? backFemale;
  String? backShiny;
  String? backShinyFemale;
  String? frontDefault;
  String? frontFemale;
  String? frontShiny;
  String? frontShinyFemale;
  Other? other;

  Sprites({
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
}

class Other {
  Home? home;
  OfficialArtwork? officialArtwork;

  Other({this.home, this.officialArtwork});
}

class Home {
  String? frontDefault;
  String? frontFemale;
  String? frontShiny;
  String? frontShinyFemale;

  Home({
    this.frontDefault,
    this.frontFemale,
    this.frontShiny,
    this.frontShinyFemale,
  });

  List<String> spritesInOrder() {
    List<String> sprites = [];
    if (frontDefault?.isNotEmpty ?? false) {
      sprites.add(frontDefault!);
    }
    if (frontFemale?.isNotEmpty ?? false) {
      sprites.add(frontFemale!);
    }
    if (frontShiny?.isNotEmpty ?? false) {
      sprites.add(frontShiny!);
    }
    return sprites;
  }
}

class OfficialArtwork {
  String? frontDefault;
  String? frontShiny;

  OfficialArtwork({this.frontDefault, this.frontShiny});

  List<String> spritesInOrder() {
    List<String> sprites = [];
    if (frontDefault?.isNotEmpty ?? false) {
      sprites.add(frontDefault!);
    }

    if (frontShiny?.isNotEmpty ?? false) {
      sprites.add(frontShiny!);
    }
    return sprites;
  }
}

class Types {
  int? slot;
  Ability? type;

  Types({this.slot, this.type});
}
