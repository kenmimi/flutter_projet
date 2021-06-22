import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Inscription extends StatefulWidget {
  @override
  _InscriptionState createState() => _InscriptionState();
}


class _InscriptionState extends State<Inscription> {
  String name = "";
  String numTel = "";
  String age = "";
  String date = "";

  createMagnifest() {
    DocumentReference documentReference =
    Firestore.instance.collection("MyTrack").document();

    //Map
    Map<String, String> track = {"trackTitle": name};

    documentReference.setData(track).whenComplete(() {
      print("$name created");
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Drawer'),
    backgroundColor: Colors.blue,
    ),
    drawer: AppDrawer(),
    body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical:50.0, horizontal: 30.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset('images/téléchargement.jpg', height: 100.0,width: 100.0),
              Center(
                child: Text('session normal',
                style: Theme.of(context).textTheme.title),
    ),
              SizedBox(height: 10.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder()
    ),
    ),
              SizedBox(height: 10.0),
              TextFormField(
                 decoration: InputDecoration(
                    labelText: 'Nom',
                    border: OutlineInputBorder()
    ),
    ),
              SizedBox(height: 10.0),
              TextFormField(
                 decoration: InputDecoration(
                   labelText: 'Age',
                   border: OutlineInputBorder()
    ),
    ),
              SizedBox(height: 10.0),
              TextFormField(
                 decoration: InputDecoration(
                   labelText: 'date inscription',
                   border: OutlineInputBorder()
    ),
    ),
          FlatButton(
            onPressed: (){},
            color: Colors.amber,
            child: Text('S\'inscrire'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)
    ),
    ),
          OutlineButton(
            onPressed: (){},
            borderSide: BorderSide(width: 1.0,color: Colors.blue),
            child: Text('Nouveau compte'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)
    ),
    )
    ],
          ),
    ),
    ),
    )
    );
}}
