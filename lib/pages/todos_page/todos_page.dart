import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit/cubits/active_todo_counts/active_todo_count_cubit.dart';
import 'package:todo_cubit/pages/todos_page/create_todo.dart';
import 'package:todo_cubit/pages/todos_page/search_filter_todos.dart';
import 'package:todo_cubit/pages/todos_page/show_todos.dart';
import 'package:todo_cubit/pages/todos_page/todos_header.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              children: const [
                TodoHeader(),
                CreateTodo(),
                SizedBox(
                  height: 20,
                ),
                SearchAndFilterTodo(),
                ShowTodos()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
