import 'package:flutter/material.dart';

class PersonalTextField extends StatelessWidget {
  final TextEditingController controller;
  final String texto;
  final String label;
  final IconData icono;
  final int maxLineas;
  final int minLineas;

  const PersonalTextField(this.controller, this.texto, this.label,
      {Key? key,
      this.icono = Icons.accessibility,
      this.maxLineas = 0,
      this.minLineas = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: this.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: this.texto,
        labelText: this.label,
        prefixIcon: Icon(this.icono, color: Colors.teal[400]),
        //suffixIcon: Icon(Icons.meeting_room)
      ),
      maxLines: (maxLineas != 0) ? maxLineas : 1,
      minLines: (minLineas != 0) ? minLineas : 1,
    );
  }
}
