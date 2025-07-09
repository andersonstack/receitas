import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

final DataService dataService = DataService();

enum TableStatus { idle, loading, ready, error }

class DataService {
  final ValueNotifier<Map<String, dynamic>> tableStateNotifier = ValueNotifier({
    'status': TableStatus.idle,
    'dataObjects': [],
  });
  final List<VoidCallback> funcoesCarga;

  DataService() : funcoesCarga = [] {
    funcoesCarga.addAll([_carregarCafe, _carregarCervejas, _carregarNacoes]);
  }

  void carregar(index) {
    funcoesCarga[index]();
    tableStateNotifier.value = {
      'stauts': TableStatus.loading,
      'dataObjects': [],
    };
  }

  void _carregarCervejas() {
    rootBundle.loadString("assets/data/beers.json").then((jsonString) {
      var beersJson = jsonDecode(jsonString);
      // var beersJsonTake = [];
      tableStateNotifier.value = {
        'stauts': TableStatus.ready,
        'dataObjects': beersJson,
      };
    });
  }

  void _carregarCafe() async {
    rootBundle.loadString("assets/data/coffees.json").then((jsonString) {
      var coffeesJson = jsonDecode(jsonString);
      tableStateNotifier.value = {
        'stauts': TableStatus.ready,
        'dataObjects': coffeesJson,
      };
    });
  }

  void _carregarNacoes() {
    rootBundle.loadString("assets/data/countries.json").then((jsonString) {
      var countriesJson = jsonDecode(jsonString);
      tableStateNotifier.value = {
        'status': TableStatus.ready,
        'dataObjects': countriesJson,
      };
    });
  }
}
