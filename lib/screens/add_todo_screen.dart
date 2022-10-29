import 'package:bloc_pattern/models/todo_model.dart';
import 'package:flutter/material.dart';

class AddTodoScreen extends StatelessWidget {
  const AddTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController idController = TextEditingController();
    TextEditingController taskController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Add a Todo')),
      body: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              _inputField('ID', idController),
              _inputField('Task', taskController),
              _inputField('Description', descriptionController),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () {
                  var todo = Todo(
                    id: idController.value.text.trim(),
                    task: taskController.value.text.trim(),
                    description: descriptionController.value.text.trim(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: const Text('Add Todo'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _inputField(String title, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        labelText: title,
        contentPadding: const EdgeInsets.all(20.0),
      ),
    );
  }
}
