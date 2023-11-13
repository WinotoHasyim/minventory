import 'package:flutter/material.dart';
import 'package:minventory/widgets/left_drawer.dart';

class InventoryItem {
  String name;
  int amount;
  String description;

  InventoryItem(this.name, this.amount, this.description);
}

List<InventoryItem> inventoryItemList = [];

class InventoryListPage extends StatelessWidget {
  final List<InventoryItem> items = inventoryItemList;

  InventoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'List Item',
          ),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.deepPurple,
                  child: Text(
                    items[index].name[0],
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(items[index].name),
                subtitle: Text(items[index].description),
                trailing: Text('Jumlah: ${items[index].amount}'),
              ),
            );
          },
        ),
      ),
    );
  }
}
