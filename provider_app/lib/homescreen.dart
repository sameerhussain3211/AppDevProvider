import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:provider_app/pokemon.dart';

class Homepage extends StatelessWidget {
  Homepage({Key? key});

  Future<List<Pokemon>> fetchPokemonData() async {
    final response = await http.get(Uri.parse(
        "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final List<dynamic> pokemonList = jsonData['pokemon'];

      List<Pokemon> pokemonData = pokemonList
          .map((pokemonJson) => Pokemon.fromJson(pokemonJson))
          .toList();

      return pokemonData;
    } else {
      throw Exception('Failed to load Pokemon data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokemon App1'),
      ),
      body: FutureBuilder<List<Pokemon>>(
        future: fetchPokemonData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<Pokemon>? pokemonList = snapshot.data;
            if (pokemonList != null && pokemonList.isNotEmpty) {
              return GridView.builder(
                itemCount: pokemonList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemBuilder: (context, index) {
                  Pokemon pokemon = pokemonList[index];
                  return Card(
                    child: Column(
                      children: [
                        Image.network(pokemon.img ?? ''),
                        Text(pokemon.name ?? ''),
                      ],
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text("No data available"),
              );
            }
          }
        },
      ),
    );
  }
}
