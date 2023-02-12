import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_cubit/cubits/cubits.dart';
import 'package:todo_cubit/cubits/todo_search/todo_search_cubit.dart';

import '../../models/todo_model.dart';

class SearchAndFilterTodo extends StatelessWidget {
  const SearchAndFilterTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
              labelText: 'Search todos...',
              border: InputBorder.none,
              filled: true,
              prefixIcon: Icon(Icons.search)),
          onChanged: (String? newSearchTerm) {
            if (newSearchTerm != null) {
              //*ogni volta che scrivo triggero l'evento
              context.read<TodoSearchCubit>().setSearchTerm(newSearchTerm);
            }
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            filterButton(context, Filter.all),
            filterButton(context, Filter.active),
            filterButton(context, Filter.completed),
          ],
        )
      ],
    );
  }

  Widget filterButton(BuildContext context, Filter filter) {
    return TextButton(
        onPressed: () {
          context.read<TodoFilterCubit>().changeFilter(filter);
        },
        child: Text(
          toBeginningOfSentenceCase(filter.name)!,
          style: TextStyle(fontSize: 18, color: textColor(context, filter)),
        ));
  }

  Color textColor(BuildContext context, Filter filter) {
    Filter currentFilterState = context.watch<TodoFilterCubit>().state.filter;
    return filter == currentFilterState ? Colors.blue : Colors.grey;
  }
}
