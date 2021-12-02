import 'dart:convert';

import '/view/menu_medico.dart';
import 'package:flutter/material.dart';
import '/components/personal_button.dart';
import '/components/personal_textField.dart';
import '/view/menu_admin.dart';
import '/view/menu_paciente.dart';
import '/view/registro_paciente.dart';

import '/util/constants.dart' as Constants;

import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}
String username = '';

class _LoginState extends State<Login> {

  TextEditingController Usuario = TextEditingController();
  TextEditingController Contrasenia = TextEditingController();
  String mensaje = '';

  String _nombre ='';
  String _password = '';
  int id = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),

      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 20.0,

        ),
        children: [
          new PersonalTextField(Usuario, 'Usuario', 'Ingrese Usuario', icono: Icons.accessibility),
          Divider(),
          new PersonalTextField(Contrasenia, 'Contraseña', 'Ingrese Contraseña', icono: Icons.lock_open, obs: true,),
          Divider(),
          new PersonalButton(id, onPressedLogin, 'Entrar', icono: Icons.login),
          Divider(),
          Text('Si no estas registrado, unete con el boton "Registrar"'),
          new PersonalButton(id, onPressedRegistrar, 'Registrar', icono: Icons.person_add,)
        ],
      ),

    );
  }

  onPressedLogin(id){
    _nombre= Usuario.text;
    _password = Contrasenia.text;

    if(_nombre == "" || _password == ""){
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Llene los campos'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [Text('Es obligatorio que llene los campos')],
              ),
            ),
            actions: [
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                }, child: Text('Aceptar'))
            ],
          );
        });
    }else{
      //Navigator.push(context, 
      //MaterialPageRoute(builder: (context) => menuMedico()));
      print(Usuario.text);
      print(Contrasenia.text);
      login(context);
    }
  }

  onPressedRegistrar(id){
    Navigator.push(context, 
    MaterialPageRoute(builder: (context) => FormPaciente()));
  }

  var url = Uri.parse('http://${Constants.IP_CONEXION}/proyecto_topicos/login.php');

  Future<List> login(BuildContext context) async {
    
    final response = await http.post(url, body: {
      "Nombre": Usuario.text,
      "Contrasenia": Contrasenia.text,
    });

    var datauser = json.decode(response.body);

    if (datauser.length == 0) {
      setState(() {
        mensaje = "Login Fail";
      });
    } else {
      if (datauser[0]['IdRol'] == '1') {
        /////////////////////////////////////////ADMIN/////////////////////////////////////
        Navigator.pushNamed(context, '/menu-admin');
        FocusScope.of(context).unfocus();
        //print('datos correctos');
      } else if (datauser[0]['IdRol'] == '2') {
        /////////////////////////////////////////PACIENTE///////////////////////////////////
        Navigator.of(context).pushNamed('/menu-doctor');
        FocusScope.of(context).unfocus();
      }else if (datauser[0]['IdRol'] == '3') {
        /////////////////////////////////////////PACIENTE///////////////////////////////////
        Navigator.of(context).pushNamed('/menu-paciente');
        FocusScope.of(context).unfocus();
      }
      setState(() {
        username = datauser[0]['Nombre'];
      });
    }

    return datauser;
  }
}