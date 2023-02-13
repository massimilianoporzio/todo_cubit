import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_cubit/cubits/filtered_todos/filtered_todos_cubit.dart';
import 'package:todo_cubit/cubits/todo_list/todo_list_cubit.dart';

import '../../models/todo_model.dart';

class ShowTodos extends StatelessWidget {
  const ShowTodos({super.key});

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilteredTodosCubit>().state.filteredTodos;
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      separatorBuilder: (context, index) => const Divider(
        color: Colors.grey,
      ),
      itemCount: todos.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(todos[index].id),
        background: showBackground(0), //swipe  a dx
        secondaryBackground: showBackground(1), //swipe a sin
        onDismissed: (direction) {
          context.read<TodoListCubit>().removeTodo(todos[index].id);
        },
        confirmDismiss: (direction) {
          return showDialog(
            barrierDismissible: false, //NON si chiude se clicco fuori
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Are you sure?'),
                content: const Text("Do you really want to delete this item?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false); //false: NO
                    },
                    child: const Text('NO'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, true); //false: NO
                    },
                    child: const Text('YES'),
                  ),
                ],
              );
            },
          );
        },
        child: TodoItem(
          todo: todos[index],
        ),
      ),
    );
  }

//*mostra il background quando swipe per cancellare il todo
  Widget showBackground(int direction) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: Colors.red,
      alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: const Icon(
        Icons.delete,
        size: 20,
        color: Colors.white,
      ),
    );
  }
}

class TodoItem extends StatefulWidget {
  final Todo todo;

  const TodoItem({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: widget.todo.completed,
        onChanged: (bool? checked) {
          //CAMBIA LO STATO DI QUEL TODO
          context.read<TodoListCubit>().toggleTodo(widget.todo.id);
        },
      ),
      title: Text(
        widget.todo.desc,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
