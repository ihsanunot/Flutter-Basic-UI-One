# Belajar Flutter Lagi

## Layout Constraints

Flutter memiliki constraint atau batasan dalam menyusun layout.

Aturan utama dalam layouting Flutter tertulis dalam dokumentasinya 

Jadi suatu widget akan memiliki constraints dari parent widget-nya. 

**Constraints ini merupakan 4 properti lain:**

- Lebar minimum dan lebar maksimum lalu tinggi minimum dan tinggi maksimum. 

- Nilai constraints ini akan diturunkan ke seluruh widget di bawahnya.

Widget child dapat menentukan ukurannya dengan batasan constraint dari widget parent-nya. Setelah mengetahui ukuran widget di bawahnya, selanjutnya parent widget dapat menentukan posisi koordinatnya.

Posisi widget pada Flutter menggunakan sistem koordinat sumbu x dan y, di mana titik pusatnya (0, 0) berada di ujung kiri atas layar.

---

### Contoh :

```
import 'package:flutter/material.dart';
 
void main() {
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }
}
```

Jalankan kode di atas pada perangkat atau emulator Anda. Seharusnya sudah cukup jelas bahwa seluruh layar akan berwarna merah. 

Di sini layar perangkat atau root dari widget menginginkan widget di bawahnya untuk tampil sama persis dengan ukuran layar.

Jika anda Menambahkan width dan height nya :

```
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      width: 100,
      height: 100,
    );
  }
}
```

Jalankan perubahan dengan memanfaatkan fitur hot reload. Tidak akan terjadi perubahan meskipun kita menentukan tinggi dan lebar dari Container. Ini disebabkan karena constraints yang diberikan root widget yaitu minimum width dan minimum height yang harus sama dengan ukuran layar.

Lalu bagaimana agar Container tampil sesuai ukuran yang kita tentukan? Ada beberapa cara yang bisa digunakan. Konsep intinya adalah dengan membungkus Container dengan widget lain yang memiliki constraints minimum yang lebih kecil. Salah satu contohnya adalah widget Center.

```
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.red,
        width: 100,
        height: 100,
      ),
    );
  }
}
```
Center akan memenuhi layar sesuai constraints dari parent widget-nya (root). Namun, karena Center tidak menampilkan apa pun di layar, maka kita hanya akan melihat layar hitam.

Center memiliki constraints 0 pixel hingga maksimal sama dengan ukuran layar. Karena itulah Container dapat tampil sesuai ukuran yang ditentukan, yaitu 100 x 100.

Sesuai namanya, Center akan meletakkan Container di posisi tengah dari layar. Jika Anda lihat kode bagaimana widget Center dibangun dengan cara Ctrl + klik nama widget Center, Anda akan menemukan bahwa Center merupakan turunan dari widget lain bernama Align.

```
class Center extends Align {
  /// Creates a widget that centers its child.
  const Center({ Key key, double widthFactor, double heightFactor, Widget child })
    : super(key: key, widthFactor: widthFactor, heightFactor: heightFactor, child: child);
}
```

Mari kita ubah widget Center menjadi Align. Dengan Align ada satu parameter tambahan yang dapat kita gunakan yaitu alignment. Di sini kita dapat mengatur nilai alignment mulai dari -1 hingga 1. 

Anda bisa saja menggunakan nilai yang lebih atau pun kurang namun akan membuat posisi widget di bawahnya berada di luar ukuran layar.

```
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(-1, -1),
      child: Container(
        color: Colors.red,
        width: 100,
        height: 100,
      ),
    );
  }
}
```

Anda juga dapat menggunakan nilai alignment konstan seperti Alignment.topLeft, Alignment.bottomRight, dll.

```
alignment: Alignment.bottomRight,
```

Ketika sebuah Container tidak didefinisikan ukurannya, maka Container akan menggunakan ukuran dari child widget-nya, dan jika Container tidak memiliki widget, maka Container tersebut akan mengambil ukuran yang maksimal.

```
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.red,
      ),
    );
  }
}
```

Kalau dengan kode berikut, bagaimanakah kira-kira tampilan di layar?

```
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.red,
        child: Container(
          color: Colors.green,
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}
```
Sama seperti contoh sebelumnya, Center berukuran sama dengan layar. Container berwarna merah dapat memiliki ukuran berapa pun selama tidak lebih besar dari layar. Karena Container merah memiliki child, maka ukurannya akan sama dengan ukuran child-nya. Container hijau juga memiliki constraints dari 0 hingga sama dengan ukuran layar. Ketika diberikan ukuran 100 x 100, ukuran Container hijau akan tampil di layar sesuai ukuran yang didefinisikan. Container merah tidak akan terlihat karena seluruh areanya tertutup dengan Container hijau.


Container memiliki parameter padding yang dapat memberikan jarak antara border dengan konten di dalamnya. Sehingga, ketika Container merah ditambahkan padding akan terlihat karena Container merah memiliki ukuran 100 + 10 + 10 dari padding-nya.

```
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.red,
        padding: const EdgeInsets.all(10.0),
        child: Container(
          color: Colors.green,
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}
```


```
ihsanunot | Flutter 3.0
(ui_style_one)
```