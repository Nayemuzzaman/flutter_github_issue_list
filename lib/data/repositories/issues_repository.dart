import 'package:dartz/dartz.dart';
import 'package:flutter_github_issue_list/core/util/enums.dart';
import 'package:flutter_github_issue_list/data/models/issue.dart';

import '../../../../core/error/failures.dart';

abstract class IssuesRepository {
  Future<Either<Failure, List<Issue>>> getIssues(int page, FilterState filterState, SortOption sortOption);
}
