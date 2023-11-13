# Minventory

<details>
<summary>Tugas 8 PBP</summary>
<br>

## Cara implementasi poin-poin pada tugas

1. Buatlah 2 direktori baru pada `lib` bernama `screens`, kemudian pindahkan file `menu.dart` ke dalam direktori `screens`.

2. Buatlah file baru bernama `left_drawer.dart` pada direktori `widgets`.

3. pada file tersebut, lakukan import:
```
import 'package:flutter/material.dart';
import 'package:minventory/screens/menu.dart';
```
Selanjutnya, isi kode berikut:
```
class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepPurple,
            ),
            child: Column(
              children: [
                Text(
                  'Minventory',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text(
                  "Kelola item milik anda!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Halaman Utama'),
            // Bagian redirection ke MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
```
Kode ini berfungsi membuat sebuah drawer yang memiliki header dan deskripsi dari app Minventory ini. Selain itu, drawer ini akan memiliki `ListTile` yang jika ditekan akan memunculkan screen halaman utama

4. Pada file `menu.dart`, tambahkan import dan kode berikut:
```
...
import 'package:minventory/widgets/left_drawer.dart';
...
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Minventory',
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      // Masukkan drawer sebagai parameter nilai drawer dari widget Scaffold
      drawer: const LeftDrawer(),
...
```
Hal yang ditambahkan di `Scaffold` ini adalah drawer, yang berarti pada halaman utama ini nantinya muncul drawer.

5. Pada direktori `screens`, buat file baru bernama `inventory_form.dart` dan isilah kode berikut pada file tersebut:
```
import 'package:flutter/material.dart';
import 'package:minventory/widgets/left_drawer.dart';

class InventoryFormPage extends StatefulWidget {
  const InventoryFormPage({super.key});

  @override
  State<InventoryFormPage> createState() => _InventoryFormPageState();
}

class _InventoryFormPageState extends State<InventoryFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  int _amount = 0;
  String _description = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Form Tambah Item',
          ),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Nama Item",
                      labelText: "Nama Item",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _name = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Nama tidak boleh kosong!";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Jumlah Item",
                      labelText: "Jumlah Item",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _amount = int.parse(value!);
                        });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Jumlah Item tidak boleh kosong!";
                      }
                      if (int.tryParse(value) == null) {
                        return "Jumlah Item harus berupa angka!";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Deskripsi",
                      labelText: "Deskripsi",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _description = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Deskripsi tidak boleh kosong!";
                      }
                      return null;
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(Colors.deepPurple),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Item berhasil tersimpan'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text('Nama: $_name'),
                                      Text('Jumlah: $_amount'),
                                      Text('Deskripsi: $_description')
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                          _formKey.currentState!.reset();
                        }
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}
```
Kode diatas berfungsi membuat Stateful Widget bernama `InventoryFormPage` yang berupa screen/halaman untuk membuat Item sesuai data-data (nama, jumlah, deskripsi) yang kita input untuk Item tersebut. Halaman Form ini juga akan menampilkan drawer. `_formKey` disini berfungsi sebagai handler dari form state, validasi form, dan penyimpanan form. Setiap perubahan pada field/data Item akan mengupdate variabel field/data pada class `InventoryFormPage`. Input dari user juga akan divalidasi sesuai dengan tipe data field yang diinput dengan `validator`. Selain itu, ketika tombol save ditekan, maka sebuah pop-up akan muncul yang berisi Item dan field dari Item yang kita input

6. Pada file `menu.dart` Tambahkan kode baru pada widget `PromptCard` sehingga terlihat seperti berikut:
```
...
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
...
```
Kode ini bertujuan agar tombol dengan nama `Tambah Item` menampilkan Halaman Form

7. Buatlah file baru bernama `prompt_card.dart` pada direktori `widgets`

8. Di file `menu.dart` tadi, pindahkan widget `InventoryPrompt` dan `PromptCard` ke file `prompt_card.dart`. Kemudian, tambahkan import pada awal file `prompt_card.dart`:
```
import 'package:flutter/material.dart';
import 'package:minventory/screens/inventory_form.dart';
...
```
Di file `menu.dart` juga, lakukan import pada awal file:
```
...
import 'package:minventory/widgets/prompt_card.dart';
...
```

