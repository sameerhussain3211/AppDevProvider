import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
// import 'package:flutter/widgets.dart';
import 'package:provider_app/pokemon.dart';

class Homepage extends StatelessWidget {
  Homepage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Pokemon>>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
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
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  Pokemon pokemon = pokemonList[index];
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
    final response =
        await http.get(Uri.parse('https://api.spacexdata.com/v3/missions'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body.toString()) as List;
      List<Pokemon> products =
          jsonResponse.map((e) => Pokemon.fromJson(e)).toList();

      return products;
    } else {
      throw Exception("Failed to get data");
    }
  }
}
