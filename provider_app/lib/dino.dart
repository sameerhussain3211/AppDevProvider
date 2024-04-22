import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider_app/pokemon.dart';

class Dino extends StatelessWidget {
  final Pokemon pokemonData;
  final String col;
  Dino({required this.pokemonData, required this.col});
  Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  String numbersAsString = '.';
  String weakness = '.';
  String prev = '';
  String nextEv = '';

  @override
  Widget build(BuildContext context) {
    numbersAsString = pokemonData.type!.join(', ');
    weakness = pokemonData.weaknesses!.join(', ');
    if (pokemonData.prevEvolution != null) {
      for (int i = 0; i < pokemonData.prevEvolution!.length; i++) {
        prev = prev + " " + pokemonData.prevEvolution![i].name.toString();
      }
    }
    if (pokemonData.nextEvolution != null) {
      for (int i = 0; i < pokemonData.nextEvolution!.length; i++) {
        nextEv = nextEv + " " + pokemonData.nextEvolution![i].name.toString();
      }
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: hexToColor(col),
      ),
      body: Container(
        color: hexToColor(col),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: SizedBox(
                // color: hexToColor(col),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            child: Text(
                              pokemonData.name ?? '',
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            width: 165,
                          ),
                          SizedBox(
                            child: Text(
                              "#${pokemonData.id} ",
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(62, 158, 158, 158),
                            ),
                            height: 30,
                            child: Text(
                              "$numbersAsString",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                          width: 200,
                          child: Image.network(
                            pokemonData.img ?? '',
                            fit: BoxFit.cover,
                          )),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text("Name"),
                          const SizedBox(
                            width: 100,
                          ),
                          Text(
                            pokemonData.name ?? '',
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text("Height"),
                          const SizedBox(
                            width: 99,
                          ),
                          Text(
                            pokemonData.height ?? '',
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text("Weight"),
                          const SizedBox(
                            width: 99,
                          ),
                          Text(
                            pokemonData.weight ?? '',
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text("Spawn Time"),
                          const SizedBox(
                            width: 65,
                          ),
                          Text(
                            pokemonData.spawnTime ?? '',
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text("Weakness"),
                          const SizedBox(
                            width: 75,
                          ),
                          Text(
                            "$weakness",
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text("Pre Evolution"),
                          const SizedBox(
                            width: 55,
                          ),
                          Container(
                            child: Text(
                              "$prev",
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text("Next Evolution"),
                          const SizedBox(
                            width: 50,
                          ),
                          Container(
                            child: Text(
                              "$nextEv",
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