9. Tambahkan routing pada `left_drawer.dart` untuk Halaman Utama dan Halaman Form:
```
...
ListTile(
    leading: const Icon(Icons.home_outlined),
    title: const Text('Halaman Utama'),
    // Bagian redirection ke MyHomePage
    onTap: () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(),
          ));
    },
),
ListTile(
    leading: const Icon(Icons.add_box_rounded),
    title: const Text('Tambah Item'),
    // Bagian redirection ke ShopFormPage
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const InventoryFormPage(),
        ));
    },
)
...
```

10. Import Halaman Form ke `left_drawer.dart`:
```
import 'package:flutter/material.dart';
import 'package:minventory/screens/menu.dart';
import 'package:minventory/screens/inventory_form.dart';
...
```

11. (Penjelasan Bonus) Buatlah sebuah file baru bernama `inventory_list.dart` pada direktory `screens` dan isi kode berikut pada file:
```
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
```
Di kode tersebut, didefinisikan objek model `InventoryItem`. Selain itu, terdapat list yang menyimpan objek InventoryItem dan list tersebut awalnya kosong. Kemudian ada widget `InventoryListPage` yang berfungsi menampilkan list item yang kita punya menggunakan `ListView.builder`

12. (Penjelasan Bonus) Pada file `left_drawer.dart`, import `inventory_list.dart`:
```
import 'package:flutter/material.dart';
import 'package:minventory/screens/menu.dart';
import 'package:minventory/screens/inventory_form.dart';
import 'package:minventory/screens/inventory_list.dart';
...
```
Setelah itu, tambahkan `ListTile` yang berfungsi sebagai route ke halaman list Item (ListTile diantara Halaman Utama dan Halaman Form):
```
...
ListTile(
    leading: const Icon(Icons.home_outlined),
    title: const Text('Halaman Utama'),
    // Bagian redirection ke MyHomePage
    onTap: () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(),
          ));
    },
),
ListTile(
    leading: const Icon(Icons.check_box),
    title: const Text('Lihat Item'),
    // Bagian redirection ke ShopFormPage
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InventoryListPage(),
          ));
    },
),
ListTile(
    leading: const Icon(Icons.add_box_rounded),
    title: const Text('Tambah Item'),
    // Bagian redirection ke ShopFormPage
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const InventoryFormPage(),
        ));
    },
),
...
```

13. (Penjelasan Bonus) Pada file `inventory_form.dart`, import `inventory_list.dart`:
```
import 'package:flutter/material.dart';
import 'package:minventory/widgets/left_drawer.dart';
import 'package:minventory/screens/inventory_list.dart';
...
```
Setelah itu, tambahkan function baru pada widget `build` di file `inventory_form.dart`:
```
...
Widget build(BuildContext context) {
    void saveItem() {
      InventoryItem newInventoryItem = InventoryItem(_name, _amount, _description);
      inventoryItemList.add(newInventoryItem);
}
...
```
Function di atas berfungsi untuk menambahkan item baru ke `inventoryItemList`. Tambahkan implementasi function tersebut pada tombol Save sehingga kode seperti berikut:
```
...
Align(
  alignment: Alignment.bottomCenter,
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
        MaterialStateProperty.all(Colors.deepPurple),
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          saveItem();
...
```

14. (Penjelasan Bonus) Pada file `prompt_card.dart`, import `inventory_list.dart`:
```
import 'package:flutter/material.dart';
import 'package:minventory/screens/inventory_form.dart';
import 'package:minventory/screens/inventory_list.dart';
...
```
Setelah itu, tambahkan routing untuk Halaman List Item agar ketika tombol `Lihat Item` diklik, screen akan menampilkan halaman List Item:
```
...
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
...
```

15. Lakukan `add`-`commit`-`push` ke GitHub

## Pertanyaan

### Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement(), disertai dengan contoh mengenai penggunaan kedua metode tersebut yang tepat!

