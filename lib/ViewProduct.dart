import 'dart:convert';

import 'package:apiproject/UpdateProduct.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ViewProduct extends StatefulWidget {
  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  Future<List> alldata;

  Future<List> getdata() async {
    Uri url = Uri.parse("http://picsyapps.com/studentapi/getProducts.php");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = response.body.toString();
      var json = jsonDecode(body);
      return json["data"];
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      alldata = getdata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ViewProduct..."),
      ),
      body: FutureBuilder(
        future: alldata,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length <= 0) {
              return Center(child: Text("No Data"));
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.black12,
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  snapshot.data[index]["pname"].toString(),
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  "Rs. " +
                                      snapshot.data[index]["qty"].toString(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  snapshot.data[index]["price"].toString(),
                                  style: TextStyle(
                                      fontSize: 18, color: Color(0XFF424242)),
                                ),
                                Text(
                                  "Rs. " +
                                      snapshot.data[index]["price"].toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Color(0XFF616161),
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      var pid = snapshot.data[index]["pid"]
                                          .toString();

                                      Uri url = Uri.parse(
                                          "http://picsyapps.com/studentapi/deleteProductNormal.php");
                                      var response =
                                          await http.post(url, body: {
                                        "pid": pid,
                                      });
                                      if (response.statusCode == 200) {
                                        var body = response.body.toString();
                                        var json = jsonDecode(body);
                                        var message =
                                        json["message"].toString();

                                        Fluttertoast.showToast(
                                          msg: message,
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          fontSize: 15,
                                        );
                                        setState(() {
                                          alldata = getdata();
                                        });
                                      } else {
                                        print("API Error");
                                      }
                                    },
                                    child: Text("Delete"),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 2.3,
                                  child: ElevatedButton(


                                    onPressed: () async {
                                      var pid = snapshot.data[index]["pid"]
                                          .toString();

                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context)=> UpdateProduct(updateid: pid,))
                                      );
                                      },
                                    child: Text("Update"),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                  // return ListTile(
                  //   title: Text(snapshot.data[index]["pname"].toString()),
                  //   subtitle:Text(snapshot.data[index]["qty"].toString()),
                  //   trailing: Text("Rs."+snapshot.data[index]["price"].toString()),
                  //
                  //   onTap: ()async
                  //   {
                  //     var pid = snapshot.data[index]["pid"].toString();
                  //
                  //     Uri url = Uri.parse("http://picsyapps.com/studentapi/deleteProductNormal.php");
                  //     var response = await http.post(url,body: {
                  //       "pid":pid,
                  //     });
                  //     if(response.statusCode==200)
                  //     {
                  //       var body = response.body.toString();
                  //       var json = jsonDecode(body);
                  //       var message = json ["message"].toString();
                  //
                  //       Fluttertoast.showToast
                  //         (
                  //         msg : message,
                  //         toastLength: Toast.LENGTH_SHORT,
                  //         gravity: ToastGravity.CENTER,
                  //         timeInSecForIosWeb: 1,
                  //         backgroundColor: Colors.black,
                  //         textColor: Colors.white,
                  //         fontSize: 15,
                  //       );
                  //       setState(() {
                  //         alldata=getdata();
                  //       });
                  //       // print("Body : "+body);
                  //     }
                  //     else
                  //     {
                  //       print("API Error");
                  //     }
                  //     },
                  // );
                },
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
