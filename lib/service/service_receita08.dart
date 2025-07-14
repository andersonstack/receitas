import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

final DataService dataService = DataService();

enum ItemType { beer, coffee, nation, none }

enum TableStatus { idle, loading, ready, error }

class DataService {
  final ValueNotifier<Map<String, dynamic>> tableStateNotifier = ValueNotifier({
    'status': TableStatus.idle,
    'dataObjects': [],
    'itemType': ItemType.none,
  });

  final List<VoidCallback> funcoesCarga;

  List<dynamic> _fullData = [];
  int _currentCount = 0;
  static const int _pageSize = 5;
  ItemType _currentType = ItemType.none;

  DataService() : funcoesCarga = [] {
    funcoesCarga.addAll([
      () => _carregarDados("assets/data/coffees.json", ItemType.coffee),
      () => _carregarDados("assets/data/beers.json", ItemType.beer),
      () => _carregarDados("assets/data/countries.json", ItemType.nation),
    ]);
  }

  void carregar(int index) {
    _currentCount = 0;
    _fullData = [];
    _currentType = ItemType.values[index];

    tableStateNotifier.value = {
      'status': TableStatus.loading,
      'dataObjects': [],
      'itemType': _currentType,
    };

    funcoesCarga[index]();
  }

  void carregarMais() {
    if (_fullData.isEmpty || _currentCount >= _fullData.length) return;

    final nextCount = (_currentCount + _pageSize).clamp(0, _fullData.length);

    _currentCount = nextCount;

    tableStateNotifier.value = {
      'status': TableStatus.ready,
      'dataObjects': [
        ...tableStateNotifier.value['dataObjects'],
        ..._fullData.sublist(_currentCount, nextCount),
      ],
      'itemType': _currentType,
    };
  }

  void _carregarDados(String path, ItemType tipo) async {
    try {
      final jsonString = await rootBundle.loadString(path);
      _fullData = jsonDecode(jsonString);
      _currentType = tipo;

      _currentCount = (_pageSize).clamp(0, _fullData.length);

      tableStateNotifier.value = {
        'status': TableStatus.ready,
        'dataObjects': _fullData.sublist(0, _currentCount),
        'itemType': tipo,
      };
    } catch (e) {
      tableStateNotifier.value = {
        'status': TableStatus.error,
        'dataObjects': [],
        'itemType': tipo,
      };
    }
  }
}