Perbedaan antara `Navigator.push()` dan `Navigator.pushReplacement()` terletak pada apa yang dilakukan kepada route yang berada pada atas stack `Navigator`. `push()` akan menambahkan route baru diatas route yang sudah ada pada atas stack, sedangkan `pushReplacement()` menggantikan route yang sudah ada pada atas stack dengan route baru tersebut. Dalam proyek flutter `minventory` ini, `pushReplacement()` digunakan pada saat tombol `Halaman Utama` pada drawer diklik. Hal ini membuat route yang sekarang dipakai (misalnya halaman form) diganti dengan route halaman utama. Akibatnya, jika ditekan tombol back, maka route yang sekarang dipakai bukanlah route halaman form tadi, tetapi route lain (misalnya list item), atau bisa juga keluar dari app. Selain itu, `push()` digunakan pada saat tombol `Tambah Item` pada drawer diklik. Hal ini membuat route tambah item berada di atas route yang sekarang dipakai (misalnya halaman utama) sehingga route yang sekarang dipakai adalah route tambah item. Ketika user menekan tombol back, maka route yang akan dipakai sekarang adalah route tadi (route halaman utama).

### Jelaskan masing-masing layout widget pada Flutter dan konteks penggunaannya masing-masing!

Single-child layout widgets:

- Container: widget dasar yang dapat mengandung widget lain dan menyediakan kontrol atas propertinya seperti margin, padding, dan dekorasi. Digunakan untuk mengelompokkan dan mengatur widget lain, 

- Center: widget yang menempatkan widget anak di tengah parent widget. Digunakan untuk memusatkan widget anak di tengah parent

- Align: widget untuk menempatkan widget anak di posisi yang dapat diatur. Digunakan untuk mengatur posisi widget anak dengan presisi.

- Expanded: widget yang memperluas anak-anaknya dalam widget Flex (seperti Column atau Row) untuk mengisi ruang yang tersedia. Digunakan untuk memberikan bagian proporsional dari ruang kepada setiap widget dalam Flex.

- FractionallySizedBox: widget yang menempatkan satu anak (child) di dalamnya dengan ukuran relatif terhadap ukuran parentnya. Digunakan untuk membuat widget anak mengambil sebagian dari ukuran parent widget.

- SizedBox: widget yang memaksakan ukuran tetap pada satu anak. Digunakan untuk menentukan ukuran widget anak dengan tepat.

- AspectRatio: widget yang mempertahankan rasio aspek dari satu anak (child) di dalamnya. Digunakan untuk mempertahankan rasio aspek pada widget anak.

Multi-child layout widget:

- Row dan Column: Row adalah widget yang menyusun widget anaknya secara horizontal, sedangkan Column menyusun widget anaknya secara vertikal. Digunakan untuk menyusun elemen-elemen sejajar atau bertumpuk dalam satu arah.

- ListView: widget yang mengatur anak-anaknya dalam daftar bergulir. Dapat digunakan untuk menampilkan daftar item atau elemen dalam satu arah (vertikal atau horizontal). Digunakan untuk menampilkan daftar item yang mungkin sangat panjang sehingga perlu di-scroll.

- GridView: widget yang menyusun anak-anaknya dalam suatu grid. Dapat digunakan untuk menampilkan data dalam format grid. Digunakan untuk menampilkan item dalam format grid, seperti galeri gambar atau produk.

- Stack: widget yang menempatkan anak-anaknya di atas satu sama lain. Anak-anak tersebut dapat diatur secara relatif terhadap tata letak stack. Digunakan untuk menumpuk widget, memberikan lapisan visual seperti overlay atau elemen yang saling tumpang tindih.

- Wrap: widget yang menyusun anak-anaknya dalam baris dan kolom sesuai dengan ruang yang tersedia. Digunakan untuk menempatkan widget dalam baris dan kolom, dan ingin widget tersebut melibatkan baris/kolom baru jika tidak cukup ruang.

### Sebutkan apa saja elemen input pada form yang kamu pakai pada tugas kali ini dan jelaskan mengapa kamu menggunakan elemen input tersebut!

