import 'package:flutter/material.dart';
import 'package:proyecto_topicos/components/personal_button.dart';

class menuMedico extends StatefulWidget {
  menuMedico({Key? key}) : super(key: key);

  @override
  _menuMedicoState createState() => _menuMedicoState();
}

class _menuMedicoState extends State<menuMedico> {
  int id = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Medico'),
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
    //Navigator.push(context, MaterialPageRoute(builder: (context) => NombredelDart()));
  }

  onPressedModificarDatos(id){
    //Navigator.push(context, MaterialPageRoute(builder: (context) => NombredelDart()));
  }

  onPressedCerrarSesion(id){
    Navigator.pop(context);
  }


}