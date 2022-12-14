import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_github_issue_list/data/models/issue.dart';

class IssueDetailScreen extends StatelessWidget {
  const IssueDetailScreen({Key? key, required this.issue}) : super(key: key);
  final Issue issue;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Issue Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                issue.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  textAlign: TextAlign.center,
              ),
            ),
            const Divider(
              height: 30,
              thickness: 2,
              color: Colors.white,
            ),
            Text(
              'Author: ${issue.user.login}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),

            ),
            const Divider(
              height: 30,
              thickness: 2,
              color: Colors.white,
            ),
            Text(
              'Created at: ${issue.createdAt}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const Divider(
              height: 30,
              thickness: 2,
              color: Colors.white,
            ),
            Text(
              'State: ${issue.state}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            const Divider(
              height: 30,
              thickness: 2,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                issue.body,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ],
        )
      ),
    );
  }
}
