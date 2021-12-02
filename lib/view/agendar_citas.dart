import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '/components/personal_button.dart';
import '/components/personal_textField.dart';
import '/model/cita.dart';
import '/model/paciente.dart';

import '/util/constants.dart' as Constants;

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

  var urlPacientes = Uri.parse(
      'http://${Constants.IP_CONEXION}/proyecto_topicos/consulta_pacientes.php');

  var urlCitas = Uri.parse(
      'http://${Constants.IP_CONEXION}/proyecto_topicos/registrar_cita.php');

  var urlEditarCitas = Uri.parse(
      'http://${Constants.IP_CONEXION}/proyecto_topicos/editar_cita.php');

  Future<List<Paciente>> consultaPacientes() async {
    final response = await http.get(urlPacientes);

    return (jsonDecode(response.body) as List)
        .map((value) => Paciente.fromJson(value))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    Cita? citaEditar;

    if (arg['action'] == 'editar') {
      citaEditar = arg['cita'];
    }

    onPressedCancelar(id) {
      Navigator.pop(context);
    }

    onPressedEditarCita(id) async {
      if (citaEditar != null) {
        citaEditar.fecha = fechaController.text;
        citaEditar.hora = horaController.text;
        citaEditar.situacion = situacionController.text;
        citaEditar.precio = double.parse(precioController.text);
        citaEditar.idPaciente = pacienteSeleccionado!.idPaciente;
      }
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
          if (snapshot.data!.isNotEmpty) {
            snapshot.data!.forEach((element) {
              if (!pacientes.any(
                  (paciente) => paciente.idPaciente == element.idPaciente)) {
                pacientes.add(element);
              }
            });
          }
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
            '${horaSeleccionada.hour}:${horaSeleccionada.minute}';
      });
    }
  }

  onPressedRegistrarCita(id) async {
    Cita cita = Cita(
        0,
        fechaController.text,
        horaController.text,
        situacionController.text,
        double.parse(precioController.text),
        pacienteSeleccionado!.idPaciente,
        2);
    await registrarCita(cita);
  }

  Future registrarCita(Cita cita) async {
    final response = await http.post(urlCitas, body: cita.toJson());

    var message = json.decode(response.body);
    _mostrarMensaje('Se ha registrado su cita',
        'Ha habido un error vuelva a intentarlo', message['status']);
  }

  Future editarCita(Cita cita) async {
    final response = await http.post(urlEditarCitas, body: cita.toJson());

    var message = json.decode(response.body);
    _mostrarMensaje('Se ha actualizado su cita',
        'Ha habido un error vuelva a intentarlo', message['status']);
  }

  _mostrarMensaje(String mensajeExito, String mensajeError, bool status) {
    var colorMessage;
    var textMessage;

    if (status) {
      colorMessage = Colors.green[300];
      textMessage = mensajeExito;
    } else {
      colorMessage = Colors.red[300];
      textMessage = mensajeError;
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(textMessage),
      backgroundColor: colorMessage,
    ));
  }
}
