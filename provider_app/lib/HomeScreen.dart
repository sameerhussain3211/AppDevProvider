import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 60,
              child: Center(
                child: Text(
                  "Pokedex",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
            ),
            Text("hello")
          ],
        ),
      )),
    );
  }
}
