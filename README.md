# Minventory

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
