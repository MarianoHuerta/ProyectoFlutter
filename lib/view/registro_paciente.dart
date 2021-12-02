import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '/components/personal_button.dart';
import '/components/personal_textField.dart';
import '/model/consultorio.dart';
import '/model/paciente.dart';

import '/util/constants.dart' as Constants;

class FormPaciente extends StatefulWidget {
  @override
  _FormPacienteState createState() => _FormPacienteState();
}

class _FormPacienteState extends State<FormPaciente> {
  DateTime fechaSeleccionada = DateTime.now();
  Consultorio? consultorioSeleccionado;

  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidosController = TextEditingController();
  TextEditingController edadController = TextEditingController();
  TextEditingController fechaController = TextEditingController();

  String _fecha='';
  int _edad = 0;

  var urlPaciente = Uri.parse(
      'http://${Constants.IP_CONEXION}/proyecto_topicos/registrar_paciente.php');


  @override
  Widget build(BuildContext context) {
    onPressedCancelar(id) {
      Navigator.pop(context);
    }

    Widget build(BuildContext context) {
  return Column(
    children: <Widget>[
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
                  PersonalButton(1, onPressedGuardarPaciente, 'Siguiente',
                      icono: Icons.add_sharp, classColor: 'primary'),
                  PersonalButton(
                    2,
                    onPressedCancelar,
                    'Cancelar',
                    icono: Icons.cancel,
                    classColor: 'secondary',                  
            ),
        ],
      )
    ],
  );
}

    return Scaffold(
      appBar: AppBar(
        title: Text("Registrar Paciente"),
      ),
      body: build(context),
    );
  }
 _selectDate(BuildContext context) async {
    DateTime? picked= await showDatePicker(
      context: context, 
      initialDate: new DateTime.now(), 
      firstDate: new DateTime(1960), 
      lastDate: new DateTime.now()
      );
      
    if(picked != null){
      setState(() {
        DateTime ano = DateTime.now();
        _edad = ano.year - picked.year - 1;
        _edad = _edad + 1;
        
        _fecha = picked.toString();
        fechaController.text = _fecha;
      });
    }
  }

  onPressedGuardarPaciente(id) async {
    Paciente cita = Paciente(
        idPaciente: 0,
        nombres: nombreController.text,
        apellidos: apellidosController.text,
        edad: _edad,
        fechaNaci: fechaController.text);
    await registrarPaciente(cita);
    Navigator.pushNamed(context, '/registrar-user');
  }

  Future registrarPaciente(Paciente Paciente) async {
    final response = await http.post(urlPaciente, body: Paciente.toJson());
    print(response.body);

    var message = json.decode(response.body.toString());
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
