import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class UtilProvider extends ChangeNotifier {
  static final UtilProvider rtp = UtilProvider._();
  UtilProvider._();

  final storage = const FlutterSecureStorage();

  Future responseHTTP({required String urlBase}) async {
    var response = await http.get(Uri.parse(urlBase));
    return response;
  }

  Future checkSession() async {
    Map<String, String> allValues = await storage.readAll();
    if (allValues['inSesion'] == '1') {
      return 1;
    } else {
      return 0;
    }
  }

  Future saveStorage({
    required String usuario,
    required String password,
    required String userId,
  }) async {
    await storage.write(key: 'Usuario', value: usuario);
    await storage.write(key: 'pws', value: password);
    await storage.write(key: 'inSesion', value: '1');
    await storage.write(
        key: 'userId', value: userId); // Guarda el userId al iniciar sesión
    print(userId);
    return 1;
  }

  Future<String?> getUserId() async {
    try {
      final userId = await storage.read(key: 'userId');
      return userId;
    } catch (e) {
      print('Error al obtener el userId: $e');
      return null;
    }
  }

  Future clearSession() async {
    await storage.deleteAll();
  }
}
