import 'package:flutter/material.dart';
import 'package:vwapp/model/menu_option_model.dart';
import 'package:vwapp/provider/util_provider.dart';
import 'package:vwapp/router/app_route.dart';
import 'package:vwapp/tema/tema.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 2,
      child: Column(
        children: [
          Container(
            height: 200, // Altura del encabezado
            decoration: BoxDecoration(
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
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/IconoVW.png',
                    height: 80, // Tamaño de la imagen
                  ),
                  Text(
                    "Version : 1.0.1",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    AppRoute.menuOptions[index].name,
                    style: TextStyle(
                      fontSize: 16, // Tamaño de la fuente del título
                    ),
                  ),
                  leading: Icon(
                    AppRoute.menuOptions[index].icon,
                    size: 24, // Tamaño del ícono
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoute.menuOptions[index].router,
                    );
                  },
                );
              },
              separatorBuilder: (_, __) => Divider(),
              itemCount: AppRoute.menuOptions.length,
            ),
          ),
          Container(
            padding: EdgeInsets.all(16), // Espaciado interno
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () async {
                await UtilProvider.rtp.clearSession();
                Navigator.pushNamed(
                  context,
                  '/login',
                );
              },
              child: Text(
                'Cerrar Sesión',
                style: TextStyle(
                  fontSize: 16, // Tamaño del texto del botón
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: AppTheme.cua, // Color del botón
              ),
            ),
          ),
        ],
      ),
    );
  }
}
