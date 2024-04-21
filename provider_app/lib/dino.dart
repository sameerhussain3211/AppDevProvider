import 'package:flutter/material.dart';
import 'package:provider_app/pokemon.dart';

class Dino extends StatelessWidget {
  final Pokemon pokemonData;
  final String col;
  Dino({required this.pokemonData, required this.col});
  Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("hello"),
      // ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              color: hexToColor(col),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
