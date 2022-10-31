import 'package:bloc_pattern/blocs/todos/todos_bloc.dart';
import 'package:bloc_pattern/blocs/todos_filter/todos_filter_bloc.dart';
import 'package:bloc_pattern/models/todo_model.dart';
import 'package:bloc_pattern/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodosBloc()
            ..add(LoadTodos(todos: [
              Todo(id: '1', task: 'task one', description: 'description 1'),
              Todo(id: '2', task: 'task two', description: 'description 2'),
              Todo(id: '3', task: 'task third', description: 'description 3'),
            ])),
        ),
        BlocProvider(
          create: (context) => TodosFilterBloc(
            todosBloc: BlocProvider.of<TodosBloc>(context),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BLoC Pattern - Todos',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: const Color(0xFF000A1F),
          backgroundColor: Colors.grey.shade200,
          appBarTheme: const AppBarTheme(
            color: Color(0xFF000A1F),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
