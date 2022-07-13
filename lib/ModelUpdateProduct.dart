import 'dart:convert';

import 'package:apiproject/ModalViewProduct.dart';
import 'package:apiproject/models/UpdateProducts.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ModelUpdateProduct extends StatefulWidget {

  // var obj;
  // ModelUpdateProduct

  @override
  State<ModelUpdateProduct> createState() => _ModelUpdateProductState();
}

class _ModelUpdateProductState extends State<ModelUpdateProduct> {

  List<UpdateProducts> alldata;

  getdata() async
  {
    Uri url = Uri.parse("http://picsyapps.com/studentapi/updateProductNormal.php");
    var response = await http.get(url);
    if(response.statusCode==200)
    {
      var body = response.body.toString();
      var json = jsonDecode(body);
      setState(() {
        alldata = json.map<UpdateProducts>((obj)=>UpdateProducts.fromJson(obj)).toList();
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

  TextEditingController _name = TextEditingController();
  TextEditingController _qty = TextEditingController();
  TextEditingController _price = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ModelUpdateProduct..."),
      ),
      body: SingleChildScrollView(
        child : Form(
          child:Padding(
            padding: EdgeInsets.all(10),
            child :Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name : ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _name,
                  keyboardType: TextInputType.text,
                  decoration:InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Qty : ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _qty,
                  keyboardType: TextInputType.number,
                  decoration:InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Price : ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _price,
                  keyboardType: TextInputType.number,
                  decoration:InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child:ElevatedButton(
                        onPressed: () async{
                          var nm = _name.text.toString();
                          var qt = _qty.text.toString();
                          var pri = _price.text.toString();
                      //    var pid =widget.updateid.toString();

                          _name.text="";
                          _qty.text="";
                          _price.text="";
                          Uri url = Uri.parse("http://picsyapps.com/studentapi/updateProductNormal.php");
                          var response = await http.post(url,body: {
                            "pname":nm,
                            "qty":qt,
                            "price":pri,
                            //"pid":pid
                          });
                          if(response.statusCode==200)
                          {
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
                          }
                          else
                          {
                            print("API Error");
                          }
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ModalViewProduct()));
                        },
                        child: Text("Update",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)) ,
                  ),
                )
              ],
            ),
          ),
        ),
      ),

    );
  }
}
