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
  static const int _pageSize = 10;
  ItemType _currentType = ItemType.none;

  static const MAX_N_ITEMS = 15;
  static const MIN_N_ITEMS = 3;
  static const DEFAULT_N_ITEMS = 7;

  int _numberOfItems = DEFAULT_N_ITEMS;

  set numberOfItems(n) {
    _numberOfItems =
        n < 0
            ? MIN_N_ITEMS
            : n > MAX_N_ITEMS
            ? MAX_N_ITEMS
            : n;
  }

  DataService() : funcoesCarga = [] {
    funcoesCarga.addAll([
      () => _carregarDados("assets/data/coffees.json", ItemType.coffee),
      () => _carregarDados("assets/data/beers.json", ItemType.beer),
      () => _carregarDados("assets/data/countries.json", ItemType.nation),
    ]);
  }

  void ordenarPor(String campo) {
    List<dynamic> dataAtual = List.from(
      tableStateNotifier.value['dataObjects'],
    );
    dataAtual.sort((a, b) {
      final valA = a[campo]?.toString().toLowerCase() ?? '';
      final valB = b[campo]?.toString().toLowerCase() ?? '';
      return valA.compareTo(valB);
    });

    tableStateNotifier.value = {
      ...tableStateNotifier.value,
      'dataObjects': dataAtual,
    };
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

    final start = _currentCount;
    final end = (_currentCount + _pageSize).clamp(0, _fullData.length);
    _currentCount = end;

    tableStateNotifier.value = {
      'status': TableStatus.ready,
      'dataObjects': [
        ...tableStateNotifier.value['dataObjects'],
        ..._fullData.sublist(start, end),
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
