import 'package:flutter/material.dart';

class PersonalButton extends StatelessWidget {
  final int id;
  final Function(int) onPressed;
  final String texto;
  final IconData icono;
  final String classColor;

  const PersonalButton(this.id, this.onPressed, this.texto,
      {Key? key, this.icono = Icons.accessibility, this.classColor = 'default'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 30.0, right: 30.0),
        height: 50.0,
        child: ElevatedButton.icon(
          onPressed: () {
            onPressed(this.id);
          },
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              primary: (classColor != 'default')
                  ? getColorValue(classColor)
                  : Colors.teal,
              textStyle: TextStyle(
                color: Colors.white,
                //fontFamily: "Poppis-Regular",
                fontSize: 16.0,
              )),
          label: Text(this.texto),
          icon: Icon(this.icono),
        ));
  }

  getColorValue(classColor) {
    switch (classColor.toLowerCase()) {
      case 'primary':
        return Colors.teal[300];
      case 'secondary':
        return Colors.grey[600];
      case 'danger':
        return Colors.red[300];
      case 'success':
        return Colors.green[200];
      case 'info':
        return Colors.cyan[600];
      case 'warning':
        return Colors.amber[200];
      default:
        return Colors.teal;
    }
  }
}
