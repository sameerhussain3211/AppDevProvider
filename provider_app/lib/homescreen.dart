import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:provider_app/pokemon.dart';

class Homepage extends StatelessWidget {
  Homepage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Pokemon>>(
        future: getData(), // Call getData function here
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            print("the data from snap is  ${snapshot.data}");
            return Center(
              child: Text('Error is: ${snapshot.error}'),
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
                  // pokemonModel pokemon1 = pokemonList[index];
                  return Card(
                    child: Container(
                      color: Colors.amber,
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text("No data available"),
              );
            }
          }
        },
      ),
    );
  }

  Future<List<Pokemon>> getData() async {
    final response = await http.get(Uri.parse(
        'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> pokemonList = data['pokemon'];

      List<Pokemon> pokemons =
          pokemonList.map((json) => Pokemon.fromJson(json)).toList();

      // Now you have a list of Pokemon instances
      // You can use them as needed
      return pokemons; // Return the list of Pokemon
    } else {
      print('Failed to load data: ${response.statusCode}');
      throw Exception("Failed to get data");
    }
  }
}
