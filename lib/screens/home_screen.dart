import 'package:bloc_pattern/blocs/todos/todos_bloc.dart';
import 'package:bloc_pattern/blocs/todos_filter/todos_filter_bloc.dart';
import 'package:bloc_pattern/models/todo_model.dart';
import 'package:bloc_pattern/models/todos_filter_model.dart';
import 'package:bloc_pattern/screens/add_todo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TabBar(
              onTap: (idx) {
                switch (idx) {
                  case 0:
                    BlocProvider.of<TodosFilterBloc>(context).add(
                      const UpdateTodos(todosFilter: TodosFilter.pending),
                    );
                    break;
                  case 1:
                    BlocProvider.of<TodosFilterBloc>(context).add(
                      const UpdateTodos(todosFilter: TodosFilter.completed),
                    );
                    break;
                }
              },
              unselectedLabelColor: Colors.grey,
              labelColor: Theme.of(context).primaryColor,
              indicatorColor: Theme.of(context).primaryColor,
              tabs: const [
                Tab(text: 'Pending'),
                Tab(text: 'Completed'),
              ],
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.label,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  _todos('Pending Todos'),
                  _todos('Completed Todos'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BlocConsumer<TodosFilterBloc, TodosFilterState> _todos(String title) {
    return BlocConsumer<TodosFilterBloc, TodosFilterState>(
      listener: (context, state) {
        if (state is TodosFilterLoaded) {}
      },
      builder: (context, state) {
        if (state is TodosFilterLoading) {
          return const CircularProgressIndicator();
        }

        if (state is TodosFilterLoaded) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '$title (${state.filteredTodos.length})',
                        style: const TextStyle(
                          fontSize: 27.0,
                          color: Color(0xFF000A1F),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      color: const Color(0xFF000A1F),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddTodoScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
                const SizedBox(height: 32.0),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.filteredTodos.length,
                  itemBuilder: (BuildContext context, int index) =>
                      _todoCard(context, state.filteredTodos[index], state),
                ),
              ],
            ),
          );
        } else {
          return const Text('Something went wrong!');
        }
      },
    );
  }

  Card _todoCard(BuildContext context, Todo todo, TodosFilterLoaded state) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  '#${todo.id}: ${todo.task}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(todo.description),
              ],
            ),
            Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    context.read<TodosBloc>().add(
                          UpdateTodo(todo: todo.copyWith(isCompleted: true)),
                        );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        elevation: 0.0,
                        dismissDirection: DismissDirection.vertical,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        content: Text(
                          "Hurray! You've completed #${todo.id} Todo",
                        ),
                      ),
                    );
                  },
                  icon: todo.isCompleted!
                      ? const Icon(Icons.task_alt)
                      : const Icon(Icons.add_task),
                ),
                IconButton(
                  onPressed: () {
                    context.read<TodosBloc>().add(DeleteTodo(todo: todo));
                  },
                  icon: const Icon(Icons.cancel),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
