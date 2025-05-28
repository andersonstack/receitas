import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import './styles/theme_data.dart';
import './lista_receitas/receita01.dart';
import './lista_receitas/receita02.dart';
import './lista_receitas/receita03.dart';
import './lista_receitas/receita04.dart';
import './lista_receitas/receita05.dart';
import './lista_receitas/receita06.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyStyles.aplyTheme(),
      initialRoute: "/home",
      routes: {
        "/home": (_) => Home(),
        "/receita01": (_) => Receita01(titlePage: "Receita 01"),
        "/receita02": (_) => Receita02(titlePage: "Receita 02"),
        "/receita03": (_) => Receita03(titlePage: "Receita 03"),
        "/receita04": (_) => Receita04(titlePage: "Receita 04"),
        "/receita05": (_) => Receita05(titlePage: "Receita 05"),
        "/receita06": (_) => Receita06(titlePage: "Receita 06"),
      },
    );
  }
}

class Home extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> receitas = [
      {'rota': '/receita01'},
      {'rota': '/receita02'},
      {'rota': '/receita03'},
      {'rota': '/receita04'},
      {'rota': '/receita05'},
      {'rota': '/receita06'},
    ];

    return Scaffold(
      appBar: AppBar(title: Text("Receitas de POO")),
      body: ListView(
        children:
            receitas.map((receita) {
              final rota = receita['rota'] as String;

              return Row(
                children: [
                  Text(
                    "Receita ${rota[rota.length - 1]} ${rota.replaceAll(rota, "Receita ")}",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, rota);
                    },
                    icon: Icon(Icons.arrow_right),
                  ),
                ],
              );
            }).toList(),
      ),
    );
  }
}
