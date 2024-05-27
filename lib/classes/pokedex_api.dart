import 'dart:async';
import 'dart:convert';

import 'pokemon.dart';
import 'package:http/http.dart' as http;

class PokedexApi {
  Future<List<Pokemon>> fetchPokedex() async {
    var client = http.Client();
    try {
      final uri = Uri.parse(
        'https://rafaelbarbosatec.github.io/api/pokemon/pokemons.json',
      );

      var response = await client.get(uri);
      List<Pokemon> pokedex = [];

      if (response.statusCode == 200) {
        final List<dynamic> json = const JsonDecoder().convert(response.body);
        pokedex =
            json.map<Pokemon>((value) => Pokemon.fromJson(value)).toList();
      }

      return pokedex;
    } catch (e) {
      return [];
    }
  }
}
