import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ViewEmployee extends StatefulWidget {
  @override
  State<ViewEmployee> createState() => _ViewEmployeeState();
}

class _ViewEmployeeState extends State<ViewEmployee> {
  Future<List> alldata;

  Future<List> getdata() async
  {
    Uri url = Uri.parse("http://picsyapps.com/studentapi/getEmployee.php");
    var response = await http.get(url);
    if(response.statusCode==200)
    {
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
        title: Text("ViewEmployee..."),
      ),
      body: FutureBuilder(
        future: alldata,
        builder: (context,snapshot)
        {
          if(snapshot.hasData)
          {
            if(snapshot.data.length<=0)
            {
              return Center(child: Text("No Data"));
            }
            else
            {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context,index)
                {
                  return GestureDetector(
                    onTap: () async{

                        var eid = snapshot.data[index]["eid"].toString();

                        Uri url = Uri.parse("http://picsyapps.com/studentapi/deleteEmployeeNormal.php");
                        var response = await http.post(url,body: {
                          "eid":eid,
                        });
                        if(response.statusCode==200)
                        {
                          var body = response.body.toString();
                          var json = jsonDecode(body);
                          var message = json ["message"].toString();

                          Fluttertoast.showToast
                            (
                            msg : message,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 15,
                          );

                          setState(() {
                            alldata=getdata();
                          });
                          // print("Body : "+body);
                        }
                        else
                        {
                          print("API Error");
                        }

                    },
                    child:Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    color: Colors.black12,
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                            padding: EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(snapshot.data[index]["ename"].toString(),style: TextStyle(fontSize: 20),),
                              Text("Rs. "+snapshot.data[index]["salary"].toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(snapshot.data[index]["gender"].toString(),style: TextStyle(fontSize: 18,color: Color(0XFF424242)),),
                              Text("Rs. "+snapshot.data[index]["department"].toString(),style: TextStyle(fontSize: 15,color:Color(0XFF616161),fontWeight: FontWeight.w500),),
                            ],
                          ),
                        ),
                      ],
                    ) ,
                  ),
                  );
                  },
              );
            }
          }
          else
          {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
