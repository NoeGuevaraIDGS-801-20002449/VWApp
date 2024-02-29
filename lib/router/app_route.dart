import 'package:flutter/material.dart';
import 'package:vwapp/model/menu_option_model.dart';
import 'package:vwapp/screens/ErrorScreen.dart';
import 'package:vwapp/screens/chat_screen.dart';
import 'package:vwapp/screens/check_session_screen.dart';
import 'package:vwapp/screens/detalle_error_herramienta_screen.dart';
import 'package:vwapp/screens/detalle_error_personal_screen.dart';
import 'package:vwapp/screens/errorHerrameintaScreen.dart';
import 'package:vwapp/screens/errorLineaScreen.dart';
import 'package:vwapp/screens/errorPersonalScreen.dart';
import 'package:vwapp/screens/formErrorHerramienta.dart';
import 'package:vwapp/screens/formErrorLinea.dart';
import 'package:vwapp/screens/formModificarErrorLinea.dart';
import 'package:vwapp/screens/formUsuario.dart';
import 'package:vwapp/screens/home_screen.dart';
import 'package:vwapp/screens/login_screen.dart';
import 'package:vwapp/widget_tree.dart';

import '../screens/dashboard.dart';
import '../screens/detalle_error_linea_screen.dart';
import '../screens/formErrorPersonal.dart';
import '../screens/formModificarErrorHerramienta.dart';
import '../screens/formModificarErrorPersonal.dart';

class AppRoute {
  static const String initialRoute = '/';
  static final routes = {
    '/login': (context) => LoginScreen(),
    '/home': (context) => HomeScreen(),
    '/formUsuario': (context) => FormUsuario(),
    '/errorHerramienta': (context) => ErrorHerramientaScreen(),
    '/nuevoErrorHerramienta': (context) => FormErrorHerramienta(),
    '/modificarErrorHerramienta': (context) => FormModificarErrorHerramienta(),
    '/detalle_error_herramienta_screen': (context) =>
        DetalleErrorHerramientaScreen(),
    '/errorPersonal': (context) => ErrorPersonalScreen(),
    '/detalle_error_personal_screen': (context) => DetalleErrorPersonalScreen(),
    '/nuevoErrorPersonal': (context) => FormErrorPersonal(),
    '/modificarErrorPersonal': (context) => FormModificarErrorPersonal(),
    '/errorLinea': (context) => ErrorLineaScreen(),
    '/detalle_error_linea_screen': (context) => DetalleErrorLineaScreen(),
    '/nuevoErrorLinea': (context) => FormErrorLinea(),
    '/modificarErrorLinea': (context) => FormModificarErrorLinea(),
    '/dashboard': (context) => PanelCenterPage(),
    '/asistente': (context) => ChatScreen(),
    '/dashboard2': (context) => WidgetTree(),
    '/': (context) => CheckSessionScreen()
  };

  static final menuOptions = <MenuOption>[
    MenuOption(router: '/home', icon: Icons.home, name: 'Home'),
    // MenuOption(
    //     router: '/errorHerramienta',
    //     icon: Icons.build_circle,
    //     name: 'Error herramientas'),
    // MenuOption(
    //     router: '/errorPersonal',
    //     icon: Icons.build_circle,
    //     name: 'Error personal'),
    // MenuOption(
    //     router: '/errorLinea',
    //     icon: Icons.paste_rounded,
    //     name: 'Error Linea de producción'),
  ];

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(builder: (_) => const ErrorScreen());
    }
  }

  static Route<dynamic> unknownRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (_) => const ErrorScreen());
  }

  static onGenerateRoute(settings) {
    return MaterialPageRoute(
      builder: (context) => const ErrorScreen(),
    );
  }
}
