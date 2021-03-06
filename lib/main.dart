import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:listviewjsondemo/welcome.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Listview using local json file'),
        ),
        body: Center(
          child: FutureBuilder(
            future: DefaultAssetBundle.of(context)
                .loadString('assets/loadjson/details.json'),
            builder: (context, snapshot) {
              // Decode the JSON
              var newData = json.decode(snapshot.data.toString());
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  final _icons = <int, IconData>{
                    1 :Icons.add_alert,
                    2 : Icons.accessibility_new,
                    3 : Icons.folder_open,
                    4 : Icons.donut_large,
                    5 : Icons.input,
                    6 : Icons.tune,
                    7 : Icons.list,
                  };

                  Icon getIcon(int nombreIcono){
                    return Icon(_icons[nombreIcono], color: Colors.blue);
                  }

                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 32, bottom: 32, left: 16, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => Welcome()));
                                },
                                child: Text(" "),
                              ),
                              Text(newData[index]['texto'],
                                //'Note Text',
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                          //SizedBox(width: 20),
                          Container(
                            height: 50,
                            width: 50,
                            //3 horas buscando como implementar este metodo
                            child: getIcon(index),
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: newData == null ? 0 : newData.length,
              );
            },
          ),
        ));
  }
}
