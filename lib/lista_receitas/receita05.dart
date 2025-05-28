import 'package:flutter/material.dart';
import './receita_x.dart';

class Receita05 extends ReceitaX {
  final String titlePage;

  const Receita05({super.key, required this.titlePage})
    : super(title: titlePage);

  @override
  Widget buildBody(BuildContext context) {
    return Text("Receita05");
  }
}
