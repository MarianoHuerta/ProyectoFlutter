import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormCitas extends StatefulWidget {
  @override
  _FormCitasState createState() => _FormCitasState();
}

class _FormCitasState extends State<FormCitas> {
  DateTime fechaSeleccionada = DateTime.now();
  TimeOfDay horaSeleccionada = TimeOfDay.now();
  String? pacienteSeleccionado;
  TextEditingController situacionController = TextEditingController();
  TextEditingController precioController = TextEditingController();
  TextEditingController fechaController = TextEditingController();
  TextEditingController horaController = TextEditingController();
  List<String> pacientes = ['Juan', 'María', 'José'];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Registrar citas"),
        ),
        body: buildForm(),
      );

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: fechaSeleccionada,
        firstDate: DateTime(2020),
        lastDate: DateTime(2035),
        initialEntryMode: DatePickerEntryMode.input,
        helpText: 'Selecciona una fecha',
        cancelText: 'Cancelar',
        confirmText: 'Agendar');

    if (picked != null && picked != fechaSeleccionada) {
      setState(() {
        fechaSeleccionada = picked;
        fechaController.text =
            fechaSeleccionada.toLocal().toString().split(' ')[0];
      });
    }
  }

  _selectHour(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        helpText: 'Seleccione una hora');

    if (newTime != null && newTime != horaSeleccionada) {
      setState(() {
        horaSeleccionada = newTime;
        horaController.text =
            'Hora: ${horaSeleccionada.hourOfPeriod}:${horaSeleccionada.minute} ${horaSeleccionada.period.index == 0 ? 'am' : 'pm'}';
      });
    }
  }

  Widget buildForm() => ListView(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 15, 10, 5),
            child: DropdownButtonFormField<String>(
              value: pacienteSeleccionado,
              isExpanded: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(
                  Icons.person,
                  color: Colors.teal[400],
                ),
              ),
              items: pacientes.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                    child: Text(value), value: value);
              }).toList(),
              hint: Text('Selecicone un paciente'),
              onChanged: (String? value) {
                setState(() {
                  pacienteSeleccionado = value;
                });
              },
            ),
          ),
          Container(
            child: TextField(
              minLines: 2,
              maxLines: 5,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Situación',
                  icon: Icon(
                    Icons.list_alt,
                    color: Colors.teal[400],
                  )),
              controller: situacionController,
            ),
            padding: EdgeInsets.fromLTRB(10, 15, 10, 5),
          ),
          Container(
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Precio',
                  icon: Icon(Icons.monetization_on, color: Colors.teal[400])),
              controller: situacionController,
            ),
            padding: EdgeInsets.fromLTRB(10, 15, 10, 5),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 15, 10, 5),
            child: TextField(
              controller: fechaController,
              enableInteractiveSelection: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Fecha a agendar',
                  icon: Icon(
                    Icons.calendar_today,
                    color: Colors.teal[600],
                  )),
              onTap: () => _selectDate(context),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 15, 10, 5),
            child: TextField(
              controller: horaController,
              enableInteractiveSelection: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Hora de la cita',
                  icon: Icon(
                    Icons.timer,
                    color: Colors.teal[600],
                  )),
              onTap: () => _selectHour(context),
            ),
          ),
        ],
      );
}
