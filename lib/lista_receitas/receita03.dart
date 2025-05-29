import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Receita03 extends HookWidget {
  final String titlePage;

  const Receita03({super.key, required this.titlePage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: titlePage),
      drawer: Drawer(
        child: Column(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.light_mode),
            ),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.dark_mode),
            ),
          ],
        ),
      ),
      body: DataBodyWidget(
        objects: [
          "La Fin Du Monde - Bock - 65 ibu",

          "Sapporo Premiume - Sour Ale - 54 ibu",

          "Duvel - Pilsner - 82 ibu",
        ],
      ),
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
  List<String> objects;

  DataBodyWidget({super.key, this.objects = const []});

  @override
  Widget build(BuildContext context) {
    List<Expanded> allTheLines =
        objects
            .map((obj) => Expanded(child: Center(child: Text(obj))))
            .toList();

    return Column(
      children: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.arrow_back), Text("Voltar para home")],
          ),
        ),
        ...allTheLines,
      ],
    );
  }
}

class MyAppBar extends HookWidget implements PreferredSizeWidget {
  final String title;

  MyAppBar({super.key, this.title = ""});

  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text(title));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
