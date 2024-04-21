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

  @override
  Widget build(BuildContext context) {
    numbersAsString = pokemonData.type!.join(', ');
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
              child: Container(
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
                      Container(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
