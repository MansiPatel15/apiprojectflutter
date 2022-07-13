import 'package:flutter/material.dart';

import 'models/Animals.dart';

class AnimalDetails extends StatefulWidget {

  Animals obj;
  AnimalDetails({this.obj});

  @override
  State<AnimalDetails> createState() => _AnimalDetailsState();
}

class _AnimalDetailsState extends State<AnimalDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animal"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Card(
            color: Colors.grey,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
               Image.network(widget.obj.imageLink.toString()),
                SizedBox(height: 10,),
                Text("Name : " +widget.obj.name),
                SizedBox(height: 5,),
                Text("LatinName : " +widget.obj.latinName),
                SizedBox(height: 5,),
                Text("Habitat : " +widget.obj.habitat),
                SizedBox(height: 5,),
                Text("AnimalType : " +widget.obj.animalType),
              ],
            ),
          ),
          ),
        )
      ),
    );
  }
}
// Text(widget.obj.name),
// Text(widget.obj.latinName),
// Text(widget.obj.imageLink),
