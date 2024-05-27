class Pokemon {
  List<String>? abilities;
  int? weight;
  List<String>? weakness;
  String? number;
  int? height;
  String? description;
  String? name;
  String? thumbnailImage;
  int? id;
  List<String>? type;

  Pokemon({
    this.id,
    this.name,
    this.number,
    this.type,
    this.weakness,
    this.abilities,
    this.weight,
    this.height,
    this.description,
    this.thumbnailImage,
  });

  Pokemon.fromJson(Map<String, dynamic> json) {
    abilities = json['abilities'].cast<String>();
    weight = json['weight'];
    weakness = json['weakness'].cast<String>();
    number = json['number'];
    height = json['height'];
    description = json['description'];
    name = json['name'];
    thumbnailImage = json['thumbnailImage'];
    id = json['id'];
    type = json['type'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['abilities'] = abilities;
    data['weight'] = weight;
    data['weakness'] = weakness;
    data['number'] = number;
    data['height'] = height;
    data['description'] = description;
    data['name'] = name;
    data['thumbnailImage'] = thumbnailImage;
    data['id'] = id;
    data['type'] = type;
    return data;
  }
}

Pokemon bulbasaur = Pokemon(
    id: 1,
    number: "001",
    name: 'Bulbasaur',
    description: 'bla bla bla',
    type: ["grass", "poison"],
    weakness: ["Fire", "Flying", "Ice", "Psychic"],
    thumbnailImage:
        "https://assets.pokemon.com/assets/cms2/img/pokedex/detail/001.png");
