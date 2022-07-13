import 'dart:convert';
import 'package:apiproject/ModelUpdateProduct.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'models/Products.dart';

class ModalViewProduct extends StatefulWidget {

  @override
  State<ModalViewProduct> createState() => _ModalViewProductState();
}

class _ModalViewProductState extends State<ModalViewProduct> {
  List<Products> alldata;

  getdata() async
  {
    Uri url = Uri.parse("http://picsyapps.com/studentapi/getProducts.php");
    var response = await http.get(url);
    if(response.statusCode==200)
    {
      var body = response.body.toString();
      var json = jsonDecode(body);
      setState(() {
        alldata = json["data"].map<Products>((obj)=>Products.fromJson(obj)).toList();
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
        title: Text("ModalViewProduct..."),
      ),
      body: (alldata!=null)?
          ListView.builder(
            itemCount: alldata.length,
            itemBuilder: (context,index)
            {
              return GestureDetector(
                onTap: (){
                  var pid = alldata[index].pid
                      .toString();

                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context)=> ModelUpdateProduct())
                  );
                },
                child: Container(
                  child: Card(
                    color: Colors.blueGrey,
                    child:  Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                       // Image.network(alldata[index].imageLink.toString(),),
                        SizedBox(height: 20,),
                        Text("Pname : "+alldata[index].pname.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                        SizedBox(height: 20,),
                        Text("Qty : "+alldata[index].qty.toString(),style: TextStyle(color: Colors.white)),
                        SizedBox(height: 20,),
                        Text("Price : "+alldata[index].price.toString(),style: TextStyle(color: Colors.white)),
                        SizedBox(height: 20,),


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
      //   builder: (context,snapshot)
      //   {
      //     if(snapshot.hasData)
      //     {
      //       if(snapshot.data.length<=0)
      //       {
      //         return Center(child: Text("No Data"));
      //       }
      //       else
      //       {
      //         return ListView.builder(
      //           itemCount: snapshot.data.length,
      //           itemBuilder: (context,index)
      //           {
      //             return ListTile(
      //               title: Text(snapshot.data[index]["pname"].toString()),
      //               subtitle:Text(snapshot.data[index]["qty"].toString()),
      //               trailing: Text("Rs."+snapshot.data[index]["price"].toString()),
      //
      //               onTap: ()async
      //               {
      //                 var pid = snapshot.data[index]["pid"].toString();
      //
      //                 Uri url = Uri.parse("http://picsyapps.com/studentapi/deleteProductNormal.php");
      //                 var response = await http.post(url,body: {
      //                   "pid":pid,
      //                 });
      //                 if(response.statusCode==200)
      //                 {
      //                   var body = response.body.toString();
      //                   var json = jsonDecode(body);
      //                   var message = json ["message"].toString();
      //
      //                   Fluttertoast.showToast
      //                     (
      //                     msg : message,
      //                     toastLength: Toast.LENGTH_SHORT,
      //                     gravity: ToastGravity.CENTER,
      //                     timeInSecForIosWeb: 1,
      //                     backgroundColor: Colors.black,
      //                     textColor: Colors.white,
      //                     fontSize: 15,
      //                   );
      //
      //                   setState(() {
      //                     alldata=getdata();
      //                   });
      //                   // print("Body : "+body);
      //                 }
      //                 else
      //                 {
      //                   print("API Error");
      //                 }
      //
      //               },
      //
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
