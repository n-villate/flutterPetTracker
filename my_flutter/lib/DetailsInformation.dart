import 'package:flutter/material.dart';
import 'package:my_flutter/constantes.dart';
import 'package:my_flutter/shape_app_bar.dart';

import 'Information.dart';



class InformationDetails extends StatefulWidget {
  @override
  _InformationDetailsState createState() =>
      _InformationDetailsState();
  final News informacion;
  const InformationDetails({this.informacion});
}

class _InformationDetailsState extends State<InformationDetails> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      color: kRojo,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,

          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                crearForosUpper(size, '¡Información \nMascotas!',
                    Icons.monitor, 0.05, kRojo),
                Container(
                  padding: EdgeInsets.only(top: size.height * 0.102),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: _detail(context, size, widget.informacion),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
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


Widget _detail(BuildContext context, Size size, News info) {

  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          width: size.width,
          height: 51.13,
          color: kPink,
          child: Center(
            child: Text(
              info.titulo,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontFamily: 'PoppinsRegular',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        _simpleSecction('¡Infórmate!', info.cuerpo, size),

      ],
    ),
  );
}


Widget _simpleSecction(String title, String content, Size size) {
  return Container(
    padding: EdgeInsets.only(right: 10.0, left: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20.0,
              color: kRojo,
              fontFamily: 'PoppinsRegular',
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Text(
          content,
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 17.0,
            color: Colors.black,
            fontFamily: 'PoppinsRegular',
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 10.0),
          child: Divider(
            color: Colors.black.withOpacity(0.40),
          ),
        ),
      ],
    ),
  );
}

