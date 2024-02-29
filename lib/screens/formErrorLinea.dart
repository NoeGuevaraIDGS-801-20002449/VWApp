import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:provider/provider.dart';
import '../provider/linea_provider.dart';

class FormErrorLinea extends StatefulWidget {
  @override
  _FormErrorLineaState createState() => _FormErrorLineaState();
}

class _FormErrorLineaState extends State<FormErrorLinea> {
  String selectedPriority = 'Alta';
  String selectedLevel = 'Colaborador';

  Map<String, String> priorityValueMap = {
    'Alta': 'Alta',
    'Media': 'Media',
    'Baja': 'Baja',
  };

  Map<String, String> levelValueMap = {
    'Colaborador': 'colaborador',
    'Supervisor': 'supervisor',
    'Directivo': 'directivo',
  };

  TextEditingController tipoErrorController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController fechaController = TextEditingController();
  TextEditingController horaController = TextEditingController();
  TextEditingController usuarioReporteController = TextEditingController();
  TextEditingController notasSolucionController = TextEditingController();
  TextEditingController causaRaizController = TextEditingController();
  TextEditingController impactoController = TextEditingController();
  TextEditingController frecuenciaController = TextEditingController();

  void _limpiarCampos() {
    tipoErrorController.clear();
    descripcionController.clear();
    fechaController.clear();
    horaController.clear();
    usuarioReporteController.clear();
    notasSolucionController.clear();
    causaRaizController.clear();
    impactoController.clear();
    frecuenciaController.clear();
    setState(() {
      selectedPriority = 'Alta';
      selectedLevel = 'Colaborador';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo error de línea de producción',style: TextStyle(
              color: Colors.white, // Color blanco
            ),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,), // Icono de regreso
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/errorLinea');
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 10),
                TextFormField(
                  controller: tipoErrorController,
                  decoration: InputDecoration(
                    labelText: 'Tipo de error',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: descripcionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Descripción',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
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
                        currentDate = pickedDate;
                        fechaController.text =
                            '${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}';
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
                        horaController.text = pickedTime.format(context);
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
                TextFormField(
                  controller: usuarioReporteController,
                  decoration: InputDecoration(
                    labelText: 'Usuario de reporte',
                    border: OutlineInputBorder(),
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
                  controller: notasSolucionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Notas de solución',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: causaRaizController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Causa raíz',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: selectedLevel,
                  items: levelValueMap.keys
                      .map((priority) => DropdownMenuItem(
                            value: priority,
                            child: Text(priority),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedLevel = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Nivel de usuario',
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
                    if (tipoErrorController.text.isNotEmpty &&
                        descripcionController.text.isNotEmpty &&
                        fechaController.text.isNotEmpty &&
                        horaController.text.isNotEmpty &&
                        usuarioReporteController.text.isNotEmpty &&
                        notasSolucionController.text.isNotEmpty &&
                        causaRaizController.text.isNotEmpty &&
                        impactoController.text.isNotEmpty &&
                        frecuenciaController.text.isNotEmpty) {
                      final errorProvider = Provider.of<LineaProvider>(
                        context,
                        listen: false,
                      );
                      await errorProvider.insertarError(
                        tipoErrorController.text,
                        descripcionController.text,
                        fechaController.text,
                        horaController.text,
                        usuarioReporteController.text,
                        priorityValueMap[selectedPriority] ?? '',
                        notasSolucionController.text,
                        causaRaizController.text,
                        levelValueMap[selectedLevel] ?? '',
                        impactoController.text,
                        frecuenciaController.text,
                      );
                      _mostrarAlerta(context,
                          'Error de línea de producción insertado correctamente');
                      _limpiarCampos(); // Limpia los campos después de la inserción
                    } else {
                      _mostrarAlertaError(
                          context, 'Por favor, complete todos los campos.');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Cambia el color del botón
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Guardar',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
}
