import 'package:flutter/material.dart';
import './receita_x.dart';

class Receita06 extends ReceitaX {
  final String titlePage;

  const Receita06({super.key, required this.titlePage})
    : super(title: titlePage);

  @override
  Widget buildBody(BuildContext context) {
    return Text("Receita06");
  }
}
