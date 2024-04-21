import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider_app/dino.dart';
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

  String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2)}';
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
                  Color c = Colors.blueGrey;
                  if (pokemon.type![0] != null) {
                    if (pokemon.type![0] == 'Bug') {
                      c = Colors.greenAccent;
                    }
                    if (pokemon.type![0] == 'Grass') {
                      c = Colors.lightGreen;
                    }
                    if (pokemon.type![0] == 'Poison') {
                      c = Colors.purpleAccent;
                    }
                    if (pokemon.type![0] == 'Ground') {
                      c = Colors.brown;
                    }
                    if (pokemon.type![0] == 'Psychic') {
                      c = Colors.pinkAccent;
                    }
                    if (pokemon.type![0] == 'Fighting') {
                      c = Colors.yellow;
                    }
                    if (pokemon.type![0] == 'Rock') {
                      c = Colors.indigo;
                    }
                    if (pokemon.type![0] == 'Ghost') {
                      c = Colors.lightBlueAccent;
                    }
                    if (pokemon.type![0] == 'Ice') {
                      c = Colors.blue;
                    }
                    if (pokemon.type![0] == 'Dragon') {
                      c = const Color.fromARGB(255, 161, 11, 1);
                    }

                    if (pokemon.type![0] == 'Fire') {
                      c = Colors.redAccent;
                    }
                    if (pokemon.type![0] == 'Water') {
                      c = Colors.blueAccent;
                    }
                    if (pokemon.type![0] == 'Electric') {
                      c = Colors.yellowAccent;
                    }
                  } else {
                    c = Colors.grey;
                  }

                  return Card(
                    elevation: 5,
                    color: c,
                    margin: EdgeInsets.all(5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Dino(
                            pokemonData: pokemon,
                            col: colorToHex(c),
                          );
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pokemon.name ?? '',
                              textAlign: TextAlign.left,
                            ),
                            Container(
                              height: 30,
                              child: FloatingActionButton(
                                splashColor: Colors.grey,
                                onPressed: () {
                                  // Handle button press
                                },
                                child: Text(
                                  pokemon.type![0],
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 30,
                                ),
                                Image.network(pokemon.img ?? ''),
                              ],
                            )
                          ],
                        ),
                      ),
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
