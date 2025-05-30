import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DataService {
  final ValueNotifier<List<Map<String, dynamic>>> tableStateNotifier =
      new ValueNotifier([]);

  final List<VoidCallback> funcoesCarga;

  DataService() : funcoesCarga = [] {
    funcoesCarga.addAll([_carregarCafe, _carregarCervejas, _carregarNacoes]);
  }

  void carregar(index) {
    funcoesCarga[index]();
  }

  void _carregarCervejas() {
    tableStateNotifier.value = [
      {"name": "La Fin Du Monde", "style": "Bock", "ibu": "65"},
      {"name": "Sapporo Premiume", "style": "Sour Ale", "ibu": "54"},
      {"name": "Duvel", "style": "Pilsner", "ibu": "82"},
    ];
  }

  void _carregarCafe() {
    tableStateNotifier.value = [
      {"name": "Espresso", "region": "Itália", "intensity": "10"},
      {"name": "Café do Cerrado", "region": "Brasil", "intensity": "7"},
      {"name": "Kopi Luwak", "region": "Indonésia", "intensity": "9"},
    ];
  }

  void _carregarNacoes() {
    tableStateNotifier.value = [
      {"name": "Brasil", "continent": "América do Sul", "population": "214M"},
      {"name": "Japão", "continent": "Ásia", "population": "125M"},
      {"name": "Alemanha", "continent": "Europa", "population": "83M"},
    ];
  }
}

final dataService = DataService();

class Receita06 extends HookWidget {
  final String titlePage;

  const Receita06({super.key, required this.titlePage});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      dataService.carregar(0);
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text(titlePage, style: Theme.of(context).textTheme.displayLarge),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: dataService.tableStateNotifier,
        builder: (_, value, __) {
          return DataTableWidget(jsonObjects: value);
        },
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        itemsBar: [
          {"label": "Café", "icon": Icon(Icons.coffee_outlined)},
          {"label": "Cerveja", "icon": Icon(Icons.local_drink_outlined)},
          {"label": "Nações", "icon": Icon(Icons.flag_outlined)},
        ],
        itemSelectedCallback: dataService.carregar,
      ),
    );
  }
}

class MyBottomNavigationBar extends HookWidget {
  final List<Map<String, Object>> itemsBar;
  var itemSelectedCallback;

  MyBottomNavigationBar({
    super.key,
    required this.itemsBar,
    this.itemSelectedCallback,
  }) {
    itemSelectedCallback ??= (_) {};
  }

  @override
  Widget build(BuildContext context) {
    var currentIndex = useState(0);

    return BottomNavigationBar(
      onTap: (index) {
        currentIndex.value = index;
        itemSelectedCallback(index);
      },
      currentIndex: currentIndex.value,
      items:
          itemsBar.map((item) {
            return BottomNavigationBarItem(
              label: item["label"] as String,
              icon: item["icon"] as Widget,
            );
          }).toList(),
    );
  }
}

class DataTableWidget extends StatelessWidget {
  final List<Map<String, dynamic>> jsonObjects;

  DataTableWidget({this.jsonObjects = const []});

  @override
  Widget build(BuildContext context) {
    if (jsonObjects.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    final columsKeys = jsonObjects.first.keys.toList();

    return DataTable(
      columns:
          columsKeys
              .map(
                (key) => DataColumn(
                  label: Expanded(
                    child: Text(
                      key.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              )
              .toList(),
      rows:
          jsonObjects
              .map(
                (obj) => DataRow(
                  cells:
                      columsKeys
                          .map((key) => DataCell(Text(obj[key].toString())))
                          .toList(),
                ),
              )
              .toList(),
    );
  }
}
