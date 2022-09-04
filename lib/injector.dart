import 'package:flutter_github_issue_list/core/network/network_info.dart';
import 'package:flutter_github_issue_list/data/datasources/issues_remote_data_source.dart';
import 'package:flutter_github_issue_list/data/repositories/issues_repository.dart';
import 'package:flutter_github_issue_list/data/repositories/issues_repository_impl.dart';
import 'package:flutter_github_issue_list/presentation/cubit/issues_cubit.dart';
import 'package:flutter_github_issue_list/presentation/get_issues.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';


final injector = GetIt.instance;

Future<void> init() async {
  // Bloc
  injector.registerFactory(
        () => IssuesCubit(
      getIssuesUseCase: injector()
    ),
  );

  // Use cases
  injector.registerLazySingleton(() => GetIssues(injector()));

  // Repository
  injector.registerLazySingleton<IssuesRepository>(
    () => IssuesRepositoryImpl(
      remoteDataSource: injector(),
      networkInfo: injector(),
    ),
  );

  // Data sources
  injector.registerLazySingleton<IssuesRemoteDataSource>(
    () => IssuesRemoteDataSourceImpl(client: injector()),
  );

  //! Core
  injector
      .registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(injector()));

  //! External
  injector.registerLazySingleton(() => http.Client());
  injector.registerLazySingleton(() => InternetConnectionChecker());
}
