import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:my_flutter/Information.dart';
import 'package:my_flutter/constantes.dart';
import 'package:my_flutter/shape_app_bar.dart';
import 'package:firebase_database/firebase_database.dart';

import 'DetailsInformation.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
        home: Information(),
    );
  }
}


class Information extends StatefulWidget {

  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information>{
  
  List<String> names = [];
  List<News> informacion = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseReference ref = FirebaseDatabase.instance.reference().child('information');

    ref.once().then((DataSnapshot snapshot){
      var KEYS = snapshot.value.keys;
      var DATA = snapshot.value;

      informacion.clear();

      for(var individualKey in KEYS){
        News info = new News(DATA[individualKey]["titulo"], DATA[individualKey]["contenido"]);
        informacion.add(info);
      }
      setState(() {
        print(informacion.length);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return Container(
      color: kRojo,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          extendBodyBehindAppBar: true,
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                crearForosUpper(size, '¡Información \nMascotas!',
                    Icons.monitor, 0.05, kRojo),
                Container(
                  padding:
                  EdgeInsets.only(top: size.height * 0.102, bottom: 0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:
                          _information(context, informacion, size),
                          // ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  List<Widget> _information(BuildContext context, List<News> informacion,
      Size size) {
    List<Widget> topics = [];

    informacion.forEach((element) {
      Container topic = Container(
        padding: EdgeInsets.only(left: 60.0, right: 60.0, bottom: 32.0),
        width: size.width,
        height: 85.33,
        child: ElevatedButton(
          child: Text(
            element.titulo,
            style: TextStyle(
              fontSize: 17.0,
              color: Colors.black,
              fontFamily: 'PoppinsSemiBold',
            ),
            textAlign: TextAlign.center,
          ),
          style: ElevatedButton.styleFrom(
            primary: kPink,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(378.0),
            ),
            shadowColor: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => InformationDetails(
                    informacion: element)));
          },
        ),
      );
      topics.add(topic);
    });

    return topics;
  }


  Widget crearForosUpper(
      Size size, String text, IconData icono, double heigh, Color color) {
    return Container(
      //height: size.height,
      width: size.width,
      child: Stack(
        children: <Widget>[
          CustomPaint(
            painter: CustomShapeBorder(size, color),
            child: Container(
              width: size.width,
              height: size.height * 0.15,
            ),
          ),
          Container(
            width: size.width,
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: size.height * heigh),
                  Icon(
                    icono,
                    size: 50,
                    color: Colors.white,
                  ),
                  Text(
                    text,
                    style: TextStyle(fontSize: 27.0, fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            color: Colors.transparent,
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}