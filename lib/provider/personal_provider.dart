import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vwapp/provider/util_provider.dart';
import '../const.dart';

class PersonalProvider extends ChangeNotifier {
  final String _urlBase = 'https://$url/api/';

  int? userId;
  bool isLoading = true;

  HerramientaProvider() {
    _initialize();
  }

  List<dynamic> error = [];

  Future<void> _initialize() async {
    await _initUserId();
    await getError();
  }

  Future<void> _initUserId() async {
    int? userId = int.tryParse(await UtilProvider.rtp.getUserId() ?? '0');
    print('UserId: $userId');
  }

  Future<void> insertarError(
      String tipoError,
      String descripcion,
      String fecha,
      String hora,
      String usuarioReporte,
      String prioridad,
      String notasSolucion,
      String causaRaiz,
      String nivel,
      String impacto,
      String frecuencia) async {
    final String url = '${_urlBase}ErrorPersonal';
    String nivelC = '0';
    if (nivel == 'colaborador') {
      nivelC = '1';
    } else if (nivel == 'supervisor') {
      nivelC = '2';
    } else if (nivel == 'directivo') {
      nivelC = '3';
    }
    final Map<String, String> data = {
      'id': '0',
      'tipoError': tipoError,
      'descripción': descripcion,
      'fecha': fecha,
      'hora': hora,
      'usuarioReporte': usuarioReporte,
      'estado': '1',
      'prioridad': prioridad,
      'notasSolución': notasSolucion,
      'causaRaíz': causaRaiz,
      'nivel': nivelC,
      'impacto': impacto,
      'frecuencia': frecuencia
    };
    print(data);

    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );
      print(response.statusCode);

      if (response.statusCode == 201) {
        getError();
        notifyListeners();
      } else {
        print('Error al insertar el error');
      }
    } catch (error) {
      print('Error durante la solicitud POST: $error');
    }
  }

  Future<void> actualizarError(
    String id,
    String tipoError,
    String descripcion,
    String fecha,
    String hora,
    String usuarioReporte,
    String prioridad,
    String notasSolucion,
    String causaRaiz,
    String nivel,
    String impacto,
    String frecuencia,
  ) async {
    final String url = '${_urlBase}ErrorPersonal/$id';
    String nivelC = '0';
    if (nivel == 'colaborador') {
      nivelC = '1';
    } else if (nivel == 'supervisor') {
      nivelC = '2';
    } else if (nivel == 'directivo') {
      nivelC = '3';
    }

    final Map<String, String> data = {
      'id': id,
      'tipoError': tipoError,
      'descripción': descripcion,
      'fecha': fecha,
      'hora': hora,
      'usuarioReporte': usuarioReporte,
      'estado': '1',
      'prioridad': prioridad,
      'notasSolución': notasSolucion,
      'causaRaíz': causaRaiz,
      'nivel': nivelC,
      'impacto': impacto,
      'frecuencia': frecuencia,
    };

    try {
      final response = await http.put(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          // Agrega aquí cualquier encabezado de autorización si es necesario
          // 'Authorization': 'Bearer <token>',
        },
      );
      print(data);

      print('Response Status Code: ${response.statusCode}');

      if (response.statusCode == 204) {
        // Actualiza los datos locales
        getError();
        // Notifica a los oyentes (listeners) sobre los cambios
        notifyListeners();
      } else {
        // Manejo de errores específico si la solicitud no tiene éxito
        print('Error al actualizar el error. Respuesta: ${response.body}');
      }
    } catch (error) {
      // Manejo de excepciones
      print('Error durante la solicitud PUT: $error');
    }
  }

  Future<void> getError() async {
    if (userId == null || userId == 0) {
      print('UserId aún no se ha inicializado');
      isLoading = false;
      notifyListeners();
      return;
    }

    final String url = '${_urlBase}ErrorPersonal/ByUserRole/$userId';
    try {
      final response = await UtilProvider.rtp.responseHTTP(urlBase: url);

      if (response.statusCode == 200) {
        var jResponse = jsonDecode(response.body);

        // Filtrar elementos con estado igual a 1
        error = jResponse
            .where((element) => element['estado'].toString().trim() == '1')
            .toList();
      } else {
        print('Error en la solicitud HTTP: ${response.statusCode}');
      }
    } catch (e) {
      print("Error al analizar la respuesta JSON: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> getErrorCompleto() async {
    if (userId == null || userId == 0) {
      print('UserId aún no se ha inicializado');
      isLoading = false;
      notifyListeners();
      return;
    }

    final String url = '${_urlBase}ErrorPersonal/ByUserRole/$userId';
    try {
      final response = await UtilProvider.rtp.responseHTTP(urlBase: url);

      if (response.statusCode == 200) {
        var jResponse = jsonDecode(response.body);

        // Filtrar elementos con estado igual a 1
        error = jResponse
            .where((element) => element['estado'].toString().trim() == '0')
            .toList();
      } else {
        print('Error en la solicitud HTTP: ${response.statusCode}');
      }
    } catch (e) {
      print("Error al analizar la respuesta JSON: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteError(int idError) async {
    final String url = '${_urlBase}ErrorPersonal/$idError';
    try {
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode == 204) {
        await getError();
      } else {
        print('Error al eliminar el error');
      }
    } catch (error) {
      print('Error durante la solicitud DELETE: $error');
    }
  }

  Future<void> subirNivel(int idError) async {
    final String url =
        '${_urlBase}ErrorPersonal/SubirNivelErrorPersonal/$idError';
    try {
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 204) {
        await getError();
      } else {
        print('Error al eliminar el error');
      }
    } catch (error) {
      print('Error durante la solicitud DELETE: $error');
    }
  }

  Future<void> reloadScreen() async {
    isLoading = true;
    notifyListeners();
    final userId = await UtilProvider.rtp.getUserId();
    if (userId != null) {
      this.userId = int.tryParse(userId) ?? 0;
    } else {
      this.userId = 0;
    }
    await getError();
  }
}
