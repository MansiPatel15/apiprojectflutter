import 'package:flutter/material.dart';

class RedirectAnimalsData extends StatefulWidget {
  var image = "";
  var name = "";
  var latinname = "";
  var animaltype = "";
  var habitat = "";

  RedirectAnimalsData(
      {this.image, this.name, this.latinname, this.animaltype, this.habitat});

  @override
  State<RedirectAnimalsData> createState() => _RedirectAnimalsDataState();
}

class _RedirectAnimalsDataState extends State<RedirectAnimalsData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RedirectAnimalsData"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(5),
              height: MediaQuery.of(context).size.height / 1.7,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(widget.image.toString()),
                    fit: BoxFit.fill),
              ),
              child: Card(
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            Text(
              "Name : " + widget.name,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            Divider(thickness: 3, height: 30),
            Text(
              "Latin-Name : " + widget.latinname,
              style: TextStyle(fontSize: 16),
            ),
            Divider(thickness: 3, height: 30),
            Text(
              "Animal Type : " + widget.animaltype,
              style: TextStyle(fontSize: 16, color: Color(0XFF424242)),
            ),
            Divider(thickness: 3, height: 30),
            Text(
              "Habitat : " + widget.habitat,
              style: TextStyle(
                fontSize: 16,
                color: Color(0XFF424242),
              ),
            ),
            Divider(thickness: 3, height: 30),
          ],
        ),
      ),
    );
  }
}
