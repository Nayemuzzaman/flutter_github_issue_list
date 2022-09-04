import 'package:dartz/dartz.dart';
import 'package:flutter_github_issue_list/core/util/enums.dart';
import 'package:flutter_github_issue_list/data/datasources/issues_remote_data_source.dart';
import 'package:flutter_github_issue_list/data/models/issue.dart';
import 'package:flutter_github_issue_list/data/repositories/issues_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';

class IssuesRepositoryImpl implements IssuesRepository {
  final IssuesRemoteDataSource remoteDataSource;
  // final IssuesLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  IssuesRepositoryImpl({
    required this.remoteDataSource,
    // @required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Issue>>> getIssues(int page, FilterState filterState, SortOption sortOption) async {
    return await _getIssues(page, filterState, sortOption);
  }

  Future<Either<Failure, List<Issue>>> _getIssues(int page, FilterState filterState, SortOption sortOption) async {
    if (await networkInfo.isInternetAvailable) {
      try {
        final remoteIssues = await remoteDataSource.getIssues(page, filterState, sortOption);
        // localDataSource.cacheIssues(remoteIssues);
        return Right(remoteIssues);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        // final localIssues = await localDataSource.getIssues();
        // return Right(localIssues);
        return Left(CacheFailure());
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
