import 'dart:convert';

import 'package:flutter/material.dart';

import '/components/personal_button.dart';
import '/components/personal_textField.dart';

class registroDoctor extends StatefulWidget {
  registroDoctor({Key? key}) : super(key: key);

  @override
  _registroDoctorState createState() => _registroDoctorState();
}

class _registroDoctorState extends State<registroDoctor> {
  final nombre = TextEditingController();
  final apellido = TextEditingController();

  String _nombre = '';
  String _Apellido = '';
  String _fecha='';
  int _edad = 0;
  String _opcion = 'Volar';

  List<String> _consultorios = ['Volar', 'Rayo X', 'Super Aliento', 'super Fuerza'];

  TextEditingController numeroController = new TextEditingController();
  int id = 11;
  String _numero = '';
  TextEditingController _inputFieldDateController = new TextEditingController();
 onPressedConsultorio(id){
    _numero = numeroController.text;
    print('press $_numero');
    numeroController.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Doctor'),

      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 20.0,

        ),
        children: [
          new PersonalTextField(numeroController, 'Nombre', 'Nombre Paciente', icono: Icons.accessibility),
          Divider(),
          new PersonalTextField(numeroController, 'Apellidos', 'Apellidos Paciente', icono: Icons.accessibility),
          Divider(),
          new PersonalTextField(numeroController, 'Edad', 'Edad Paciente', icono: Icons.accessibility),
          Divider(),
          _crearFecha(context),
          Divider(),
          new PersonalTextField(numeroController, 'Usuario', 'Usuario', icono: Icons.person),
          Divider(),
          new PersonalTextField(numeroController, 'Contraseña', 'Contraseña', icono: Icons.password),
          Divider(),
          _ListaConsultorios(),
          Divider(),
          
          new PersonalButton(id, onPressedConsultorio, 'Registrar', icono: Icons.add),
          Divider(),
          _salirBoton(),
        ],
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
        if(ano.month >= picked.month){
          _edad = ano.year - picked.year;
        }else{
          _edad = ano.year - picked.year - 1;
        }
        
        _fecha = picked.toString();
        _inputFieldDateController.text = _fecha;
      });
    }
  }
    List<DropdownMenuItem<String>> getOpcionesDropdown(){
    List<DropdownMenuItem<String>> lista = [];
    _consultorios.forEach((poder) {
      lista.add(
        DropdownMenuItem(
          child: Text(poder),
          value: poder,
        )
      );
    });
    return lista;
  }

  Widget _ListaConsultorios() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.teal, width: 2.0),
                borderRadius: BorderRadius.circular(20.0)),
              child: DropdownButton<String>(
                dropdownColor: Colors.teal[300],
                elevation: 5,
                icon: Icon(Icons.keyboard_arrow_down),
                isExpanded: true,
                value: _opcion,
                style: TextStyle(color: Colors.black, fontSize: 16.0),
                items: getOpcionesDropdown(),
                onChanged: (opt){
                  setState(() {
                    _opcion = opt.toString();
                  });
                },
              ),
        ),
      ), 
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

}