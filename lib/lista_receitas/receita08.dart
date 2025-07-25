import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../service/service_receita08.dart';

class Receita08 extends HookWidget {
  final String titlePage;

  Receita08({super.key, required this.titlePage});

  @override
  Widget build(BuildContext context) {
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
          switch (value['status']) {
            case TableStatus.idle:
              return Center(child: Text("Toque em algum botão"));
            case TableStatus.loading:
              return CircularProgressIndicator();
            case TableStatus.ready:
              return DataTableWidget(jsonObjects: value['dataObjects']);
            case TableStatus.error:
              return Text("Erro no servidor");
          }
          return LinearProgressIndicator();
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
  final List<Map<String, dynamic>> itemsBar;
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
  final List<dynamic> jsonObjects;

  DataTableWidget({this.jsonObjects = const []});

  @override
  Widget build(BuildContext context) {
    if (jsonObjects.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    final jsonObjectsFilters = jsonObjects.cast<Map<String, dynamic>>();
    final columnKeys =
        jsonObjectsFilters.first.keys
            .toList()
            .where((key) => key.toLowerCase() != "uid")
            .toList();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns:
            columnKeys
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
            jsonObjectsFilters
                .map(
                  (obj) => DataRow(
                    cells:
                        columnKeys
                            .map((key) => DataCell(Text(obj[key].toString())))
                            .toList(),
                  ),
                )
                .toList(),
      ),
    );
  }
}
