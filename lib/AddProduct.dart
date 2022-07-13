import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class AddProduct extends StatefulWidget {

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController _name = TextEditingController();
  TextEditingController _qty = TextEditingController();
  TextEditingController _price = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AddProduct..."),
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
                      //200 ok
                      //400 not found
                      //500 server
                      _name.text="";
                      _qty.text="";
                      _price.text="";
                      //API
                      Uri url = Uri.parse("http://picsyapps.com/studentapi/insertProductNormal.php");
                      var response = await http.post(url,body: {
                        "pname":nm,
                        "qty":qt,
                        "price":pri
                      });
                      if(response.statusCode==200)
                        {
                          var body = response.body.toString();
                          print("Body : "+body);
                        }
                      else
                        {
                          print("API Error");
                        }
                      //API
                    },
                    child: Text("Submit",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)) ,
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
