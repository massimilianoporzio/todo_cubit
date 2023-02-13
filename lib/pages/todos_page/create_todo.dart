import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit/cubits/todo_list/todo_list_cubit.dart';

import '../../cubits/todo_filter/todo_filter_cubit.dart';
import '../../models/todo_model.dart';

class CreateTodo extends StatefulWidget {
  const CreateTodo({super.key});

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  final TextEditingController newTodoController = TextEditingController();

  @override
  void dispose() {
    newTodoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: newTodoController,
      decoration: const InputDecoration(labelText: 'What to do?'),
      onSubmitted: (String? todoDesc) {
        if (todoDesc != null && todoDesc.trim().isNotEmpty) {
          context.read<TodoListCubit>().addTodo(todoDesc);
          context.read<TodoFilterCubit>().changeFilter(Filter.all);
          newTodoController.clear(); //pulisco dopo aver fatto submit
        }
      },
    );
  }
}
