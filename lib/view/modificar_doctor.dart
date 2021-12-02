import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '/components/personal_button.dart';
import '/components/personal_textField.dart';
import '/model/consultorio.dart';
import '/model/doctor.dart';

import '/util/constants.dart' as Constants;

class ModificarDoctor extends StatefulWidget {
  @override
  _ModificarDoctorState createState() => _ModificarDoctorState();
}

class _ModificarDoctorState extends State<ModificarDoctor> {
  DateTime fechaSeleccionada = DateTime.now();
  Consultorio? consultorioSeleccionado;

  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidosController = TextEditingController();
  TextEditingController edadController = TextEditingController();
  TextEditingController fechaController = TextEditingController();
  List<Consultorio> consultorios = [];

  var urlConsultorio = Uri.parse(
      'http://${Constants.IP_CONEXION}/proyecto_topicos/consultar_consultorio.php');

  var urlDoctor = Uri.parse(
      'http://${Constants.IP_CONEXION}/proyecto_topicos/Modificar_doctor.php');

  Future<List<Consultorio>> consultaPacientes() async {
    final response = await http.get(urlConsultorio);
    print(response.body);

    return (jsonDecode(response.body) as List)
        .map((value) => Consultorio.fromJson(value))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    onPressedCancelar(id) {
      Navigator.pop(context);
    }

    Widget buildForm() => FutureBuilder<List<Consultorio>>(
        future: consultaPacientes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(
                child: Text('Error al cargar los consultorios'));
          }
          if (snapshot.data!.isNotEmpty) {
            snapshot.data!.forEach((element) {
              if (!consultorios.any((consultorio) =>
                  consultorio.idConsultorio == element.idConsultorio)) {
                consultorios.add(element);
              }
            });
          }
          return ListView(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 15, 10, 5),
                child: DropdownButtonFormField<Consultorio>(
                  value: consultorioSeleccionado,
                  isExpanded: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    hintText: 'Seleccione un consultorio',
                    labelText: 'Seleccione un consultorio',
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.teal[400],
                    ),
                  ),
                  items: consultorios
                      .map<DropdownMenuItem<Consultorio>>((Consultorio value) {
                    return DropdownMenuItem<Consultorio>(
                      child: Text('${value.numero}'),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (Consultorio? value) {
                    setState(() {
                      consultorioSeleccionado = value;
                    });
                  },
                ),
              ),
              Container(
                child: PersonalTextField(nombreController, 'Nombres', 'Nombres',
                    icono: Icons.account_circle, maxLineas: 3, minLineas: 1),
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
              ),
              Container(
                child: PersonalTextField(
                    apellidosController, 'Apellidos', 'Apellidos',
                    icono: Icons.list_alt),
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
                child: TextField(
                  controller: edadController,
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: 'Edad',
                      hintText: 'Edad',
                      prefixIcon: Icon(
                        Icons.calendar_today,
                        color: Colors.teal[600],
                      )),
                ),
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
                      labelText: 'Fecha de nacimiento',
                      hintText: 'Fecha',
                      prefixIcon: Icon(
                        Icons.perm_contact_calendar,
                        color: Colors.teal[600],
                      )),
                  onTap: () => _selectDate(context),
                  readOnly: true,
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PersonalButton(1, onPressedModificarDoctor, 'Modificar',
                      icono: Icons.add_sharp, classColor: 'primary'),
                  PersonalButton(
                    2,
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
        title: Text("Modificar doctor"),
      ),
      body: buildForm(),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: fechaSeleccionada,
        firstDate: DateTime(1960),
        lastDate: DateTime(2035),
        initialEntryMode: DatePickerEntryMode.input,
        helpText: 'Selecciona una fecha',
        cancelText: 'Cancelar',
        confirmText: 'Seleccionar');

    if (picked != null && picked != fechaSeleccionada) {
      setState(() {
        fechaSeleccionada = picked;
        fechaController.text =
            fechaSeleccionada.toLocal().toString().split(' ')[0];
      });
    }
  }

  onPressedModificarDoctor(id) async {
    Doctor cita = Doctor(
        idDoctor: 0,
        nombres: nombreController.text,
        apellidos: apellidosController.text,
        idConsultorio: consultorioSeleccionado!.idConsultorio,
        edad: int.parse(edadController.text),
        fechaNaci: fechaController.text);
    await ModificarDoctor(cita);
  }

  Future ModificarDoctor(Doctor doctor) async {
    final response = await http.post(urlDoctor, body: doctor.toJson());
    print(response.body);

    var message = json.decode(response.body);
    _mostrarMensaje('Se ha registrado con éxito',
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
