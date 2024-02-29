import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:vwapp/provider/usuario_provider.dart';
import 'package:vwapp/util/util.dart';
import 'package:vwapp/widgets/input_decoration.dart';
import '../provider/util_provider.dart';
import 'package:vwapp/tema/tema.dart';
import 'package:vwapp/router/app_route.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.prim,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            SafeArea(
                child: iconoEmpresa()), // Cambio de nombre a "iconoEmpresa"
            loginForm(context),
          ],
        ),
      ),
    );
  }

  Future<void> _manejarInicioSesion(
      BuildContext context, UsuarioProvider usuarioProvider) async {
    await usuarioProvider.getUsuarios();
    final usuarios = usuarioProvider.usuarios;

    final correoIngresado = usuarioProvider.user;
    final passwordIngresada = usuarioProvider.password;

    final credencialesValidas = usuarios.any((usuario) {
      final correoUsuario = usuario['nombreUsuario'];
      final contraseniaUsuario = usuario['contraseña'];

      return correoUsuario == correoIngresado &&
          contraseniaUsuario == passwordIngresada;
    });

    if (credencialesValidas) {
      final userId = usuarios.firstWhere((usuario) {
        final correoUsuario = usuario['nombreUsuario'];
        final contraseniaUsuario = usuario['contraseña'];

        return correoUsuario == correoIngresado &&
            contraseniaUsuario == passwordIngresada;
      })['idUsuario'].toString(); // Convertir el ID a String

      await UtilProvider.rtp.saveStorage(
        usuario: usuarioProvider.user,
        password: usuarioProvider.password,
        userId: userId,
      );

      Dialogos.msgDialog(
        context: context,
        texto: 'Inicio de sesión correcto',
        dgt: DialogType.success,
        onPress: () async {
          final userIdFromStorage = await UtilProvider.rtp.getUserId();
          print("ID del usuario almacenado: $userIdFromStorage");
          Navigator.pushReplacementNamed(context, '/');
        },
      ).show();
    } else {
      Dialogos.msgDialog(
        context: context,
        texto: 'El correo o la contraseña son incorrectos',
        dgt: DialogType.error,
        onPress: () {},
      ).show();
    }
  }

  Container loginForm(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioProvider>(context);
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 15,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Text(
                'Inicio de Sesión',
                style: TextStyle(
                    color: AppTheme.cua, fontSize: 25), // Cambio de color
              ),
              const SizedBox(height: 25),
              Container(
                padding: const EdgeInsets.all(15),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      Center(
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          onChanged: (value) => usuarioProvider.user = value,
                          decoration: InputDecorations.inputDecoration(
                            hintext: "ejemplo@gmail.com",
                            labeltext: "Correo electrónico",
                            icon: const Icon(
                              Icons.alternate_email_rounded,
                              color: AppTheme.cua, // Cambio de color
                            ),
                          ),
                          validator: (value) {
                            const pattern =
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

                            final regExp = RegExp(pattern);
                            return regExp.hasMatch(value ?? '')
                                ? null
                                : 'El valor ingresado no es un correo válido';
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: TextFormField(
                          autocorrect: false,
                          obscureText: true,
                          onChanged: (value) =>
                              usuarioProvider.password = value,
                          decoration: InputDecorations.inputDecoration(
                            hintext: "******",
                            labeltext: "Contraseña",
                            icon: const Icon(
                              Icons.lock_outline,
                              color: AppTheme.cua, // Cambio de color
                            ),
                          ),
                          validator: (value) {
                            return (value != null && value.length >= 6)
                                ? null
                                : 'La contraseña debe tener al menos 6 caracteres';
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        disabledColor: Colors.grey,
                        color: AppTheme.cua, // Cambio de color
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 15,
                          ),
                          child: const Text(
                            'Ingresar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        onPressed: () async {
                          await _manejarInicioSesion(context, usuarioProvider);
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 150.0, // Define el ancho deseado para el botón
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, '/formUsuario');
                          },
                          child: Text('Regístrate'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SafeArea iconoEmpresa() {
    return SafeArea(
      child: Center(
        child: Container(
          width: 200,
          height: 200,
          child: Image.asset('assets/LogoVW.png'),
        ),
      ),
    );
  }
}
