import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'  as http;

class AnimalsView extends StatefulWidget {
  @override
  State<AnimalsView> createState() => _AnimalsViewState();
}

class _AnimalsViewState extends State<AnimalsView> {


  Future<List> alldata;

  Future<List> getdata() async {
    Uri url = Uri.parse("https://zoo-animal-api.herokuapp.com/animals/rand/10");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = response.body.toString();
      var json = jsonDecode(body);
      return json;
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      alldata = getdata();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Annimals"),
      ),
      body: FutureBuilder(
          future: alldata,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length <= 0) {
                return Center(child: Text("No Data Found"));
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data[index]["name"].toString()),
                        subtitle:  Text(snapshot.data[index]["animal_type"].toString()),
                        trailing:  Text(snapshot.data[index]["image_link"].toString()),
                      );
                    });
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
