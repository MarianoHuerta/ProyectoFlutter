import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:proyecto_topicos/components/personal_button.dart';
import 'package:proyecto_topicos/components/personal_textField.dart';

class registroPaciente extends StatefulWidget {
  registroPaciente({Key? key}) : super(key: key);

  @override
  _registroPacienteState createState() => _registroPacienteState();
}

class _registroPacienteState extends State<registroPaciente> {
  TextEditingController nombre = new TextEditingController();
  TextEditingController apellido = new TextEditingController();
  TextEditingController usuario = new TextEditingController();
  TextEditingController contrasenia = new TextEditingController();
  TextEditingController _inputFieldDateController = new TextEditingController();

  String _nombre = '';
  String _Apellido = '';
  String _fecha='';
  int _edad = 0;
  String _usuario = '';
  String _contrasenia = '';
  int id = 1;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Paciente'),

      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 20.0,

        ),
        children: [
          new PersonalTextField(nombre, 'Nombre', 'Ingresar Nombre', icono: Icons.accessibility),
          Divider(),
          new PersonalTextField(apellido, 'Apellido', 'Ingresar Apellido', icono: Icons.accessibility),
          Divider(),
          _crearFecha(context),
          Divider(),
          new PersonalTextField(usuario, 'Usuario', 'Ingresar Usuario'),
          Divider(),
          new PersonalTextField(usuario, 'Usuario', 'Ingresar Usuario',obs: true),
          _crearContrasena(),
          Divider(),
          new PersonalButton(id, onPressendRP, 'Registrar', icono: Icons.add),
          Divider(),
          _registrarBoton(),
          Divider(),
          _salirBoton(),
        ],
      ),

    );
  }

  Widget _crearNombre(){
    return TextField(
      controller: nombre,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: 'Ingrese su Nombre Completo',
        labelText: 'Nombre',
        suffixIcon: Icon(Icons.accessibility),
      ),
    );
  }

  Widget _crearApellido(){
    return TextField(
      controller: apellido,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: 'Ingrese su Apellido Completo',
        labelText: 'Apellido',
        suffixIcon: Icon(Icons.accessibility),
      ),
    );
  }

  Widget _crearFecha(BuildContext context){
    return TextField(
      controller: _inputFieldDateController,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: 'Fecha de Nacimiento',
        labelText: 'Fecha de Nacimeinto',
        suffixIcon: Icon(Icons.calendar_today),
      ),
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
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
        _inputFieldDateController.text = _fecha;
      });
    }
  }

  Widget _crearUsuario(){
    return TextField(
      controller: usuario,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: 'Ingrese su Usuario',
        labelText: 'Usuario',
        suffixIcon: Icon(Icons.person_sharp),
      ),
    );
  }

  Widget _crearContrasena(){
    return TextField(
      controller: contrasenia,
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: 'Ingrese su contraseña',
        labelText: 'contraseña',
        suffixIcon: Icon(Icons.lock_open),
      ),
    );
  }

  onPressendRP(id){
    setState(() {
      if(nombre.text == "" || apellido.text == "" || _inputFieldDateController.text == "" || usuario.text == "" || contrasenia.text == ""){
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
        registrar();
        Navigator.pop(context);
      }
      
      nombre.text='';
      apellido.text='';
      _edad=0;
    });
  }
  
  Widget _registrarBoton(){
    return ElevatedButton.icon(
      icon: Icon(
        Icons.add_circle_outline
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
        setState(() {

          if(nombre.text == "" || apellido.text == "" || _inputFieldDateController.text == "" || usuario.text == "" || contrasenia.text == ""){
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
            registrar();
            Navigator.pop(context);
          }
          
          nombre.text='';
          apellido.text='';
          _edad=0;
        });
      },
      );
  }


  Widget _salirBoton(){
    return ElevatedButton.icon(
      icon: Icon(
        Icons.arrow_back
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
      label: Text('Regresar'),
      onPressed: (){
        Navigator.pop(context);
      },
      );
  }

  void registrar() {
    print(nombre.text);
    print(apellido.text);
    print(_inputFieldDateController.text);
    print(_edad);
    print(usuario.text);
    print(contrasenia.text);
    /*var url = "http://ip/NameDB/RegistrarPaciente.php";

    http.post(url, body: {
      "Nombres": nombre.text,
      "Apellidos": apellido.text,
      "FechaNaci": _inputFieldDateController.text,
      "Edad": _edad,
      "Nombre": usuario.text,
      "Contrasenia": contrasenia.text
    });*/
  }

}