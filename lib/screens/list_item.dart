// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:minventory/widgets/left_drawer.dart';
import 'package:minventory/models/item.dart';
import 'package:minventory/screens/login.dart';
import 'item_details.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({Key? key}) : super(key: key);

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  Future<List<Item>> fetchItem() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var url = Uri.parse("https://winoto-hasyim-tugas.pbp.cs.ui.ac.id/json/");
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Item
    List<Item> list_item = [];
    for (var d in data) {
      if (d != null) {
        Item item = Item.fromJson(d);
        if (item.fields.user == loggedInUser?.id){
          list_item.add(item);
        }
      }
    }
    return list_item;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Item'),
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
        drawer: const LeftDrawer(),
        body: FutureBuilder(
            future: fetchItem(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return const Column(
                    children: [
                      Text(
                        "Tidak ada data item.",
                        style:
                            TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) {
                        return Card(
                          child: ListTile(

                            leading: CircleAvatar(
                              backgroundColor: Colors.deepPurple,
                              child: Text(
                                "${snapshot.data![index].fields.name[0]}",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text("${snapshot.data![index].fields.name}"),
                            subtitle: Text("${snapshot.data![index].fields.description}"),
                            trailing: Text('Jumlah: ${snapshot.data![index].fields.amount}'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ItemDetailsPage(snapshot.data![index]),
                                  ));
                            },
                          ),
                        );
                      },
                    ),
                  );
                }
              }
            }));
  }
}
