import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'model.dart';
import 'package:flutter/services.dart' as rootBundle;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: ReadJsonData(),
        builder: (context,data){
          if(data.hasError){
            return Center(child: Text("${data.error}"));
          }else if(data.hasData){
            var items =data.data as List<Model>;
            return ListView.builder(
              // ignore: unnecessary_null_comparison
              itemCount: items == null? 0: items.length,
                itemBuilder: (context,index){
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            child: Image(image: NetworkImage(items[index].link.toString()),fit: BoxFit.fill,),
                          ),
                          Expanded(child: Container(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.only(left: 8,right: 8),child: Text(items[index].title.toString(),style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                                ),),),
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                  );
                }
            );
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      )
    );
  }

  Future<List<Model>>ReadJsonData() async{
     final jsondata = await rootBundle.rootBundle.loadString('assets/data.json');
     final list = json.decode(jsondata) as List<dynamic>;

     return list.map((e) => Model.fromJson(e)).toList();
  }
  }