- TextFormField untuk Nama dan Deskripsi Item: Digunakan untuk mengambil input teks dari user, khususnya untuk nama item dan deskripsi item. TextFormField memberikan interface input teks dengan validasi yang mudah diimplementasikan.

- TextFormField untuk Jumlah Item: Digunakan untuk mengambil input teks dari user untuk jumlah item. TextFormField juga digunakan di sini karena memungkinkan validasi dan konversi ke tipe data numerik.

### Bagaimana penerapan clean architecture pada aplikasi Flutter?

Penerapan Clean Architecture pada aplikasi Flutter melibatkan pembagian kode menjadi tiga lapisan utama:

- Lapisan Presentasi (Presentation Layer): Ini adalah lapisan yang bertanggung jawab untuk tampilan dan interaksi pengguna. Di Flutter, ini termasuk widget, pages, dan manajemen state seperti `Provider`, `Riverpod`, atau `Bloc`.

- Lapisan Bisnis (Domain Layer): Ini adalah lapisan yang berisi aturan bisnis dan logika aplikasi. Tidak bergantung pada framework atau teknologi tertentu.
  - Implementasi:
    - Entities: Mendefinisikan objek bisnis atau entitas.
    - Use Cases: Mendefinisikan aturan bisnis atau skenario penggunaan.
    - Repositories: Menentukan kontrak antarmuka untuk mengakses data.

- Lapisan Data (Data Layer): Ini adalah lapisan yang bertanggung jawab untuk mengakses data dari berbagai sumber seperti API, database, atau penyimpanan lokal.
  - Implementasi:
    - Data Sources: Mengimplementasikan cara akses data (remote dan local).
    - Repositories Implementation: Mengimplementasikan kontrak dari repository di lapisan domain.

</details>

<details>
<summary>Tugas 7 PBP</summary>
<br>

## Cara implementasi poin-poin pada tugas

1. Pada cmd, masuk ke direktori di mana proyek flutter akan disimpan

2. Pada cmd, jalankan perintah berikut untuk membuat proyek Flutter baru sekaligus pergi ke direktori proyek tersebut:
```
    flutter create minventory
    cd minventory
```

3. Jalankan proyek melalui cmd:
```
    flutter run
```

4. Buka IDE dan buka direktori proyek Flutter sebelumnya

5. Buatlah file baru bernama `menu.dart` pada direktori `shopping_list/lib` dan tambahkan kode:
```
    import 'package:flutter/material.dart';
```

6. Cut kode yang mengandung class `MyHomePage` dan `_MyHomePageState` pada file `main.dart` ke `menu.dart`

7. Lakukan import di file `main.dart` agar tidak terdapat error:
```
    import 'package:minventory/menu.dart';
```

8. Ubah kode pada class `MyApp` di file `main.dart` agar menjadi seperti berikut:
```
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}
```
Di class ini, hal-hal yang diubah adalah title (menjadi 'Flutter App'), colorScheme (menjadi `ColorScheme.fromSeed(seedColor: Colors.deepPurple)`), dan home (menjadi `MyHomePage()` saja)

9. Pada file `menu.dart` ubah kode pada class `MyHomePage` menjadi seperti berikut:
```
class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final List<ItemBox> items = [
    ItemBox("Lihat Item", Icons.checklist),
    ItemBox("Tambah Item", Icons.add_box_rounded),
    ItemBox("Logout", Icons.logout),
  ];

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'minventory',
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        // Widget wrapper yang dapat discroll
        child: Padding(
          padding: const EdgeInsets.all(10.0), // Set padding dari halaman
          child: Column(
            // Widget untuk menampilkan children secara vertikal
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                child: Text(
                  'Mobile Inventory', // Text yang menandakan inventory
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Grid layout
              GridView.count(
                // Container pada card kita.
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: items.map((ItemBox item) {
                  // Iterasi untuk setiap itemBox
                  return Card(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```
