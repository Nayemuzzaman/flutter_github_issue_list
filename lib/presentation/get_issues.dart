import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_github_issue_list/core/util/enums.dart';
import 'package:flutter_github_issue_list/data/models/issue.dart';
import 'package:flutter_github_issue_list/data/repositories/issues_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class GetIssues implements UseCase<List<Issue>, Params> {
  final IssuesRepository repository;

  GetIssues(this.repository);

  @override
  Future<Either<Failure, List<Issue>>> call(Params params) async {
    return await repository.getIssues(
        params.page, params.filterState, params.sortOption);
  }
}

class Params extends Equatable {
  final int page;
  final FilterState filterState;
  final SortOption sortOption;

  Params(
    this.page,
    this.filterState,
    this.sortOption,
  );

  @override
  List<Object> get props => [page, filterState, sortOption];
}
