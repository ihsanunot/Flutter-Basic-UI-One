# Gesture Detector

- Membuat widget dapat merespon gestur tap.
- Membuat widget dapat merespon gestur double tap.
- Membuat widget dapat merespon gestur long press.
- Membuat widget dapat merespon gestur drag & pan.

![ss drag](https://github.com/ihsanunot/Flutter-Basic-UI-One/assets/127992374/bce18ad2-0a44-40c7-a9c6-30245aea6947)


**Template Pertama di main.dart**

```
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gesture Detect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Text('test'),
    );
  }
}

class DeteksiGesture extends StatefulWidget {
  @override
  _DeteksiGestureState createState() => _DeteksiGestureState();
}

class _DeteksiGestureState extends State<DeteksiGesture> {
  final double boxSize = 150.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gesture Detected'),
      ),
      body: Center(
        child: Container(
          width: boxSize,
          height: boxSize,
          decoration: BoxDecoration(color: Colors.red),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.yellow,
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Taps : 0 - Double Taps : 0 - Long Press : 0',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}

```
Buat Container merah dapat mendeteksi gestur atau interaksi dari pengguna. 

Bungkus widget Container tersebut ke dalam widget GestureDetector.

```
child: GestureDetector(
  child: Container(
    width: boxSize,
    height: boxSize,
    decoration: BoxDecoration(color: Colors.red),
  ),
),
```

Agar Container dapat mendeteksi gestur tap untuk mengubah state dan menampilkan berapa kali Container telah di-tap.

Tambahkan variabel baru yang berperan sebagai state. Letakkan variabel berikut di luar method build().

```
int numTaps = 0;
```
Tambahkan parameter onTap pada GestureDetector untuk mengubah state dari numTaps.

```
GestureDetector(
  onTap: () {
    setState(() {
      numTaps++;
    });
  },
  child: Container(...),
),
```
Kemudian tampilkan nilai dari variabel numTaps.

```
Text(
  'Taps: $numTaps - Double Taps: 0 - Long Press: 0',
  style: Theme.of(context).textTheme.headline6,
),
```
Langkah berikutnya yang akan kita lakukan adalah merespon ketika ada gestur double tap. 

GestureDetector memiliki parameter onDoubleTap untuk merespon gestur tersebut. Dengan cara yang sama, buatlah agar Container dapat menangani gestur double tap.

```
// Variabel state
int numDoubleTaps = 0;
 
// Parameter onDoubleTap untuk mendeteksi gestur double tap
GestureDetector(
  onTap: () {...},
  onDoubleTap: () {
    setState(() {
      numDoubleTaps++;
    });
  },
  child: Container(...),
),
 
 
// Menampilkan state ke dalam Text
Text(
  'Taps: $numTaps - Double Taps: $numDoubleTaps - Long Press: 0',
  style: Theme.of(context).textTheme.headline6,
),
```

Sebagai tantangan, tambahkan fitur untuk mendeteksi gestur long press!

Setelah membuat Container memiliki gestur sentuhan, sekarang kita akan mengimplementasikan gestur yang memungkinkan Container dapat bergeser atau berpindah posisi. 

Namun, ada beberapa perubahan yang perlu kita lakukan terlebih dulu. Yang pertama adalah ubah widget Center menjadi Stack. 

Widget Stack adalah widget untuk layouting yang mirip dengan Row atau Column, bedanya Stack menyusun widget secara bertumpuk. 

Karena Stack dapat memiliki beberapa child widget, maka gunakanlah parameter children.

```
body: Stack(
  children: [
    GestureDetector(...),
  ],
),
```

Secara default posisi widget di bawah Stack akan berada di pojok kiri atas. Anda dapat mengatur posisi child widget dari Stack dengan widget Positioned.

```
body: Stack(
  children: [
    Positioned(
      child: GestureDetector(...),
    ),
  ],
),
```

Positioned memiliki parameter untuk mengatur jarak widget dengan sisi atas, bawah, kanan, mau pun kiri. 

Untuk itu, kita akan mengubah posisi Container agar berada di tengah. 

Cara awalnya, buat dua variabel doubleyang menyimpan koordinat posisi.

```
double posX = 0.0;
double posY = 0.0;
```

Kemudian buatlah fungsi pada kelas _MyHomePageStateuntuk mendapatkan posisi tengah dari layar.

```
void center(BuildContext context) {
  posX = (MediaQuery.of(context).size.width / 2) - boxSize / 2;
  posY = (MediaQuery.of(context).size.height / 2) - boxSize / 2 - 30;
 
 
  setState(() {
    this.posX = posX;
    this.posY = posY;
  });
}
```

MediaQuery akan mendapatkan informasi terkait media yang digunakan, apakah itu ukuran layar perangkat mobile atau jendela browser.

Kita panggil fungsi tersebut sebelum Flutter membangun membangun widget untuk ditampilkan.

```
@override
Widget build(BuildContext context) {
  if (posX == 0) {
    center(context);
  }
  
  return Scaffold(...);
}
```

Selanjutnya kita gunakan nilai variabel posX dan posYsebagai posisi dari widget di dalam Stack.
```
Positioned(
  top: posY,
  left: posX,
  child: GestureDetector(...),
),
```

Gestur pertama yang akan kita terapkan adalah dengan drag secara vertikal. 

Di dalam widget GestureDetector kita gunakan parameter onVerticalDragUpdate untuk mendapatkan perubahan setiap terjadi pergeseran pointer. 

Perhatikan di sini parameter tersebut berisi fungsi dengan satu parameter yaitu DragUpdateDetails.

Untuk percobaan mari kita tampilkan dulu nilai details-nya ke konsol.

```
onVerticalDragUpdate: (DragUpdateDetails details) {
  print(details);
},
```

Jalankan aplikasi lalu seret Container secara vertikal. Konsol dari IDE akan menampilkan log berisi pergeseran Offset atau posisi koordinat.

Untuk mengubah posisi dari Container kita ambil nilai Offset tersebut lalu menambahkannya ke nilai koordinat saat ini. Untuk mendapatkan nilai Offset tersebut gunakan kode seperti berikut:

```
onVerticalDragUpdate: (DragUpdateDetails details) {
  setState(() {
    double delta = details.delta.dy;
    posY += delta;
  });
},
```

Untuk pergeseran secara horizontal, gunakan cara yang sama namun menggunakan koordinat dan delta x.

```
onHorizontalDragUpdate: (DragUpdateDetails details) {
  setState(() {
    double delta = details.delta.dx;
    posX += delta;
  });
},
```

Gesture drag terbatas pada satu pergerakan secara horizontal atau vertikal. 

Agar widget dapat merespon drag secara vertikal dan horizontal bersamaan gunakan gesture pan. Gesture drag dan pan tidak dapat digunakan bersamaan, sehingga Anda dapat menghapus parameter untuk dragvertikal dan horizontal.

```
onPanUpdate: (DragUpdateDetails details) {
  setState(() {
    double deltaX = details.delta.dx;
    double deltaY = details.delta.dy;
    posX += deltaX;
    posY += deltaY;
  });
},
```

---
Referensi :
- https://api.flutter.dev/flutter/widgets/Stack-class.html
- https://codingwithdhrumil.com/2021/03/gesture-detector-in-flutter-with-example.html
- https://api.flutter.dev/flutter/dart-ui/Offset-class.html
