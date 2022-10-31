import 'package:bloc_pattern/blocs/todos/todos_bloc.dart';
import 'package:bloc_pattern/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTodoScreen extends StatelessWidget {
  const AddTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController idController = TextEditingController();
    TextEditingController taskController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Add a Todo')),
      body: BlocListener<TodosBloc, TodosState>(
        listener: (context, state) {
          if (state is TodosLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                elevation: 0.0,
                dismissDirection: DismissDirection.vertical,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                content: const Text('New Todo added!'),
              ),
            );

            Navigator.pop(context);
          }
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                _inputField('ID', idController),
                _inputField('Task', taskController),
                _inputField('Description', descriptionController),
                const SizedBox(
                  height: 60.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      var todo = Todo(
                        id: idController.value.text.trim(),
                        task: taskController.value.text.trim(),
                        description: descriptionController.value.text.trim(),
                      );

                      context.read<TodosBloc>().add(AddTodo(todo: todo));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      elevation: 0.0,
                      padding: const EdgeInsets.all(16.0),
                    ),
                    child: const Text('Add Todo'),
                  ),
                ),
              ],
            ),
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
