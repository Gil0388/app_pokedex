import 'package:flutter/material.dart';

import 'package:pokedex/classes/pokedex_api.dart';
import 'classes/pokemon.dart';
import 'styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const PokedexPage(),
    );
  }
}

class PokedexPage extends StatefulWidget {
  const PokedexPage({super.key});

  @override
  State<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {
  PokedexApi api = PokedexApi();
  List<Pokemon> pokedex = [];

  @override
  void initState() {
    api.fetchDelayed().then((value) {
      setState(() => pokedex = value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: blue,
        titleTextStyle: titleTextStyle,
        title: const Text('Pokedex'),
        actions: const [
          Image(image: NetworkImage(pokeballLink), width: 30, height: 30)
        ],
      ),
      body: SafeArea(
        child: pokedex.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: pokedex.length,
                itemBuilder: (context, index) => Card(
                  color: white,
                  surfaceTintColor: white,
                  child: ListTile(
                    leading: Image(
                        image: NetworkImage(pokedex[index].thumbnailImage!)),
                    title: Text(pokedex[index].name!),
                    trailing: Text('#${pokedex[index].number!}'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PokemonCard(pokemon: pokedex[index])));
                    },
                  ),
                ),
              ),
      ),
    );
  }
}

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: blue,
        titleTextStyle: titleTextStyle,
        iconTheme: iconTheme,
        title: Text(pokemon.name!),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Card(
          margin: const EdgeInsets.all(10),
          elevation: 5,
          color: white,
          surfaceTintColor: white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                pokemonImageCard(pokemon),
                spacer,
                Text(pokemon.description!),
                spacer,
                informationRow('Tipo:', pokemon.type!),
                spacer,
                informationRow('Fraqueza:', pokemon.weakness!)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget pokemonImageCard(Pokemon pokemon) {
  return SizedBox(
    width: double.infinity,
    child: Card(
      margin: const EdgeInsets.all(0),
      elevation: 0,
      color: Colors.grey.shade300,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '#${pokemon.number}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            SizedBox(
              width: double.infinity,
              child: Image(
                height: imageSize,
                width: imageSize,
                image: NetworkImage(pokemon.thumbnailImage!),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget informationRow(String info, List<String> infoList) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(info, style: pokemonInfoStyle),
      Row(children: [
        for (String item in infoList)
          Row(
            children: [Text(item), const SizedBox(width: 5)],
          ),
      ])
    ],
  );
}

SizedBox spacer = const SizedBox(height: 30);
TextStyle pokemonInfoStyle = const TextStyle(fontWeight: FontWeight.bold);
double imageSize = 150;
