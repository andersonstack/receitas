import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

final DataService dataService = DataService();

class DataService {
  final ValueNotifier<List<Map<String, dynamic>>> tableStateNotifier =
      ValueNotifier([]);
  final List<VoidCallback> funcoesCarga;

  DataService() : funcoesCarga = [] {
    funcoesCarga.addAll([_carregarCafe, _carregarCervejas, _carregarNacoes]);
  }

  void carregar(index) {
    funcoesCarga[index]();
  }

  Future<List<dynamic>> loadJsonFromAssets(String filePath) async {
    String jsonString = await rootBundle.loadString(filePath);
    return jsonDecode(jsonString);
  }

  Future<void> _carregarCervejas() async {
    List<dynamic> jsonData = await loadJsonFromAssets('assets/data/beers.json');
    tableStateNotifier.value =
        jsonData.cast<Map<String, dynamic>>().take(5).toList();
  }

  Future<void> _carregarCafe() async {
    List<dynamic> jsonData = await loadJsonFromAssets(
      'assets/data/coffes.json',
    );
    tableStateNotifier.value =
        jsonData.cast<Map<String, dynamic>>().take(5).toList();
  }

  Future<void> _carregarNacoes() async {
    List<dynamic> jsonData = await loadJsonFromAssets(
      'assets/data/countrys.json',
    );
    tableStateNotifier.value =
        jsonData.cast<Map<String, dynamic>>().take(5).toList();
  }
}
