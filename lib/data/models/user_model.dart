
import 'package:flutter_github_issue_list/data/models/user.dart';

class UserModel extends User{
  UserModel(
      {required String login,
        required int id,
        required String nodeId,
        required String avatarUrl})
      : super(login: login, id: id, nodeId: nodeId, avatarUrl: avatarUrl);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      login: json['login'],
      id: json['id'],
      nodeId: json['node_id'],
      avatarUrl: json['avatar_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'id': id,
      'node_id': nodeId,
      'avatar_url': avatarUrl,
    };
  }
}