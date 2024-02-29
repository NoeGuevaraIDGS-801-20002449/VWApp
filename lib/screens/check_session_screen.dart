import 'package:vwapp/provider/util_provider.dart';
import 'package:flutter/material.dart';

import '../tema/tema.dart';
import '../widgets/logo_widget.dart';

class CheckSessionScreen extends StatelessWidget {
  const CheckSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.sec,
      body: FutureBuilder(
          future: UtilProvider.rtp.checkSession(),
          builder: (BuildContext context, snapshot) {
            if (!snapshot.hasData) {
              return LogoWidget();
            }
            if (snapshot.data == 1) {
              Future.microtask(
                  () => Navigator.pushReplacementNamed(context, '/home'));
            } else {
              Future.microtask(
                  () => Navigator.pushReplacementNamed(context, '/login'));
            }
            return LogoWidget();
          }),
    );
  }
}
