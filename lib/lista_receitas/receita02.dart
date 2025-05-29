import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import './receita_x.dart';

class Receita02 extends ReceitaX {
  final String titlePage;

  const Receita02({super.key, required this.titlePage})
    : super(title: titlePage);

  @override
  Widget buildBody(BuildContext context) {
    final List<Map<String, dynamic>> bebidas = [
      {"nome": "La Fin Du Monde", "estilo": "Bock", "ibu": 65},
      {"nome": "Sapporo Premium", "estilo": "Sour Ale", "ibu": 54},
      {"nome": "Duvel", "estilo": "Duvel", "ibu": 82},
    ];

    final expandedItems = useState<Set<int>>({});

    return Scaffold(
      body: ListView.builder(
        itemCount: bebidas.length,
        itemBuilder: (BuildContext context, int index) {
          final bebida = bebidas[index];
          final isExpanded = expandedItems.value.contains(index);

          return Card(
            margin: const EdgeInsets.all(8),
            child: Column(
              children: [
                ListTile(
                  title: Text(bebida["nome"]),
                  trailing: IconButton(
                    onPressed: () {
                      // Atualiza o conjunto de itens expandidos
                      final newSet = Set<int>.from(expandedItems.value);
                      if (isExpanded) {
                        newSet.remove(index);
                      } else {
                        newSet.add(index);
                      }
                      expandedItems.value = newSet;
                    },
                    icon: Icon(
                      isExpanded ? Icons.expand_less : Icons.expand_more,
                    ),
                  ),
                ),
                if (isExpanded)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Estilo: ${bebida["estilo"]}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          "IBU: ${bebida["ibu"]}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
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

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
