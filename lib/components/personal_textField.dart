import 'package:flutter/material.dart';

class PersonalTextField extends StatelessWidget {
  final String texto;
  final String label;
  final IconData icono;

  const PersonalTextField(
    this.texto,
    this.label,
    {
    Key? key,
    this.icono = Icons.accessibility
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: this.texto,
        labelText: this.label,
        prefixIcon: Icon(this.icono),
        //suffixIcon: Icon(Icons.meeting_room)
      ),
    );
  }
}