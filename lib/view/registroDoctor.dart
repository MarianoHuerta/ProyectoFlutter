import 'dart:convert';

import 'package:flutter/material.dart';

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

  
  TextEditingController _inputFieldDateController = new TextEditingController();

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
          _crearNombre(),
          Divider(),
          _crearApellido(),
          Divider(),
          _crearFecha(context),
          Divider(),
          _crearUsuario(),
          Divider(),
          _crearContrasena(),
          Divider(),
          _ListaConsultorios(),
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

  Widget _crearUsuario(){
    return TextField(
      controller: apellido,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: 'Ingrese su Usuario',
        labelText: 'Usuario',
        suffixIcon: Icon(Icons.person),
      ),
    );
  }

  Widget _crearContrasena(){
    return TextField(
      controller: apellido,
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: 'Ingrese su Contraseña',
        labelText: 'Contraseña',
        suffixIcon: Icon(Icons.password),
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
          _nombre = nombre.text;
          _Apellido = apellido.text;
          
          print("$_nombre $_Apellido $_fecha $_edad");
          
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

}