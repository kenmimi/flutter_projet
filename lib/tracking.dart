import 'package:flutter/material.dart';
import 'package:flutter_app/app_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Tracking extends StatefulWidget {
  @override
  _TrackingState createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {
  String trackTitle = "";
  String id;

  createTrack() {
    DocumentReference documentReference =
        Firestore.instance.collection("MyTrack").document();

    //Map
    Map<String, String> track = {"trackTitle": trackTitle};

    documentReference.setData(track).whenComplete(() {
      print("$trackTitle created");
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drawer'),
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          trackTitle = "";
          showAddEditModal(context, false);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      drawer: AppDrawer(),
      body: StreamBuilder(
          stream: Firestore.instance.collection("MyTrack").snapshots(),
          builder: (context, snapshots) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshots.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot documentSnapshot =
                      snapshots.data.documents[index];
                  return Dismissible(
                      key: Key(documentSnapshot["trackTitle"]),
                      child: Card(
                        elevation: 4,
                        margin: EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: ListTile(
                          title: Text(documentSnapshot["trackTitle"]),
                          trailing: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                ),
                                onPressed: () {
                                  trackTitle = documentSnapshot['trackTitle'];
                                  id = documentSnapshot.id;
                                  showAddEditModal(context, true);
                                },
                              ),
                            ],
                          ),
                        ),
                      ));
                });
          }),
    );
  }

  showAddEditModal(BuildContext context, bool edit) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text(edit ? "Edit track" : "Add Track"),
            content: TextFormField(
              initialValue: trackTitle,
              onChanged: (String value) {
                trackTitle = value;
              },
            ),

          );
        });
  }
}
