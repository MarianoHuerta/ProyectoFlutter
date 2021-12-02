import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:proyecto_topicos/components/personal_button.dart';
import 'package:proyecto_topicos/components/personal_textField.dart';
import 'package:proyecto_topicos/view/menuAdmin.dart';
import 'package:proyecto_topicos/view/menuMedico.dart';
import '/view/registroPaciente.dart';

import 'menuPaciente.dart';

//import 'package:http/http.dart' as http;

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
      Navigator.push(context, 
      MaterialPageRoute(builder: (context) => MenuAdmin()));
      //login(context);
    }
  }

  onPressedRegistrar(id){
    Navigator.push(context, 
    MaterialPageRoute(builder: (context) => registroPaciente()));
  }



  Widget _botonLogin(){
    return ElevatedButton.icon(
      icon: Icon(
        Icons.login_outlined
      ),
      label: Text('Entrar'),
      onPressed: (){
        setState(() {
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
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => menuPaciente()));
            //login(context);
          }
        });
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        primary: Colors.teal,
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontStyle: FontStyle.italic
        )
      ),
      );
  }


  Widget _botonRegistrar(){
    return ElevatedButton.icon(
      icon: Icon(
        Icons.person_add
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        primary: Colors.teal,
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontStyle: FontStyle.italic
        )
      ),
      label: Text('Registrar'),
      onPressed: (){
        Navigator.push(context, 
        MaterialPageRoute(builder: (context) => registroPaciente()));
      }, 
      );
  }

  var url = Uri.parse('http://192.168.1.14/tienda/login.php');

  /*Future<List> login(BuildContext context) async {
    final response = await http.post(url, body: {
      "Nombre": controllerNombre.text,
      "Contrasenia": controllerPass.text,
    });

    var datauser = json.decode(response.body);

    if (datauser.length == 0) {
      setState(() {
        mensaje = "Login Fail";
      });
    } else {
      if (datauser[0]['IdRol'] == 'admin') {
        /////////////////////////////////////////ADMIN/////////////////////////////////////
        Navigator.pushNamed(context, '/menuAdmin');
        FocusScope.of(context).unfocus();
        //print('datos correctos');
      } else if (datauser[0]['IdRol'] == 'paciente') {
        /////////////////////////////////////////PACIENTE///////////////////////////////////
        Navigator.of(context).pushNamed('/menuPaciente');
        FocusScope.of(context).unfocus();
      }
      setState(() {
        username = datauser[0]['Nombre'];
      });
    }

    return datauser;
  }*/
}