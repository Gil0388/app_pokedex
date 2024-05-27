import 'package:flutter/material.dart';
import 'package:pokedex/classes/pokedex_api.dart';

import '../classes/pokemon.dart';

class PokemonPresenter extends ChangeNotifier {
  PokemonPresenter(this.api);

  late PokedexApi api;

  List<Pokemon> pokedex = [];

  void getPokemons() async {
    pokedex = await api.fetchPokedex();
    notifyListeners();
  }
}
