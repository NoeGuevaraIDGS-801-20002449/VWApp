import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vwapp/provider/util_provider.dart';
import '../const.dart';
import '../router/app_route.dart';

class UsuarioProvider extends ChangeNotifier {
  final String _urlBase = 'https://$url/api/';
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String user = '';
  String password = '';

  UsuarioProvider() {
    getUsuarios();
  }
  List<dynamic> usuarios = [];

  Future<void> getUsuarios() async {
  final String url = '${_urlBase}Usuarios';
  
  try {
    final response = await UtilProvider.rtp.responseHTTP(urlBase: url);
    
    if (response.statusCode == 200) {
      var jResponse = jsonDecode(response.body);
      
      print("JSON recibido en getUsuarios: $jResponse"); // Agrega esta línea para imprimir el JSON recibido
      
      usuarios = jResponse;
      notifyListeners();
    } else {
      print("Error en la solicitud HTTP. Código de estado: ${response.statusCode}");
      // Puedes manejar el error de acuerdo a tus necesidades
    }
  } catch (e) {
    print("Error al obtener usuarios: $e");
    // Puedes manejar el error de acuerdo a tus necesidades
  }
}


  Future<void> insertarUsuario(
      String nombre, String contrasenia, String rol) async {
    final String url = '${_urlBase}Usuarios';
    final Map<String, String> data = {
      'idUsuario': '0',
      'nombreUsuario': nombre,
      'contraseña': contrasenia,
      'rol': rol,
      'estatus': '1',
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );
      print(response.statusCode);

      if (response.statusCode == 201) {
        getUsuarios();
        notifyListeners();
      } else {
        print('Error al insertar el usuario');
      }
    } catch (error) {
      print('Error durante la solicitud POST: $error');
    }
  }

  bool isValidForm() {
    return formkey.currentState?.validate() ?? false;
  }
}
