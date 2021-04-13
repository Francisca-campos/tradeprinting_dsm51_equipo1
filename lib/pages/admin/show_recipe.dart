import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tradeprinting_dsm51_equipo1/auth/auth.dart';
import 'package:tradeprinting_dsm51_equipo1/model/producto_model.dart';
import 'package:tradeprinting_dsm51_equipo1/pages/admin/add_productos.dart';
import 'package:tradeprinting_dsm51_equipo1/pages/admin/edit_producto.dart';
import 'package:tradeprinting_dsm51_equipo1/pages/admin/view_producto.dart';

class CommonThings {
  static Size size;
}

TextEditingController nameInputController;
String id;
final db = Firestore.instance;
String name;

class InicioPage extends StatefulWidget {
  final String id;
  InicioPage({this.auth, this.onSignedOut, this.id});
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  String userID;
  //Widget content;

  @override
  void initState() {
    super.initState();

    setState(() {
      Auth().currentUser().then((onValue) {
        userID = onValue;
        print('user id $userID');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    CommonThings.size = MediaQuery.of(context).size;
    //print('Width of the screen: ${CommonThings.size.width}');
    return new Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance.collection("colproductos").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Text("loading....");
          } else {
            if (snapshot.data.documents.length == 0) {
              return Center(
                child: Column(
                  children: <Widget>[
                    Card(
                      margin: EdgeInsets.all(15),
                      shape: BeveledRectangleBorder(
                          side: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5.0)),
                      elevation: 5.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '\nAgrega un producto.\n',
                            style: TextStyle(fontSize: 24, color: Colors.blue),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else {
              //print("from the streamBuilder: "+ snapshot.data.documents[]);
              // print(length.toString() + " doc length");

              return ListView(
                children: snapshot.data.documents.map((document) {
                  return Card(
                    elevation: 5.0,
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(5.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: FadeInImage(
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                              placeholder: AssetImage('assets/images/fly.gif'),
                              image: NetworkImage(document["image"]),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              document['name'].toString().toUpperCase(),
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 17.0,
                              ),
                            ),
                            subtitle: Text(
                              document['producto'].toString().toUpperCase(),
                              style: TextStyle(
                                  color: Colors.black, fontSize: 12.0),
                            ),
                            //editar la receta
                            onTap: () {
                              Producto producto = Producto(
                                name: document['name'].toString(),
                                image: document['image'].toString(),
                                producto: document['producto'].toString(),
                              );
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProducto(
                                          producto: producto,
                                          idProducto: document.documentID,
                                          uid: userID)));
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                          onPressed: () {
                            document.data.remove('key');
                            Firestore.instance
                                .collection('colproductos')
                                .document(document.documentID)
                                .delete();
                            FirebaseStorage.instance
                                .ref()
                                .child(
                                    'colproductos/$userID/uid/producto/${document['name'].toString()}.jpg')
                                .delete()
                                .then((onValue) {
                              print('foto eliminada');
                            });
                          }, //funciona
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () {
                            Producto producto = Producto(
                              name: document['name'].toString(),
                              image: document['image'].toString(),
                              producto: document['producto'].toString(),
                            );
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewProducto(
                                        producto: producto,
                                        idProducto: document.documentID,
                                        uid: userID)));
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.pinkAccent,
        onPressed: () {
          Route route = MaterialPageRoute(builder: (context) => MyAddPage());
          Navigator.push(context, route);
        },
      ),
    );
  }
}
