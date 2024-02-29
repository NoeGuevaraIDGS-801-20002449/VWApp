import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vwapp/provider/herramienta_provider.dart';
import 'package:vwapp/tema/tema.dart';

class DetalleErrorHerramientaScreen extends StatelessWidget {
  const DetalleErrorHerramientaScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final int productoIndex =
        ModalRoute.of(context)!.settings.arguments as int? ?? 0;
    final pdProvider = Provider.of<HerramientaProvider>(context);
    List<dynamic> productoList = pdProvider.error;

    if (productoIndex >= 0 && productoIndex < productoList.length) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Detalle de Error',style: TextStyle(
              color: Colors.white, // Color blanco
            ),),
             leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,), // Icono de regreso
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/errorHerramienta');
          },
        ),
          backgroundColor: AppTheme.prim,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nombre: ${productoList[productoIndex]['tipoError']}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'ID: ${productoList[productoIndex]['id']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'Descripción',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      productoList[productoIndex]['descripción'],
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'Fecha de Reporte',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      productoList[productoIndex]['fecha'] ?? 'N/A',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'Hora de Reporte',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      productoList[productoIndex]['hora'],
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'Usuario que Reportó',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      productoList[productoIndex]['usuarioReporte'],
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'Estado',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      getEstadoText(productoList[productoIndex]['estado']),
                      style: TextStyle(
                        fontSize: 18,
                        color: getEstadoColor(
                            productoList[productoIndex]['estado']),
                      ),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'Prioridad',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      getPrioridadText(
                          productoList[productoIndex]['prioridad']),
                      style: TextStyle(
                        fontSize: 18,
                        color: getPrioridadColor(
                            productoList[productoIndex]['prioridad']),
                      ),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'Notas de Solución',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      productoList[productoIndex]['notasSolución'],
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'Causa Raíz',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      productoList[productoIndex]['causaRaíz'],
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'Nivel de Usuario',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      getNivelUsuarioText(productoList[productoIndex]['nivel']),
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'Impacto',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      productoList[productoIndex]['impacto'],
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'Frecuencia',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      productoList[productoIndex]['frecuencia'],
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          int productId = productoList[productoIndex]['id'];
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Confirmar Cambio de Nivel'),
                                content: Text(
                                  '¿Estás seguro de que deseas cambiar de nivel este error?',
                                  style: TextStyle(fontSize: 18),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      if (productoList[productoIndex]['nivel'] <
                                          3) {
                                        pdProvider.subirNivel(productId);
                                        Navigator.pushNamed(
                                            context, '/errorHerramienta');
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Nivel Máximo'),
                                              content: Text(
                                                'Tu nivel es el máximo, no puedes cambiar de nivel el error',
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Aceptar'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    },
                                    child: Text(
                                      'Aceptar',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.arrow_upward, color: Colors.white),
                        label: Text(
                          'Subir de Nivel',
                          style: TextStyle(fontSize: 10),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 13, vertical: 13),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          primary: Colors.blue,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/modificarErrorHerramienta',
                            arguments: productoIndex,
                          );
                        },
                        icon: Icon(Icons.edit, color: Colors.white),
                        label: Text(
                          'Modificar',
                          style: TextStyle(fontSize: 10),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 13, vertical: 13),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          primary: Colors.green,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          int productId = productoList[productoIndex]['id'];
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Confirmar Finalización'),
                                content: Text(
                                  '¿Estás seguro de que deseas finalizar este error?',
                                  style: TextStyle(fontSize: 18),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      pdProvider.deleteError(productId);
                                      Navigator.pushNamed(
                                          context, '/errorHerramienta');
                                    },
                                    child: Text(
                                      'Aceptar',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.check, color: Colors.white),
                        label: Text(
                          'Finalizar',
                          style: TextStyle(fontSize: 10),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 13, vertical: 13),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          primary: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Detalle de Error'),
          backgroundColor: AppTheme.prim,
        ),
        body: Center(
          child: Text('Error no encontrado'),
        ),
      );
    }
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

  String getNivelUsuarioText(int nivel) {
    switch (nivel) {
      case 1:
        return 'Colaborador';
      case 2:
        return 'Supervisor';
      case 3:
        return 'Directivo';
      default:
        return 'Desconocido';
    }
  }
}
