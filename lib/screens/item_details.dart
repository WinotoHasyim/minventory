import 'package:flutter/material.dart';
import 'package:minventory/models/item.dart';
import 'package:minventory/widgets/left_drawer.dart';

class ItemDetailsPage extends StatelessWidget {
  final Item item;

  const ItemDetailsPage(this.item, {Key? key}) : super(key: key); // Constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              item.fields.name,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Amount: ${item.fields.amount}',
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Description: ',
            ),
            const SizedBox(height: 8.0),
            Text(
              item.fields.description,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}
