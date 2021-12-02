import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:proyecto_topicos/components/personal_button.dart';
import 'package:proyecto_topicos/components/personal_textField.dart';
import 'package:proyecto_topicos/model/cita.dart';
import 'package:proyecto_topicos/model/paciente.dart';

import 'package:proyecto_topicos/util/constants.dart' as Constants;

class FormCitas extends StatefulWidget {
  @override
  _FormCitasState createState() => _FormCitasState();
}

class _FormCitasState extends State<FormCitas> {
  DateTime fechaSeleccionada = DateTime.now();
  TimeOfDay horaSeleccionada = TimeOfDay.now();
  Paciente? pacienteSeleccionado;
  TextEditingController situacionController = TextEditingController();
  TextEditingController precioController = TextEditingController();
  TextEditingController fechaController = TextEditingController();
  TextEditingController horaController = TextEditingController();
  List<Paciente> pacientes = [];

  var url = Uri.parse(
      'http://${Constants.IP_CONEXION}/proyecto_topicos/consulta_pacientes.php');

  Future<List<Paciente>> consultaPacientes() async {
    final response = await http.get(url);

    return (jsonDecode(response.body) as List)
        .map((value) => Paciente.fromJson(value))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;

    onPressedCancelar(id) {
      Navigator.pop(context);
    }

    Widget buildForm() => FutureBuilder<List<Paciente>>(
        future: consultaPacientes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar los pacientes'));
          }
          pacientes = snapshot.data ?? [];
          return ListView(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 15, 10, 5),
                child: DropdownButtonFormField<Paciente>(
                  value: pacienteSeleccionado,
                  isExpanded: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    hintText: 'Seleccione un paciente',
                    labelText: 'Seleccione un paciente',
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.teal[400],
                    ),
                  ),
                  items: pacientes
                      .map<DropdownMenuItem<Paciente>>((Paciente value) {
                    return DropdownMenuItem<Paciente>(
                      child: Text('${value.nombres} ${value.apellidos}'),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (Paciente? value) {
                    setState(() {
                      pacienteSeleccionado = value;
                    });
                  },
                ),
              ),
              Container(
                child: PersonalTextField(
                    situacionController, 'Situación', 'Situación',
                    icono: Icons.list_alt, maxLineas: 3, minLineas: 1),
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
              ),
              Container(
                child: PersonalTextField(precioController, 'Precio', 'Precio',
                    icono: Icons.monetization_on),
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
                child: TextField(
                  controller: fechaController,
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Fecha a agendar',
                      hintText: 'Fecha',
                      prefixIcon: Icon(
                        Icons.calendar_today,
                        color: Colors.teal[600],
                      )),
                  onTap: () => _selectDate(context),
                  readOnly: true,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
                child: TextField(
                  controller: horaController,
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Hora de la cita',
                      hintText: 'Hora',
                      prefixIcon: Icon(
                        Icons.timer,
                        color: Colors.teal[600],
                      )),
                  onTap: () => _selectHour(context),
                  readOnly: true,
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  (arg['action'] == 'agendar')
                      ? PersonalButton(1, onPressedRegistrarCita, 'Agendar',
                          icono: Icons.add_sharp, classColor: 'primary')
                      : PersonalButton(2, onPressedRegistrarCita, 'Editar',
                          icono: Icons.edit, classColor: 'primary'),
                  PersonalButton(
                    3,
                    onPressedCancelar,
                    'Cancelar',
                    icono: Icons.cancel,
                    classColor: 'secondary',
                  )
                ],
              )
            ],
          );
        });

    return Scaffold(
      appBar: AppBar(
        title: Text("Registrar citas"),
      ),
      body: buildForm(),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: fechaSeleccionada,
        firstDate: DateTime(2020),
        lastDate: DateTime(2035),
        initialEntryMode: DatePickerEntryMode.input,
        helpText: 'Selecciona una fecha',
        cancelText: 'Cancelar',
        confirmText: 'Agendar');

    if (picked != null && picked != fechaSeleccionada) {
      setState(() {
        fechaSeleccionada = picked;
        fechaController.text =
            fechaSeleccionada.toLocal().toString().split(' ')[0];
      });
    }
  }

  _selectHour(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        helpText: 'Seleccione una hora');

    if (newTime != null && newTime != horaSeleccionada) {
      setState(() {
        horaSeleccionada = newTime;
        horaController.text =
            'Hora: ${horaSeleccionada.hourOfPeriod}:${horaSeleccionada.minute} ${horaSeleccionada.period.index == 0 ? 'am' : 'pm'}';
      });
    }
  }

  onPressedRegistrarCita(id) {
    Cita cita = Cita(
        0,
        fechaSeleccionada,
        horaSeleccionada,
        situacionController.text,
        double.parse(precioController.text),
        (pacienteSeleccionado == null) ? 0 : pacienteSeleccionado!.idPaciente,
        0);
  }

  registrarCita(Cita cita) {}
}
