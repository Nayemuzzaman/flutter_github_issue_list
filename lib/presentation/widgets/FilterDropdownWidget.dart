import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_issue_list/core/util/enums.dart';
import 'package:flutter_github_issue_list/presentation/cubit/issues_cubit.dart';

class FilterDropdownWidget extends StatefulWidget {
  const FilterDropdownWidget({Key? key}) : super(key: key);

  @override
  State<FilterDropdownWidget> createState() => _FilterDropdownWidgetState();
}

class _FilterDropdownWidgetState extends State<FilterDropdownWidget> {
  FilterState dropdownValue = FilterState.open;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<FilterState>(
      value: dropdownValue,
      dropdownColor: Colors.black54,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.blue, fontSize: 16),
      underline: Container(
        height: 1,
        color: Colors.white,
      ),
      onChanged: (FilterState? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
        BlocProvider.of<IssuesCubit>(context).updateFilter(newValue!);
      },
      items: FilterState.values.map((FilterState value) {
        return DropdownMenuItem<FilterState>(
          value: value,
          child: Text(value.toShortString()),
        );
      }).toList(),
    );
  }
}
