import 'package:flutter/material.dart';
import 'package:vwapp/const.dart';

class AppBarWidget extends StatefulWidget {
  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constants.purpleLight,
      child: Row(
        children: [
          IconButton(
            color: Colors.white,
            iconSize: 30,
            onPressed: () {
               Navigator.pushReplacementNamed(
              context,
              '/home',
            );
            },
            icon: Icon(Icons.arrow_back),
          ),
          SizedBox(width: Constants.kPadding),
          Text(
            "Dashboard Panel",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20, // Puedes ajustar el tamaño del texto
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
