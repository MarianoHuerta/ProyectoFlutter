import 'package:flutter/material.dart';

class CardCita extends StatelessWidget {
  final int number;

  const CardCita({Key? key, required this.number}) : super(key: key);

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
                child: Text('Fecha: $number/$number/2021',
                    style: TextStyle(
                        color: Colors.teal[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
              ),
              Container(
                  child: Text('Nombre: Juan$number',
                      style: TextStyle(fontSize: 18))),
              Container(
                child: Text('Apellidos: López$number Gonzalez$number',
                    style: TextStyle(fontSize: 18)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: Text('Edad: $number',
                          style: TextStyle(fontSize: 18))),
                ],
              )
            ],
          ),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Número $number editado')));
          },
          leading: Icon(
            Icons.calendar_today_rounded,
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
