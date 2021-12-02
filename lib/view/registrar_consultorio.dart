import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '/components/personal_button.dart';
import '/components/personal_textField.dart';
import '/model/consultorio.dart';

import '/util/constants.dart' as Constants;

class FormConsultorio extends StatefulWidget {
  @override
  _FormConsultorioState createState() => _FormConsultorioState();
}

class _FormConsultorioState extends State<FormConsultorio> {

  TextEditingController numeroController = TextEditingController();

  var urlConsultorio = Uri.parse(
      'http://${Constants.IP_CONEXION}/proyecto_topicos/RegistrarConsultorio.php');


  @override
  Widget build(BuildContext context) {
    onPressedCancelar(id) {
      Navigator.pop(context);
    }

    Widget build(BuildContext context) {
  return Column(
    children: <Widget>[
              Container(
                child: PersonalTextField(numeroController, 'Numero', 'Numero de consultorio',
                    icono: Icons.account_circle, maxLineas: 3, minLineas: 1),
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
              ),
              
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PersonalButton(16, onPressedGuardarConsultorio, 'Guardar',
                      icono: Icons.add_sharp, classColor: 'primary'),
                  PersonalButton(
                    17,
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
        title: Text("Registrar Consultorio"),
      ),
      body: build(context),
    );
  }
 

  onPressedGuardarConsultorio(id) async {
    Consultorio cita = Consultorio(
        idConsultorio: 0,
        numero: int.parse(numeroController.text));
    await registrarConsultorio(cita);
  }

  Future registrarConsultorio(Consultorio consultorio) async {
    final response = await http.post(urlConsultorio, body: consultorio.toJson());
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
