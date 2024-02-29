import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vwapp/provider/usuario_provider.dart';
import 'package:vwapp/tema/tema.dart';

class FormUsuario extends StatefulWidget {
  const FormUsuario({Key? key}) : super(key: key);

  @override
  _FormUsuarioState createState() => _FormUsuarioState();
}

class _FormUsuarioState extends State<FormUsuario> {
  String selectedRole = 'colaborador';

  Map<String, String> roleValueMap = {
    'colaborador': 'colaborador',
    'supervisor': 'supervisor',
    'directivo': 'directivo',
  };

  TextEditingController nombreController = TextEditingController();
  TextEditingController contraseniaController = TextEditingController();

  void _limpiarCampos() {
    nombreController.clear();
    contraseniaController.clear();
    setState(() {
      selectedRole = 'colaborador';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: AppTheme.prim,
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Registro de Nuevo Usuario',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 20),
                      TextFormField(
                        controller: nombreController,
                        decoration: InputDecoration(
                          labelText: 'Correo electrónico',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: contraseniaController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        value: selectedRole,
                        items: roleValueMap.keys
                            .map((role) => DropdownMenuItem(
                                  value: role,
                                  child: Text(role),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedRole = value!;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Tipo de Rol',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (nombreController.text.isNotEmpty &&
                              contraseniaController.text.isNotEmpty) {
                            final usuarioProvider =
                                Provider.of<UsuarioProvider>(
                              context,
                              listen: false,
                            );

                            await usuarioProvider.insertarUsuario(
                              nombreController.text,
                              contraseniaController.text,
                              roleValueMap[selectedRole] ?? '',
                            );
                            _mostrarAlerta(
                                context, 'Usuario insertado correctamente');
                            _limpiarCampos(); // Limpia los campos después de la inserción
                          } else {
                            _mostrarAlertaError(context,
                                'Por favor, complete todos los campos.');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: AppTheme.cua,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Registrarse',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _mostrarAlerta(BuildContext context, String mensaje) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.success,
    title: 'Confirmación',
    desc: mensaje,
    btnOkOnPress: () {},
  )..show();
}

void _mostrarAlertaError(BuildContext context, String mensaje) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.error,
    title: 'Verificación',
    desc: mensaje,
    btnOkOnPress: () {},
  )..show();
}
