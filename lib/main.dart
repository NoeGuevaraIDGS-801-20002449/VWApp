import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vwapp/provider/chats_provider.dart';
import 'package:vwapp/provider/dashboard_provider.dart';
import 'package:vwapp/provider/herramienta_provider.dart';
import 'package:vwapp/provider/linea_provider.dart';
import 'package:vwapp/provider/models_provider.dart';
import 'package:vwapp/provider/personal_provider.dart';
import 'package:vwapp/provider/usuario_provider.dart';
import 'package:vwapp/provider/util_provider.dart';
import 'package:vwapp/router/app_route.dart';
import 'package:vwapp/screens/home_screen.dart';
import 'package:vwapp/screens/login_screen.dart';
import 'package:vwapp/tema/tema.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UsuarioProvider()),
        ChangeNotifierProvider(create: (_) => HerramientaProvider()),
        ChangeNotifierProvider(create: (_) => PersonalProvider()),
        ChangeNotifierProvider(create: (_) => LineaProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => ModelsProvider()),
        // ChangeNotifierProvider(create: (_) => DashboardClass()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'VOLKSWAGEN',
        theme: AppTheme.tema,
        initialRoute: AppRoute.initialRoute,
        routes: AppRoute.routes,
        onGenerateRoute: (settings) => AppRoute.onGenerateRoute(settings),
      ),
    );
  }
}
