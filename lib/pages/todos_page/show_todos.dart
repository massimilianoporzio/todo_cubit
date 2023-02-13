import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit/cubits/filtered_todos/filtered_todos_cubit.dart';

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
      itemBuilder: (context, index) => Text(
        todos[index].desc,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
