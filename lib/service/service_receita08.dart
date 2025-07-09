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

  void _carregarCervejas({int counter = 10}) {
    rootBundle.loadString("assets/data/beers.json").then((jsonString) {
      var beersJson = jsonDecode(jsonString);
      var beersJsonTake = [];
      for (int i = 0; i < counter; i++) {
        beersJsonTake.add(beersJson[i]);
      }
      tableStateNotifier.value = {
        'stauts': TableStatus.ready,
        'dataObjects': beersJsonTake,
      };
    });
  }

  void _carregarCafe({int counter = 10}) async {
    rootBundle.loadString("assets/data/coffees.json").then((jsonString) {
      var coffeesJson = jsonDecode(jsonString);
      var coffeesJsonTake = [];
      for (int i = 0; i < counter; i++) {
        coffeesJsonTake.add(coffeesJson[i]);
      }
      tableStateNotifier.value = {
        'stauts': TableStatus.ready,
        'dataObjects': coffeesJsonTake,
      };
    });
  }

  void _carregarNacoes({int counter = 10}) {
    rootBundle.loadString("assets/data/countries.json").then((jsonString) {
      var countriesJson = jsonDecode(jsonString);
      var countriesJsonTake = [];
      for (int i = 0; i < counter; i++) {
        countriesJsonTake.add(countriesJson[i]);
      }
      tableStateNotifier.value = {
        'status': TableStatus.ready,
        'dataObjects': countriesJsonTake,
      };
    });
  }
}
