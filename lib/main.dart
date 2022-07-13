import 'package:apiproject/AddEmployee.dart';
import 'package:apiproject/AddProduct.dart';
import 'package:apiproject/ModalViewProduct.dart';
import 'package:apiproject/ModelViewAnimals.dart';
import 'package:apiproject/ViewEmployee.dart';
import 'package:flutter/material.dart';

import 'AnimalsView.dart';
import 'ViewAnimals.dart';
import 'ViewProduct.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: AddEmployee(),
    );
  }
}

