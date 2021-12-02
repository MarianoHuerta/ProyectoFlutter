import 'package:flutter/material.dart';
import '/model/consultorio.dart';

class CardConsultorio extends StatelessWidget {
  final Consultorio consultorio;

  const CardConsultorio({Key? key, required this.consultorio})
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
                child: Text('ID: ${consultorio.idConsultorio}',
                    style: TextStyle(
                        color: Colors.teal[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
              ),
              Container(
                  child: Text('Numero: ${consultorio.numero}',
                      style: TextStyle(fontSize: 18))),
            ],
          ),
          onTap: () {
            Navigator.pushNamed(context, '/modificar-consultorio',
                arguments: {'action': 'editar', 'consultorio': consultorio});
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
