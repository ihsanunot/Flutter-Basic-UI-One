# Layout Constraints : ConstrainedBox, Row, dan Column

```
flutter run -d chrome --web-renderer html
```

Notes:
> Flexible & Expanded

Flutter juga memiliki widget yang memungkinkan kita memberikan constraint tambahan terhadap child widget. 

Widget ini bernama **ConstrainedBox**. 

Perhatikan bahwa constraint dari widget ini hanya bersifat tambahan dan ConstrainedBox masih memiliki constraints yang diturunkan dari parent-nya.

```
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 70,
        minHeight: 70,
        maxWidth: 150,
        maxHeight: 150,
      ),
      child: Container(
        color: Colors.red,
      ),
    );
  }
}
```

Constraint dari ConstrainedBox akan diabaikan karena widget ConstrainedBox masih menggunakan constraints dari root widget yang harus menampilkan sesuai ukuran layar.


Berbeda ketika kita membungkus ConstrainedBox dengan Center. 

Center memungkinkan ConstrainedBox untuk memiliki ukuran berapa pun selama tidak melebihi ukuran layar. 

Oleh karena itu, Container di bawahnya hanya dapat memiliki ukuran antara 70 x 70 hingga 150 x 150.

```
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 70,
          minHeight: 70,
          maxWidth: 150,
          maxHeight: 150,
        ),
        child: Container(
          color: Colors.red,
        ),
      ),
    );
  }
}
```
Setelah mempelajari bagaimana constraints dapat memengaruhi posisi dan ukuran dari widget, ada juga widget yang tidak memberikan constraints pada widget di bawahnya. Widget ini adalah UnconstrainedBox.

```
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        color: Colors.red,
        width: 1000,
        height: 100,
      ),
    );
  }
}
```

Kita tahu bahwa root widget dari Flutter memberikan constraints agar widget di bawahnya berukuran sama dengan ukuran layar. Namun, UnconstrainedBox memungkinkan widget di bawahnya untuk memiliki ukuran berapa pun. Sehingga, Container dapat menentukan ukuran dengan bebas bahkan hingga melebihi ukuran layar sekalipun.

Namun, karena ukuran yang melebihi layar maka Flutter akan memberikan overflow warning.

Lalu, bagaimana dengan widget yang berpola parent-children seperti Row, Column, dan sebagainya?

```
Row(
  children: [
    Container(
      color: Colors.red,
      child: Text('Hello!'),
    ),
    Container(
      color: Colors.green,
      child: Text('Goodbye!'),
    ),
  ],
),
```

Sama seperti UnconstrainedBox, widget seperti Row tidak memberikan constraints terhadap children-nya, melainkan membiarkan children widget menentukan ukuran yang diinginkan.

Karena Row tidak memberikan constraints, maka ketika widget di dalamnya melebihi ukuran layar akan muncul overflow warning.

```
Row(
  children: [
    Container(
      color: Colors.red,
      child: Text('Hello! This is a very long Text!'),
    ),
    Container(
      color: Colors.green,
      child: Text('Goodbye!'),
    ),
  ],
),
```

Sekarang coba bungkus Container teks yang panjang ke dalam widget Expanded.

```
Row(
  children: [
    Expanded(
      child: Container(
        color: Colors.red,
        child: Text('Hello! This is a very long Text!'),
      ),
    ),
    Container(
      color: Colors.green,
      child: Text('Goodbye!'),
    ),
  ],
),
```

Ukuran widget Expanded akan mengembang berdasarkan widget lainnya. Hal ini akan mengabaikan ukuran dari widget Container di bawahnya.

Jika setiap child widget dari Row dibungkus dengan widget Expanded, maka seluruh children akan memiliki ukuran yang sama.

```
Row(
  children: [
    Expanded(
      child: Container(
        color: Colors.red,
        child: Text('Hello! This is a very long Text!'),
      ),
    ),
    Expanded(
      child: Container(
        color: Colors.green,
        child: Text('Goodbye!'),
      ),
    ),
  ],
),
```

Opsi widget lain yang bisa digunakan adalah **Flexible**. 

Perbedaan Flexible dan **Expanded** adalah widget Flexible memungkinkan child widget-nya berukuran lebih kecil dibandingkan ukuran Flexible. 

Sementara, child widget dari Expanded harus memiliki ukuran sesuai ukuran Expanded.

```
Row(
  children: [
    Flexible(
      child: Container(
        color: Colors.red,
        child: Text('Hello! This is a very long Text!'),
      ),
    ),
    Flexible(
      child: Container(
        color: Colors.green,
        child: Text('Goodbye!'),
      ),
    ),
  ],
),
```





---
Referensi:
- https://api.flutter.dev/flutter/widgets/ConstrainedBox-class.html