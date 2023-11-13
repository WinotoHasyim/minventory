import 'package:flutter/material.dart';
import 'package:minventory/screens/inventory_form.dart';
import 'package:minventory/screens/inventory_list.dart';

class InventoryPrompt {
  final String name;
  final IconData icon;

  InventoryPrompt(this.name, this.icon);
}

class PromptCard extends StatelessWidget {
  final InventoryPrompt item;

  const PromptCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {

    Color backgroundColor;
    if (item.name == "Lihat Item") {
      backgroundColor = Colors.red;
    } else if (item.name == "Tambah Item") {
      backgroundColor = Colors.green;
    } else if (item.name == "Logout") {
      backgroundColor = Colors.blue;
    } else {
      backgroundColor = Colors.indigo;
    }

    return Material(
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));

          // Navigate ke route yang sesuai (tergantung jenis tombol)
          if (item.name == "Tambah Item") {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InventoryFormPage(),
                ));
          }
          else if (item.name == "Lihat Item") {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InventoryListPage(),
                ));
          }

        },
        child: Container(
          // Container untuk menyimpan Icon dan Text
          color: backgroundColor,
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}