import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../service/service_receita07.dart';

class Receita07 extends HookWidget {
  final String titlePage;

  Receita07({super.key, required this.titlePage});

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
    final columnsKeysFilter = columsKeys.where(
      (element) => element.toLowerCase() != "uid",
    );
    final jsonObjectosFilter = jsonObjects.where((element) => element != "uid");

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns:
            columnsKeysFilter
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
            jsonObjectosFilter
                .map(
                  (obj) => DataRow(
                    cells:
                        columnsKeysFilter
                            .map((key) => DataCell(Text(obj[key].toString())))
                            .toList(),
                  ),
                )
                .toList(),
      ),
    );
  }
}
