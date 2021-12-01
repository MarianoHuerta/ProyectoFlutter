import 'package:flutter/material.dart';

class menuPaciente extends StatefulWidget {
  menuPaciente({Key? key}) : super(key: key);

  @override
  _menuPacienteState createState() => _menuPacienteState();
}

class _menuPacienteState extends State<menuPaciente> {
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
          Text('Mostrara todas la lista de sus citas:'),
          _botonConsultarCitas(),
          Divider(),
          Text('Mostrara sus datos y podra modificarlos:'),
          _botonModificarDatos(),
          Divider(),
          Text('dar por finalizada su perfil'),
          _botonCerrarSesion(),
        ],
      ),
    );
  }


  Widget _botonConsultarCitas(){
    return ElevatedButton.icon(
      icon: Icon(
        Icons.menu_book
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
      label: Text('Consultar Citas'),
      onPressed: (){
        //onpressed direccionar al menu de paciente
      },
      );
  }


  Widget _botonModificarDatos(){
    return ElevatedButton.icon(
      icon: Icon(
        Icons.manage_accounts
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
      label: Text('Modificar Datos'),
      onPressed: (){
        //Onpressed direccionar al menu de modificar datos
      }
      );
  }

  Widget _botonCerrarSesion(){
    return ElevatedButton.icon(
      icon: Icon(
        Icons.logout_sharp
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
      label: Text('Cerrar Sesion'),
      onPressed: (){
        Navigator.pop(context);
      },
    );
  }

}