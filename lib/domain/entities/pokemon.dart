import 'package:equatable/equatable.dart';

class Pokemon extends Equatable {
  final int? id;
  final String? name;
  final int? height;
  final int? weight;
  final int? order;
  final int? baseExperience;
  final Sprites? sprites;
  final List<Type>? types;
  final List<Ability>? abilities;

  const Pokemon({
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

  String? get pokemonImageUrl {
    if (sprites == null) return null;
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

  @override
  List<Object?> get props => [
        id,
        name,
        height,
        weight,
        order,
        baseExperience,
        sprites,
        types,
        abilities,
      ];
}

class Ability extends Equatable {
  final String? name;
  final bool? isHidden;
  final int? slot;

  const Ability({this.name, this.isHidden, this.slot});

  @override
  List<Object?> get props => [
        name,
        isHidden,
        slot,
      ];
}

class Sprites extends Equatable {
  final String? backDefault;
  final String? backFemale;
  final String? backShiny;
  final String? backShinyFemale;
  final String? frontDefault;
  final String? frontFemale;
  final String? frontShiny;
  final String? frontShinyFemale;
  final Other? other;

  const Sprites({
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

  @override
  List<Object?> get props => [
        backDefault,
        backFemale,
        backShiny,
        backShinyFemale,
        frontDefault,
        frontFemale,
        frontShiny,
        frontShinyFemale,
        other,
      ];
}

class Other extends Equatable {
  final Home? home;
  final OfficialArtwork? officialArtwork;

  const Other({this.home, this.officialArtwork});

  @override
  List<Object?> get props => [home, officialArtwork];
}

class Home extends Equatable {
  final String? frontDefault;
  final String? frontFemale;
  final String? frontShiny;
  final String? frontShinyFemale;

  const Home({
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

  @override
  List<Object?> get props => [
        frontDefault,
        frontFemale,
        frontShiny,
        frontShinyFemale,
      ];
}

class OfficialArtwork extends Equatable {
  final String? frontDefault;
  final String? frontShiny;

  const OfficialArtwork({this.frontDefault, this.frontShiny});

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

  @override
  List<Object?> get props => [frontDefault, frontShiny];
}

class Type extends Equatable {
  final int? slot;
  final String? name;

  const Type({this.slot, this.name});

  @override
  List<Object?> get props => [slot, name];
}
