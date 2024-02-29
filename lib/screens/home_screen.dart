import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vwapp/provider/dashboard_provider.dart';
import 'package:vwapp/provider/personal_provider.dart';
import 'package:vwapp/tema/tema.dart';
import 'package:vwapp/widgets/drawer_widget.dart';

import '../provider/herramienta_provider.dart';
import '../provider/linea_provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({Key? key})
      : preferredSize = Size.fromHeight(kToolbarHeight + 80.0),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.prim,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        title: Container(
          alignment: Alignment.bottomCenter,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.end,
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppTheme.secd,
                    AppTheme.sec,
                    AppTheme.prim,
                  ],
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  SizedBox(
                    width: 200,
                    height: 100,
                    child: Image.asset('assets/LogoTVW.png'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      endDrawer: const DrawerWidget(),
      appBar: CustomAppBar(), // Usa la AppBar personalizada
      body: GridView.builder(
        padding: EdgeInsets.all(20), // Margen de la app
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Dos botones por fila
          crossAxisSpacing: 10.0, // Espacio entre botones horizontal
          mainAxisSpacing: 10.0, // Espacio entre botones vertical
        ),
        itemCount: 5, // Número total de botones
        itemBuilder: (context, index) {
          // Alterna los colores de fondo de los botones
          Color buttonColor = AppTheme.sec;

          IconData icon;
          String label;
          Function onPressed;

          // Asigna las funciones y contenido de los botones
          switch (index) {
            case 0:
              icon = Icons.bar_chart;
              label = 'Dashboard';
              onPressed = () {
                Navigator.pushReplacementNamed(
                  context,
                  '/dashboard2',
                );
              };

              break;
            case 1:
              icon = Icons.build_circle;
              label = 'Error herramientas';
              onPressed = () async {
                final pdProvider = Provider.of<HerramientaProvider>(
                  context,
                  listen: false,
                );
                await pdProvider.reloadScreen();

                Navigator.pushReplacementNamed(
                  context,
                  '/errorHerramienta',
                );
              };
              break;
            case 2:
              icon = Icons.paste_rounded;
              label = 'Error línea de producción';
              onPressed = () async {
                final pdProvider = Provider.of<LineaProvider>(
                  context,
                  listen: false,
                );
                await pdProvider.reloadScreen();

                Navigator.pushReplacementNamed(
                  context,
                  '/errorLinea',
                );
              };
              break;
            case 3:
              icon = Icons.account_circle;
              label = 'Error personal';
              onPressed = () async {
                final pdProvider = Provider.of<PersonalProvider>(
                  context,
                  listen: false,
                );
                await pdProvider.reloadScreen();

                Navigator.pushReplacementNamed(
                  context,
                  '/errorPersonal',
                );
              };
              break;
            case 4:
              icon = Icons.person;
              label = 'Asistente virtual';
              onPressed = () async {
                final pdProvider = Provider.of<PersonalProvider>(
                  context,
                  listen: false,
                );
                await pdProvider.reloadScreen();

                Navigator.pushReplacementNamed(
                  context,
                  '/asistente',
                );
              };
              break;
            default:
              icon = Icons.error;
              label = 'Botón $index';
              onPressed = () {
                // Acción del botón
              };
          }

          return buildElevatedButton(
            label: label,
            icon: icon,
            onPressed: onPressed,
            buttonWidth: buttonWidth,
            buttonColor: buttonColor,
          );
        },
      ),
    );
  }

  Widget buildElevatedButton({
    required String label,
    required IconData icon,
    required Function onPressed,
    required double buttonWidth,
    required Color buttonColor,
  }) {
    return Container(
      width: buttonWidth,
      child: ElevatedButton(
        onPressed: () => onPressed(),
        style: ElevatedButton.styleFrom(
          primary: buttonColor,
          padding: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
