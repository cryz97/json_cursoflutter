import "package:flutter/material.dart";
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


void main() async {

  List _data = await getJson();

  runApp(new MaterialApp(
    home: new Scaffold(
      appBar: new AppBar(
        title: new Text("JSON Parse"),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),

      body: new Center(
        child: new ListView.builder(
            itemCount: _data.length,
            padding: const EdgeInsets.all(15),
            itemBuilder: (BuildContext context, int position){
                return new Column(
                    children: <Widget>[
                      new Divider(height: 5.5),
                      new ListTile(
                        title: Text("${_data[position]['title']}", style: new TextStyle(fontSize: 18),),
                        subtitle: Text("${_data[position]['body']}",
                          style: new TextStyle(fontSize: 14,
                          color: Colors.white30,
                          fontStyle: FontStyle.italic)),

                        leading: new CircleAvatar(
                          backgroundColor: Colors.orangeAccent,
                          child: Text('${_data[position]['body'][0]}',
                            style: new TextStyle(
                              fontSize: 14,
                              color: Colors. red),
                          ),
                        ),
                       onTap: () => _showonTapMessage(context, _data[position]['body']),
                      ),
                    ],
                );
            }),
      ),
    ),
  ));
}

void _showonTapMessage(BuildContext context, String message){
  var alert = new AlertDialog(
    title: Text("My App"),
    content: Text(message),
     actions: <Widget>[
       FlatButton(
         child: Text("Ok"),
         onPressed: () {
           Navigator.pop(context);
         },)
     ],
  );
  
  showDialog(context: context, builder: (context) => alert);

}

Future<List> getJson() async {
  String apiURL = 'https://jsonplaceholder.typicode.com/posts';
  http.Response response = await http.get(apiURL);

  return json.decode(response.body);
}