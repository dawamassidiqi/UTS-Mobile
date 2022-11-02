import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_listview/service/tasklist.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  void submit() {
    setState(() {
      isSubmitted = true;
    });
    if (_formKey.currentState!.validate()) {
      context.read<Tasklist>().addTask();
      Navigator.pop(context, true);
    } else {
      isBener = false;
    }
  }

  final TextEditingController _taskName = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _task = "";
  bool isSubmitted = false;
  bool isBener = true;
  bool isKosong = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Task Baru"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                autovalidateMode: isSubmitted
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    isBener = false;
                    return 'Can\'t be empty';
                  }
                  if (value.length < 4) {
                    isBener = false;
                    return 'Too short';
                  }
                  return null;
                },
                controller: _taskName,
                decoration: const InputDecoration(
                  hintText: "Masukkan Task Ba5ru",
                ),
                onChanged: (value) {
                  context.read<Tasklist>().changeTaskName(value);
                  setState(() {
                    _task = value;
                  });
                  if (_formKey.currentState!.validate()) {
                    isBener = true;
                  }
                  ;
                },
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed:
                          _task.isEmpty || !_formKey.currentState!.validate()
                              ? null
                              : submit,
                      child: const Text("Tambah Task Baru"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
