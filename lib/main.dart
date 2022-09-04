import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_issue_list/presentation/cubit/issues_cubit.dart';
import 'package:flutter_github_issue_list/presentation/get_issues.dart';
import 'package:flutter_github_issue_list/presentation/pages/issue_screen.dart';
import 'injector.dart' as di;

void main() {
  BlocOverrides.runZoned(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await di.init();
    runApp(MyApp());
  }, blocObserver: IssuesBlocObserver());
}

//GithubApp to MyApp
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) => 
      context.findAncestorStateOfType<_MyAppState>()!;

}

class _MyAppState extends State<MyApp> {
    ThemeMode _themeMode = ThemeMode.system;

  @override
   Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode, 
      home: BlocProvider<IssuesCubit>(
        create: (context) => IssuesCubit(
          getIssuesUseCase: di.injector<GetIssues>(),

        ),
        child: IssuesScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

}

class IssuesBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    // print(change);
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}
