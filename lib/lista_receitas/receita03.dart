import 'package:flutter/material.dart';
import './receita_x.dart';

class Receita03 extends ReceitaX {
  final String titlePage;

  const Receita03({super.key, required this.titlePage})
    : super(title: titlePage);

  @override
  Widget buildBody(BuildContext context) {
    return Text("Receita03");
  }
}
