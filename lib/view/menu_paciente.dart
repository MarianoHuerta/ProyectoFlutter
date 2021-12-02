import 'package:flutter/material.dart';
import '/components/personal_button.dart';

class menuPaciente extends StatefulWidget {
  menuPaciente({Key? key}) : super(key: key);

  @override
  _menuPacienteState createState() => _menuPacienteState();
}

class _menuPacienteState extends State<menuPaciente> {
  int id = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Paciente'),
      ),

      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 20.0,
        ),

        children: [
          Text('Mostrara todas la lista de sus citas:'),
          new PersonalButton(id, onPressedConsultarCita, 'Consultar Citas', icono: Icons.menu_book,),
          Divider(),
          Text('Mostrara sus datos y podra modificarlos:'),
          new PersonalButton(id, onPressedModificarDatos, 'Modificar Datos', icono: Icons.manage_accounts),
          Divider(),
          Text('dar por finalizada su perfil'),
          new PersonalButton(id, onPressedCerrarSesion, 'Cerrar Sesion', icono: Icons.logout,)
        ],
      ),
    );
  }

  onPressedConsultarCita(id){
    Navigator.pushNamed(context, '/consulta-citas');
  }

  onPressedModificarDatos(id){
    Navigator.pushNamed(context, '/modificar-paciente');
  }

  onPressedCerrarSesion(id){
    Navigator.pop(context);
  }
}