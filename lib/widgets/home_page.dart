import 'package:flutter/material.dart';
import 'package:tradeprinting_dsm51_equipo1/auth/auth.dart';

class HomePageProductos extends StatefulWidget {
  @override
  _HomePageProductosState createState() => _HomePageProductosState();
}

class _HomePageProductosState extends State<HomePageProductos> {
  String userID;

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
    return Scaffold(
      body: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              child: Text(
                'Favorite',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            // child: FoodTop(),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              child: Text(
                'Productos Diseñados',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
              //child: FoodBody(),
              ),
        ],
      ),
    );
  }
}
