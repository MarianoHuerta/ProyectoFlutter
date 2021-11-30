import 'package:flutter/material.dart';

class PersonalButton extends StatelessWidget {
  final String texto;
  final IconData icono;

  const PersonalButton(
    this.texto,
    {
    Key? key,
    this.icono = Icons.accessibility
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 50.0, right: 50.0),
      height: 50.0,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0)   
          ),
          primary: Colors.teal,
          textStyle: TextStyle(
            color: Colors.white,
            //fontFamily: "Poppis-Regular",
            fontSize: 16.0,
          )
        ),
        label: Text(this.texto),
        icon: Icon(this.icono),
        onPressed: (){
          print('boton');
        },
      ) 
    );
  }
}