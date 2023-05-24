# Belajar Flutter

## CATATAN PENTING !

**WAJIB** dijalanin di Android Emulator atau Smartphone Android Pribadi anda.

**Jangan Run di Chrome/Desktop!** karena nanti ada Overflow yang berlebihan.


## Custom Widget

Level kustomisasi Flutter yang sangat tinggi, sehingga kita bisa membuat widget sendiri.

Sebenarnya widget berupa halaman baru yang telah Anda buat dan akses melalui Navigator sudah termasuk ke dalam custom widget. 

Tujuan dari custom widget memang untuk kustomisasi konten dari widget, dalam hal ini adalah konten di dalam widget Scaffold. 

Selain itu, custom widget juga berguna agar widget dapat digunakan ulang (reusability).

Basic Template :

```
import 'package:flutter/material.dart';
 
void main() {
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}
 
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Theme.of(context).primaryColor,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '0',
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
          GridView.count(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            crossAxisCount: 4,
            children: <Widget>[],
          ),
        ],
      ),
    );
  }
}
```

Kita memanfaatkan widget GridView untuk menyusun layout dari tombol secara grid. Masukkan kode berikut sebagai children dari GridView.

```
Container(
  color: Theme.of(context).primaryColorLight,
  child: Center(
    child: Text(
      'C',
      style: Theme.of(context)
          .textTheme
          .headline4!
          .copyWith(color: Theme.of(context).primaryColorDark),
    ),
  ),
),
```

Selanjutnya, alih-alih menyalin Container untuk setiap tombol yang akan kita buat, akan lebih baik jika kita membuat widget sendiri yang dapat dikustomisasi dalam hal warna dan juga teks yang ditampilkan.

Mari kita buat widget baru untuk kita gunakan sebagai tombol nantinya. Tambahkan beberapa property yang dapat dikustomisasi sebagai constructor. Tambahkan juga anotasi @required untuk menandakan parameter tersebut wajib diisi.

```
 Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Center(
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(color: foregroundColor),
        ),
      ),
    );
  }
}
```

Sekarang gunakan widget tersebut untuk membuat setiap tampilan sesuai contoh.

```
GridView.count(
  padding: const EdgeInsets.all(0),
  shrinkWrap: true,
  crossAxisCount: 4,
  children: <Widget>[
    CalculatorButton(
      backgroundColor: Theme.of(context).primaryColorLight,
      foregroundColor: Theme.of(context).primaryColorDark,
      text: 'C',
    ),
    CalculatorButton(
      backgroundColor: Theme.of(context).primaryColorLight,
      foregroundColor: Theme.of(context).primaryColorDark,
      text: '+/-',
    ),
    CalculatorButton(...),
    CalculatorButton(...),
    CalculatorButton(...),
    CalculatorButton(...),
    CalculatorButton(...),
    CalculatorButton(...),
    CalculatorButton(...),
    CalculatorButton(...),
    CalculatorButton(...),
    CalculatorButton(...),
    CalculatorButton(...),
    CalculatorButton(...),
    CalculatorButton(...),
    CalculatorButton(...),
    CalculatorButton(...),
    CalculatorButton(...),
    CalculatorButton(...),
    CalculatorButton(...),
  ],
),
```

Sampai sini kita telah berhasil menampilkan seluruh tombol kalkulator. 

Namun, seluruh tombol kita berbasiskan teks sementara ada satu tombol yang menggunakan icon (tombol backspace).


Bagaimana cara menampilkan icon? Ada beberapa cara dan pendekatan yang dapat kita lakukan. 

Salah satunya adalah dengan membuat constructor baru untuk button yang berupa icon.

```
class CalculatorButton extends StatelessWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final String text;
  IconData? icon;
 
  CalculatorButton({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.text,
  });
 
  CalculatorButton.Icon({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.icon,
    required this.text,
  });
 
  ...
}
```

Kemudian lakukan pengecekan apakah nilai icon terisi atau tidak.

```
Container(
  color: backgroundColor,
  child: Center(
    child: icon == null
        ? Text(
            text,
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: foregroundColor),
          )
        : Icon(
            icon,
            color: foregroundColor,
          ),
  ),
);
```

Dengan itu, pemanggilan widget kita dapat diubah dengan menggunakan icon.

```
CalculatorButton.Icon(
  backgroundColor: Theme.of(context).primaryColorDark,
  foregroundColor: Theme.of(context).primaryColorLight,
  text: 'Backspace',
  icon: Icons.backspace,
),
```

Satu lagi masalah yang kita miliki adalah bahwa CalculatorButton adalah widget yang harus dapat diklik untuk menerima input pengguna. 

Manfaatkan GestureDetector untuk mendeteksi gestur input pengguna.

```
class CalculatorButton extends StatelessWidget {
  ...
  final Function() onTap;
 
  CalculatorButton({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.text,
    required this.onTap,
  });
 
  CalculatorButton.Icon({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.icon,
    required this.text,
    required this.onTap,
  });
 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(...),
    );
  }
}
```

Karena kita telah mengekstrak kumpulan widget kita menjadi custom widget tersendiri, kita cukup melakukan perubahan di satu tempat. 

Bayangkan jika Anda masih menyalin Container menjadi button tersendiri, akan sangat merepotkan bukan?