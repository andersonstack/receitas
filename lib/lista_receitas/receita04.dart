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

class Receita04 extends HookWidget {
  final String titlePage;

  const Receita04({super.key, required this.titlePage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: titlePage),
      body: MytitleWidget(
        objects: dataObjects,
      ), //DataBodyWidget(objects: dataObjects),
      bottomNavigationBar: MyBottomNavigationBar(
        itemsBar: [
          {"label": "Café", "icon": Icon(Icons.coffee_outlined)},
          {"label": "Cerveja", "icon": Icon(Icons.local_drink_outlined)},
          {"label": "Nações", "icon": Icon(Icons.flag_outlined)},
        ],
      ),
    );
  }
}

class MyBottomNavigationBar extends HookWidget {
  final List<Map<String, Object>> itemsBar;

  const MyBottomNavigationBar({super.key, required this.itemsBar});

  void botaoFoiTocado(int index) {
    print("Tocam no botão $index");
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: botaoFoiTocado,
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

class MytitleWidget extends HookWidget {
  List<Map<String, dynamic>> objects;

  MytitleWidget({super.key, this.objects = const []});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children:
          objects
              .map(
                (obj) => ListTile(
                  title: Text(obj["name"]),
                  subtitle: Text(obj["style"]),
                  trailing: Text(obj["ibu"]),
                ),
              )
              .toList(),
    );
  }
}

class MyAppBar extends HookWidget implements PreferredSizeWidget {
  final String title;

  MyAppBar({super.key, this.title = ""});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: Theme.of(context).textTheme.displayLarge),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
