import 'package:flutter/material.dart';
import './receita_x.dart';

class Receita02 extends ReceitaX {
  final String titlePage;

  const Receita02({super.key, required this.titlePage})
    : super(title: titlePage);

  @override
  Widget buildBody(BuildContext context) {
    return Text("Receita02");
  }
}
