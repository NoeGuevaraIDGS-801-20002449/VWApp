import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('assets/LogoVW.png'),
            width: 500, // Cambia el valor del ancho según tus necesidades
            height: 500, // Cambia el valor del alto según tus necesidades
          ),
        ],
      ),
    );
  }
}
