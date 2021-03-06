import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tradeprinting_dsm51_equipo1/auth/auth.dart';
import 'package:tradeprinting_dsm51_equipo1/model/producto_model.dart';
import 'package:tradeprinting_dsm51_equipo1/pages/admin/view_producto.dart';

class FoodBody extends StatefulWidget {
  @override
  _FoodBodyState createState() => _FoodBodyState();
}

class _FoodBodyState extends State<FoodBody> {
  String userID;
  //Widget content;

  @override
  void initState() {
    super.initState();

    setState(() {
      Auth().currentUser().then((onValue) {
        userID = onValue;
        print('el futuro diseñador $userID');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: StreamBuilder(
        stream: Firestore.instance.collection("colproductos").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Text("loading....");
          } else {
            if (snapshot.data.documents.length == 0) {
            } else {
              return Container(
                child: ListView(
                  children: snapshot.data.documents.map((document) {
                    return Row(
                      children: <Widget>[
                        new Container(
                          padding:
                              EdgeInsets.only(top: 2.0, left: 2.0, right: 2.0),
                          child: ClipRRect(
                            //recondea borde Foto dentro del Stack
                            borderRadius: BorderRadius.circular(10.0),
                            child: InkWell(
                              onTap: () {
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
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(5.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: FadeInImage(
                                        fit: BoxFit.cover,
                                        width: 340,
                                        height: 220,
                                        placeholder:
                                            AssetImage('assets/images/fly.gif'),
                                        image: NetworkImage(document["image"]),
                                      ),
                                    ),
                                  ),
                                  //borde para poner el la foto estrellas y titulo ...
                                  Positioned(
                                    left: 10.0,
                                    bottom: 10.0,
                                    child: Container(
                                      height: 40.0,
                                      width: 325.0,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [
                                            Colors.black,
                                            Colors.black12
                                          ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter)),
                                    ),
                                  ),
                                  Positioned(
                                    left: 20.0,
                                    right: 10.0,
                                    bottom: 10.0,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              document["name"].toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold),
                                            ), //
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
