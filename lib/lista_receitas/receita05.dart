import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

var dataObjects = [
  {"name": "La Fin Du Monde", "style": "Tripel", "ibu": "19"},
  {"name": "Sapporo Premium", "style": "Lager", "ibu": "24"},
  {"name": "Duvel", "style": "Belgian Strong Ale", "ibu": "82"},
  {"name": "Guinness Draught", "style": "Stout", "ibu": "45"},
  {"name": "Heineken", "style": "Pale Lager", "ibu": "23"},
  {"name": "Chimay Blue", "style": "Quadrupel", "ibu": "35"},
  {"name": "Brooklyn Lager", "style": "Amber Lager", "ibu": "30"},
  {"name": "Corona Extra", "style": "Pale Lager", "ibu": "18"},
  {"name": "Hoegaarden", "style": "Witbier", "ibu": "13"},
  {"name": "Stone IPA", "style": "India Pale Ale", "ibu": "77"},
  {"name": "Samuel Adams Boston Lager", "style": "Vienna Lager", "ibu": "30"},
  {"name": "Lagunitas IPA", "style": "India Pale Ale", "ibu": "52"},
  {"name": "Blue Moon", "style": "Wheat Ale", "ibu": "9"},
  {"name": "Sierra Nevada Pale Ale", "style": "Pale Ale", "ibu": "38"},
  {"name": "Budweiser", "style": "American Lager", "ibu": "12"},
  {"name": "Beck’s", "style": "Pilsner", "ibu": "23"},
  {"name": "Leffe Blonde", "style": "Blonde Ale", "ibu": "20"},
  {"name": "Peroni", "style": "Euro Lager", "ibu": "24"},
];

class Receita05 extends HookWidget {
  final String titlePage;

  const Receita05({super.key, required this.titlePage});

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
      bottomNavigationBar: MyBottomNavigationBar2(
        itemsBar: [
          {"label": "Café", "icon": Icon(Icons.coffee_outlined)},
          {"label": "Cerveja", "icon": Icon(Icons.local_drink_outlined)},
          {"label": "Nações", "icon": Icon(Icons.flag_outlined)},
        ],
      ),
      body: DataBodyWidget(objects: dataObjects),
    );
  }
}

class MyBottomNavigationBar extends HookWidget {
  final List<Map<String, Object>> itemsBar;

  const MyBottomNavigationBar({super.key, required this.itemsBar});

  @override
  Widget build(BuildContext context) {
    print(this.runtimeType);
    var currentIndex = useState(0);

    return BottomNavigationBar(
      onTap: (index) {
        currentIndex.value = index;
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

class DataBodyWidget extends HookWidget {
  List<Map<String, dynamic>> objects;

  DataBodyWidget({super.key, this.objects = const []});

  @override
  Widget build(BuildContext context) {
    final columnKeys = dataObjects.first.keys.toList();

    return SingleChildScrollView(
      child: DataTable(
        columns:
            columnKeys
                .map(
                  (key) => DataColumn(
                    label: Expanded(child: Text(key.toUpperCase())),
                  ),
                )
                .toList(),
        rows:
            objects
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

// UTILIZANDO STATEFULWIDGET

class MyBottomNavigationBar2 extends StatefulWidget {
  final List<Map<String, Object>> itemsBar;
  MyBottomNavigationBar2({super.key, required this.itemsBar});

  @override
  _MyBottomNavigationBar2State createState() =>
      _MyBottomNavigationBar2State(itemsBar: itemsBar);
}

class _MyBottomNavigationBar2State extends State<MyBottomNavigationBar2> {
  final List<Map<String, Object>> itemsBar;
  var currentIndex = 0;

  _MyBottomNavigationBar2State({required this.itemsBar});

  @override
  Widget build(BuildContext context) {
    print(this.runtimeType);

    return BottomNavigationBar(
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      currentIndex: currentIndex,
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
