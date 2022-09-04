import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_github_issue_list/data/models/issue.dart';
import 'package:flutter_github_issue_list/main.dart';
import 'package:flutter_github_issue_list/presentation/cubit/issues_cubit.dart';
import 'package:flutter_github_issue_list/presentation/pages/issue_detail_screen.dart';
import 'package:flutter_github_issue_list/presentation/widgets/FilterDropdownWidget.dart';
import 'package:flutter_github_issue_list/presentation/widgets/SortDropdownWidget.dart';

class IssuesScreen extends StatelessWidget {
  final scrollController = ScrollController();


  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<IssuesCubit>(context).getIssues();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    BlocProvider.of<IssuesCubit>(context).getIssues();

    return Scaffold(
      appBar: AppBar(
        title: Text("Issues List"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Choose theme:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => MyApp.of(context).changeTheme(ThemeMode.light),
                child: Text('Light'),
              ),
              ElevatedButton(
                onPressed: () => MyApp.of(context).changeTheme(ThemeMode.dark),
                child: Text('Dark'),
              )
            ],
          ),
         
                   Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Filter state: ',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        FilterDropdownWidget(),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Sort option: ',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SortDropdownWidget(),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          
         _issueList(),

        ],
      ),
    );
  }

  Widget _issueList() {
    return BlocBuilder<IssuesCubit, IssuesState>(builder: (context, state) {
      if (state is IssuesLoading && state.isFirstFetch) {
        return _loadingIndicator();
      }

      List<Issue> issues = [];
      bool isLoading = false;

      if (state is IssuesLoading) {
        issues = state.oldIssuesList;
        isLoading = true;
      } else if (state is IssuesLoaded) {
        issues = state.issuesList;
      }

      return Expanded(
        child: ListView.builder(
          controller: scrollController,
          itemBuilder: (context, index) {
            if (index < issues.length)
              return _issue(issues[index], context);
            else {
              Timer(Duration(milliseconds: 30), () {
                scrollController
                    .jumpTo(scrollController.position.maxScrollExtent);
              });
              return _loadingIndicator();
            }
          },
          itemCount: issues.length + (isLoading ? 1 : 0),
        ),
      );
    });
  }

  Widget _loadingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _issue(Issue issue, BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          "${issue.title}",
          style: TextStyle(
              fontSize: 15.0, color: issue.visited ? Colors.grey : Colors.blueGrey, fontWeight: FontWeight.bold),
        ),
        onTap: () {
          BlocProvider.of<IssuesCubit>(context).setVisited(issue);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => IssueDetailScreen(
                    issue: issue,
                  )));
        },
      ),
    );
  }
}
