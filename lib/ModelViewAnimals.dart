import 'dart:convert';

import 'package:apiproject/AnimalDetails.dart';
import 'package:apiproject/models/Animals.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ModelViewAnimals extends StatefulWidget {

  @override
  State<ModelViewAnimals> createState() => _ModelViewAnimalsState();
}

class _ModelViewAnimalsState extends State<ModelViewAnimals> {
  List<Animals> alldata;

  getdata() async
  {
    Uri url = Uri.parse("https://zoo-animal-api.herokuapp.com/animals/rand/10");
    var response = await http.get(url);
    if(response.statusCode==200)
    {
      var body = response.body.toString();
      var json = jsonDecode(body);
      setState(() {
        alldata = json.map<Animals>((obj)=>Animals.fromJson(obj)).toList();
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getdata();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ModelViewAnimals..."),
      ),
      body: (alldata!=null)?
      ListView.builder(
        itemCount: alldata.length,
        itemBuilder: (context,index)
        {
          return GestureDetector(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context)=>AnimalDetails(obj: alldata[index]))
              );
            },
            child: Container(
              child: Card(
                color: Colors.blueGrey,
                child:  Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image.network(alldata[index].imageLink.toString(),),
                    SizedBox(height: 20,),
                    Text("Name : "+alldata[index].name.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    Text("LatinName : "+alldata[index].latinName.toString(),style: TextStyle(color: Colors.white)),
                    SizedBox(height: 20,),
                    Text("AnimalType : "+alldata[index].animalType.toString(),style: TextStyle(color: Colors.white)),
                    SizedBox(height: 20,),
                    Text("Habitat : "+alldata[index].habitat.toString(),style: TextStyle(color: Colors.white))

                  ],
                ),
              ),
            ),
          );
        },
      )
          :Center(child: CircularProgressIndicator()),
      // body: FutureBuilder(
      //   future: alldata,
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData)
      //     {
      //       if (snapshot.data.length <= 0)
      //       {
      //         return Center(child: Text("No Data"));
      //       }
      //       else
      //       {
      //         return ListView.builder(
      //           itemCount: snapshot.data.length,
      //           itemBuilder: (context, index) {
      //             return  GestureDetector(
      //               onTap: () async {
      //                 Navigator.of(context).push(MaterialPageRoute(
      //                     builder: (context) => RedirectAnimalsData(image: snapshot.data[index]["image_link"].toString(),
      //                         name: snapshot.data[index]["name"].toString(),latinname: snapshot.data[index]["latin_name"].toString(),
      //                         animaltype:snapshot.data[index]["animal_type"].toString(),
      //                         habitat:snapshot.data[index]["habitat"].toString())));
      //               },
      //               child:  Container(
      //                 child: Card(
      //                   color: Colors.transparent,
      //                   child: Column(
      //                     mainAxisSize: MainAxisSize.max,
      //                     children: [
      //                       Image.network(snapshot.data[index]
      //                       ["image_link"]
      //                           .toString()),
      //                       Text(
      //                         "Name : " +
      //                             snapshot.data[index]["name"].toString(),
      //                         style: TextStyle(
      //                             fontSize: 20, fontWeight: FontWeight.bold),
      //                       ),
      //                       SizedBox(
      //                         height: 20,
      //                       ),
      //                       Text(
      //                         "Latin-Name : " +
      //                             snapshot.data[index]["latin_name"].toString(),
      //                         style: TextStyle(fontSize: 18),
      //                       ),
      //                       SizedBox(
      //                         height: 20,
      //                       ),
      //                       Text(
      //                         "Animal Type : " +
      //                             snapshot.data[index]["animal_type"]
      //                                 .toString(),
      //                         style: TextStyle(
      //                             fontSize: 18, color: Color(0XFF424242)),
      //                       ),
      //                       SizedBox(
      //                         height: 20,
      //                       ),
      //                       Text(
      //                         "Habitat : " +
      //                             snapshot.data[index]["habitat"].toString(),
      //                         style: TextStyle(
      //                           fontSize: 18,
      //                           color: Color(0XFF424242),
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                   shape: RoundedRectangleBorder(
      //                       borderRadius: BorderRadius.circular(10)),
      //                 ),
      //               ),
      //             );
      //           },
      //         );
      //       }
      //     }
      //     else
      //     {
      //       return Center(child: CircularProgressIndicator());
      //     }
      //   },
      // ),
    );
  }
}

