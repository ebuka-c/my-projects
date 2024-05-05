import 'package:flutter/material.dart';

class MyAlert extends StatelessWidget {
  final Function() onSaved;
  final Function() onCancel;
  final TextEditingController controller;
  const MyAlert(
      {super.key,
      required this.onSaved,
      required this.onCancel,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Colors.yellow,
        content: SizedBox(
            height: 150,
            child: Column(children: [
              const SizedBox(height: 20),
              TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                      fillColor: Colors.white,
                      hintText: 'Add a new task',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal)))),
              const SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                MaterialButton(
                    color: Colors.yellow[200],
                    onPressed: onSaved,
                    child: const Text('Save')),
                const SizedBox(
                  width: 5,
                ),
                MaterialButton(
                    color: Colors.yellow[200],
                    onPressed: onCancel,
                    child: const Text('Cancel')),
              ])
            ])));
  }
}
