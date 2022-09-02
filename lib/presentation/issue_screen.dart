import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_github_issue_list/main.dart';

class IssuesScreen extends StatelessWidget {
  const IssuesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                onPressed: () =>MyApp.of(context).changeTheme(ThemeMode.light), 
                child: Text('Light'),
              ),

              ElevatedButton(
                onPressed: () =>MyApp.of(context).changeTheme(ThemeMode.dark), 
                child: Text('Dark'),
              )
            ],
          )

        ],

      ),
    );
  }
}
