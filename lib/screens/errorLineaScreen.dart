import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vwapp/provider/herramienta_provider.dart';
import 'package:vwapp/provider/linea_provider.dart';
import 'package:vwapp/provider/personal_provider.dart';
import 'package:vwapp/screens/search_delegate.dart';
import 'package:vwapp/tema/tema.dart';
import 'package:vwapp/widgets/drawer_widget.dart';

class ErrorLineaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pdProvider = Provider.of<LineaProvider>(context);
    List<dynamic> productoList = pdProvider.error;

    return Scaffold(
      // drawer: const DrawerWidget(),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,), // Icono de regreso
          onPressed: () {
            Navigator.pushReplacementNamed(
              context,
              '/home',
            );
          },
        ),
        title: Text('Errores de línea de producción',style: TextStyle(
              color: Colors.white, // Color blanco
            ),),
        backgroundColor: AppTheme.prim,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(
                    pdProvider), // Pasa la instancia de HerramientaProvider.
              );
            },
          ),
        ],
      ),
      body: pdProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: productoList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(
                        context,
                        '/detalle_error_linea_screen',
                        arguments: index,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.build_circle_outlined,
                                  color: AppTheme.cua,
                                ),
                                Text(
                                  'Estado: ${getEstadoText(productoList[index]['estado'])}',
                                  style: TextStyle(
                                    color: getEstadoColor(
                                        productoList[index]['estado']),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Nombre: ${productoList[index]['tipoError']}',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Prioridad: ${getPrioridadText(productoList[index]['prioridad'])}',
                              style: TextStyle(
                                color: getPrioridadColor(
                                    productoList[index]['prioridad']),
                              ),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  '/detalle_error_linea_screen',
                                  arguments: index,
                                );
                              },
                              child: Text(
                                'Ver detalle',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: AppTheme.cua,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/nuevoErrorLinea');
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                pdProvider.getError();
              },
              style: ElevatedButton.styleFrom(
                primary: AppTheme.sec,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 20),
                minimumSize:
                    Size(MediaQuery.of(context).size.width / 2 - 20, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('En proceso'),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                pdProvider.getErrorCompleto();
              },
              style: ElevatedButton.styleFrom(
                primary: AppTheme.sec,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 20),
                minimumSize:
                    Size(MediaQuery.of(context).size.width / 2 - 20, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('Completados'),
            ),
          ],
        ),
      ],
    );
  }

  Color getEstadoColor(String estado) {
    return estado == '1' ? Colors.yellow : Colors.green;
  }

  String getEstadoText(String estado) {
    return estado == '1' ? 'En proceso' : 'Completado';
  }

  Color getPrioridadColor(String prioridad) {
    switch (prioridad) {
      case 'Alta':
        return Colors.red;
      case 'Media':
        return Colors.yellow;
      case 'Baja':
        return Colors.green;
      default:
        return Colors.black;
    }
  }

  String getPrioridadText(String prioridad) {
    switch (prioridad) {
      case 'Alta':
        return 'Alta';
      case 'Media':
        return 'Media';
      case 'Baja':
        return 'Baja';
      default:
        return '';
    }
  }
}
