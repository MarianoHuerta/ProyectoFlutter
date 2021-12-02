import 'package:flutter/material.dart';
import '/model/rol.dart';

class CardRol extends StatelessWidget {
  final Rol rol;

  const CardRol({Key? key, required this.rol})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: ListTile(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text('ID: ${rol.idRol}',
                    style: TextStyle(
                        color: Colors.teal[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
              ),
              Container(
                  child: Text('Nombre: ${rol.nombre}',
                      style: TextStyle(fontSize: 18))),
            ],
          ),
          onTap: () {
            Navigator.pushNamed(context, '/modificar-rol',
                arguments: {'action': 'editar', 'rol': rol});
          },
          leading: Icon(
            Icons.manage_accounts,
            color: Colors.teal[200],
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 16.0,
      ),
      padding: EdgeInsets.symmetric(vertical: 5),
    );
  }
}
