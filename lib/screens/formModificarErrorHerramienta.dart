import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:provider/provider.dart';
import 'package:vwapp/provider/herramienta_provider.dart';

class FormModificarErrorHerramienta extends StatefulWidget {
  @override
  _FormModificarErrorHerramienta createState() =>
      _FormModificarErrorHerramienta();
}

class _FormModificarErrorHerramienta
    extends State<FormModificarErrorHerramienta> {
  String selectedPriority = '';
  String selectedLevel = '';

  Map<String, String> priorityValueMap = {
    'Alta': 'Alta',
    'Media': 'Media',
    'Baja': 'Baja',
  };

  Map<String, String> levelValueMap = {
    'colaborador': 'colaborador',
    'supervisor': 'supervisor',
    'directivo': 'directivo',
  };

  TextEditingController idController = TextEditingController();
  TextEditingController tipoErrorController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController fechaController = TextEditingController();
  TextEditingController horaController = TextEditingController();
  TextEditingController usuarioReporteController = TextEditingController();
  TextEditingController notasSolucionController = TextEditingController();
  TextEditingController causaRaizController = TextEditingController();
  TextEditingController nivelController = TextEditingController();
  TextEditingController impactoController = TextEditingController();
  TextEditingController frecuenciaController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final int productoIndex = ModalRoute.of(context)!.settings.arguments as int;
    final pdProvider = Provider.of<HerramientaProvider>(context);
    List<dynamic> productoList = pdProvider.error;

    idController.text = productoList[productoIndex]['id'].toString();
    tipoErrorController.text = productoList[productoIndex]['tipoError'];
    descripcionController.text = productoList[productoIndex]['descripción'];
    fechaController.text = fechaController.text.isEmpty
        ? productoList[productoIndex]['fecha']
        : fechaController.text;

    horaController.text = horaController.text.isEmpty
        ? productoList[productoIndex]['hora']
        : horaController.text;

    usuarioReporteController.text =
        productoList[productoIndex]['usuarioReporte'];
    notasSolucionController.text = productoList[productoIndex]['notasSolución'];
    causaRaizController.text = productoList[productoIndex]['causaRaíz'];
    impactoController.text = productoList[productoIndex]['impacto'];
    frecuenciaController.text = productoList[productoIndex]['frecuencia'];

    selectedPriority = selectedPriority.isEmpty
        ? productoList[productoIndex]['prioridad']
        : selectedPriority;
    selectedLevel = nivelUsuario(productoList, productoIndex);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Modificar error herramienta',style: TextStyle(
              color: Colors.white, // Color blanco
            ),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Navigator.pushReplacementNamed(
                context, '/detalle_error_herramienta_screen',
                arguments: productoIndex);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Center(
                  child: Form(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: idController,
                          enabled: false,
                          decoration: InputDecoration(
                            labelText: 'Identificador',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () async {
                            DateTime currentDate = DateTime.now();
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: currentDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                              initialEntryMode: DatePickerEntryMode.input,
                              initialDatePickerMode: DatePickerMode.day,
                            );

                            if (pickedDate != null) {
                              setState(() {
                                fechaController.text =
                                    '${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
                              });
                            }
                          },
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller: fechaController,
                              decoration: InputDecoration(
                                labelText: 'Fecha',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () async {
                            final TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );

                            if (pickedTime != null) {
                              setState(() {
                                horaController.text =
                                    pickedTime.format(context);
                              });
                            }
                          },
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller: horaController,
                              decoration: InputDecoration(
                                labelText: 'Hora',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          value: selectedPriority,
                          items: priorityValueMap.keys
                              .map((priority) => DropdownMenuItem(
                                    value: priority,
                                    child: Text(priority),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedPriority = value!;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Prioridad',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: tipoErrorController,
                          decoration: InputDecoration(
                            labelText: 'Nombre',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: descripcionController,
                          decoration: InputDecoration(
                            labelText: 'Descripción',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: usuarioReporteController,
                          decoration: InputDecoration(
                            labelText: 'Usuario de reporte',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: notasSolucionController,
                          decoration: InputDecoration(
                            labelText: 'Notas de solución',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: causaRaizController,
                          decoration: InputDecoration(
                            labelText: 'Causa raíz',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: impactoController,
                          decoration: InputDecoration(
                            labelText: 'Impacto',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: frecuenciaController,
                          decoration: InputDecoration(
                            labelText: 'Frecuencia',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            if (idController.text.isNotEmpty &&
                                tipoErrorController.text.isNotEmpty &&
                                descripcionController.text.isNotEmpty &&
                                fechaController.text.isNotEmpty &&
                                horaController.text.isNotEmpty &&
                                usuarioReporteController.text.isNotEmpty &&
                                notasSolucionController.text.isNotEmpty &&
                                causaRaizController.text.isNotEmpty &&
                                impactoController.text.isNotEmpty &&
                                frecuenciaController.text.isNotEmpty) {
                              final errorProvider =
                                  Provider.of<HerramientaProvider>(
                                context,
                                listen: false,
                              );
                              await errorProvider.actualizarError(
                                idController.text,
                                tipoErrorController.text,
                                descripcionController.text,
                                fechaController.text,
                                horaController.text,
                                usuarioReporteController.text,
                                selectedPriority,
                                notasSolucionController.text,
                                causaRaizController.text,
                                levelValueMap[selectedLevel] ?? '',
                                impactoController.text,
                                frecuenciaController.text,
                              );
                              _mostrarAlerta(context,
                                  'Error de herramientas actualizado correctamente');
                            } else {
                              _mostrarAlertaError(context,
                                  'Por favor, complete todos los campos.');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.blue, // Cambia el color del botón
                          ),
                          child: Text(
                            'Guardar',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String nivelUsuario(List<dynamic> productoList, int productoIndex) {
    // Verifica si el valor 'nivel' es nulo
    final nivelUsuario = productoList[productoIndex]['nivel'];
    if (nivelUsuario != null) {
      if (nivelUsuario == 1) {
        return 'colaborador';
      } else if (nivelUsuario == 2) {
        return 'supervisor';
      } else if (nivelUsuario == 3) {
        return 'directivo';
      }
    }
    // Valor predeterminado si 'nivel' es nulo o no coincide con ningún caso
    return 'colaborador';
  }

  void _mostrarAlerta(BuildContext context, String mensaje) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      title: 'Confirmación',
      desc: mensaje,
      btnOkOnPress: () {
        Navigator.pop(context);
      },
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
}
