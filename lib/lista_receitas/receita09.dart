import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../service/service_receita08.dart';

class Receita09 extends HookWidget {
  final String titlePage;

  final functionsMap = {
    ItemType.coffee: () => dataService.carregar(0),
    ItemType.beer: () => dataService.carregar(1),
    ItemType.nation: () => dataService.carregar(3),
  };

  Receita09({super.key, required this.titlePage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titlePage, style: Theme.of(context).textTheme.displayLarge),
        actions: [
          PopupMenuButton(
            itemBuilder:
                (_) =>
                    [3, 7, 15]
                        .map(
                          (num) => PopupMenuItem(
                            value: num,

                            child: Text("Carregar $num itens por vez"),
                          ),
                        )
                        .toList(),

            onSelected: (number) {
              dataService.numberOfItems = number;
            },
          ),
        ],
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
              return ListViewBuilderWidget(
                jsonObjects: value['dataObjects'],
                scrollEndedCallback: dataService.carregarMais,
              );
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

class ListViewBuilderWidget extends HookWidget {
  final dynamic _scrollEndedCallback;
  final List<dynamic> jsonObjects;

  ListViewBuilderWidget({
    this.jsonObjects = const [],
    void Function()? scrollEndedCallback,
  }) : _scrollEndedCallback = scrollEndedCallback ?? false;

  @override
  Widget build(BuildContext context) {
    var controler = useScrollController();

    useEffect(() {
      controler.addListener(() {
        if (controler.position.pixels >=
            controler.position.maxScrollExtent - 200) {
          if (_scrollEndedCallback is Function) {
            _scrollEndedCallback();
          }
        }
      });
      return null;
    }, [controler]);

    if (jsonObjects.isEmpty) {
      print(jsonObjects);
      return Center(child: CircularProgressIndicator());
    }

    final jsonObjectsFilters = jsonObjects.cast<Map<String, dynamic>>();
    final columnKeys =
        jsonObjectsFilters.first.keys
            .toList()
            .where((key) => key.toLowerCase() != "uid")
            .toList();

    return ListView.builder(
      controller: controler,
      itemCount: jsonObjectsFilters.length,
      itemBuilder: (context, index) {
        final obj = jsonObjectsFilters[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  columnKeys.map((key) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            key.toUpperCase(),
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 3,
                          child: Text(
                            obj[key]?.toString() ?? '',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
            ),
          ),
        );
      },
    );
  }
}