Disini Sifat widget diubah dari Stateful menjadi Stateless, `({super.key, required this.title})` menjadi `({Key? key}) : super(key: key)`, dan menghapus `final String title`. Background color dari Appbar juga diganti menjadi `backgroundColor: Colors.deepPurple` dan `title` Appbar menjadi `minventory`. Selain itu, didefinisikan juga List dari itemBox yang menjadi kumpulan Box-box atau sebuah tombol

10. Tambahkan kode berikut untuk mendefinisikan class `ItemBox`:
```
class ItemBox {
  final String name;
  final IconData icon;

  ItemBox(this.name, this.icon);
}
```

11. (Sekaligus implementasi Bonus) Karena `Card` masih belum didefinisikan, maka dibuat class `Card` yang isinya akan menjadi seperti berikut:
```
class Card extends StatelessWidget {
  final ItemBox item;

  const Card(this.item, {super.key}); // Constructor

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
```
Class ini digunakan untuk menampilkan tombol-tombol pada app sesuai dengan nama dan icon dari instance `ItemBox`. Selain itu, jika tombol-tombol diklik, maka akan muncul Snackbar berisi sebuah pesan.

(Penjelasan Bonus) Agar tombol-tombol memiliki warna yang berbeda, pada class tersebut kita tambah kode:
```
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
```
yang akan menginisialisasi backgroundColor sesuai dengan nama dari ItemBox. Selanjutnya, dalam `Container()` kita tambahkan kode `color: backgroundColor,` untuk membuat warna dari container menjadi warna yang didefinisikan pada `backgroundColor`

12. Lakukan `add-commit-push` dengan command berikut pada cmd:
```
git add .
git commit -m "<pesan commit>"
git push -u origin main
```

## Pertanyaan

### Apa perbedaan utama antara stateless dan stateful widget dalam konteks pengembangan aplikasi Flutter?

Stateless Widget:
- Tidak punya state, yang artinya dia tidak berubah karena ada event pada stateless widget tersebut, tetapi dia dapat berubah ketika ada event pada parent widget
- Flow perubahan stateless widget adalah ketika input data pada parent widget berubah maka child stateless widget akan berubah juga berdasarkan input data yang diterima. 
- propertiesnya menggunakan `final`

Stateful Widget:
- Punya state, yang artinya dia bisa berubah karena dilakukan event pada stateful widget tersebut.
- Flow perubahan stateful widget adalah pada awalnya, input data pertama akan dikirimkan ke Child Stateful Widget dan kemudian ke Widget State. Jika dilakukan event pada Child Stateful widget tersebut, maka akan ada perubahan state pada widget tersebut yang berpotensi menyebabkan perubahan data pada widget tersebut. Widget akan kemudian merender ulang dengan sendirinya.

### Sebutkan seluruh widget yang kamu gunakan untuk menyelesaikan tugas ini dan jelaskan fungsinya masing-masing.

- `MaterialApp`: digunakan untuk menginisialisasi aplkasi Flutter, menentukan tema serta halaman awal aplikasi.
- `Scaffold`: digunakan untuk mengatur kerangka aplikasi yang mencakup `AppBar`, `body`, dll.
- `AppBar`: komponen yang digunakan untuk menampilkan bagian atas aplikasi yang biasanya berisi judul aplikasi atau halaman.
- `SingleChildScrollView`: memungkinkan kontennya dapat discroll
- `Padding`: memberikan padding
- `Column`: digunakan untuk menata widget-child secara vertikal, sehingga elemen-elemen ditampilkan secara berurutan dari atas ke bawah.
- `GridView`: digunakan untuk menampilkan data dalam bentuk grid.
- `InkWell`: memberikan efek visual saat elemen tersebut diklik atau ditekan.
- `Icon`: menampilkan ikon sesuai dengan item yang ditampilkan.
- `Text`: digunakan untuk menampilkan teks.
- `SnackBar`: digunakan untuk menampilkan pesan singkat di bagian bawah layar ketika suatu tindakan dilakukan.
- `MyApp`: titik masuk aplikasi Flutter. Widget ini merupakan turunan dari StatelessWidget yang berarti konfigurasinya tidak berubah sepanjang waktu.
- `Container`: digunakan untuk mengkombinasikan beberapa widget menjadi satu.

</details>
