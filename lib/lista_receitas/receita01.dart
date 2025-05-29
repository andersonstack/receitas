import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Receita01 extends HookWidget {
  final String titlePage;

  const Receita01({super.key, required this.titlePage});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> bebidas = [
      {"nome": "La Fin Du Monde", "estilo": "Bock", "ibu": 65},
      {"nome": "Sapporo Premium", "estilo": "Sour Ale", "ibu": 54},
      {"nome": "Duvel", "estilo": "Duvel", "ibu": 82},
    ];
    final expandedItems = useState<Set<int>>({});

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
      body: ListView.builder(
        itemCount: bebidas.length,
        itemBuilder: (BuildContext context, int index) {
          final bebida = bebidas[index];
          final details = expandedItems.value.contains(index);

          return Card(
            child: Column(
              children: [
                ListTile(
                  title: Text(bebida["nome"]),
                  trailing: IconButton(
                    onPressed: () {
                      final newSet = Set<int>.from(expandedItems.value);
                      if (details) {
                        newSet.remove(index);
                      } else {
                        newSet.add(index);
                      }
                      expandedItems.value = newSet;
                    },
                    icon: Icon(details ? Icons.expand_less : Icons.expand_more),
                  ),
                ),
                if (details)
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          "${bebida["estilo"]}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          "${bebida["ibu"]}",
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
    );
  }
}
