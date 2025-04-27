class GetTasksModel{
  GetTasksModel({
    this.jsonrpc,
    this.id,
    this.result,});

  GetTasksModel.fromJson(dynamic json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(TaskResult.fromJson(v));
      });
    }
  }
  String? jsonrpc;
  dynamic id;
  List<TaskResult>? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['jsonrpc'] = jsonrpc;
    map['id'] = id;
    if (result != null) {
      map['result'] = result?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class TaskResult {
  TaskResult({
    this.id,
    this.name,
    this.projectId,
    this.partnerId,
    this.userIds,
    this.createUid,
    this.description,});

  TaskResult.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    if (json['user_ids'] != null && json['user_ids'] is List) {
      userIds = (json['user_ids'] as List)
          .map((v) => UserIds.fromJson(v))
          .toList();
    } else {
      userIds = [];
    }

    projectId = json['project_id'] is String ? json['project_id'] : null ;
    partnerId = json['partner_id'] is String ? json['partner_id'] : null;
   /* projectId = json['project_id'] is List ? List<dynamic>.from(json['project_id']) : [];
    //partnerId = json['partner_id'] != null && json['partner_id'] != false? json['partner_id'].cast<dynamic>() : [];
    partnerId = json['partner_id'] is List ? List<dynamic>.from(json['partner_id']) : null;
    userIds = json['user_ids'] is List ? List<int>.from(json['user_ids']) : [];*/
    createUid = json['create_uid'] is String ? json['create_uid'] : null;
    description = json['description'] is String ? json['description'] : null;
  }
  int? id;
  String? name;
  List<UserIds>? userIds;
  String? projectId;
  String? partnerId;
  String? createUid;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    if (userIds != null) {
      map['user_ids'] = userIds?.map((v) => v.toJson()).toList();
    }
    map['project_id'] = projectId;
    map['partner_id'] = partnerId;
    map['create_uid'] = createUid;
    map['description'] = description;
    return map;
  }

}
class UserIds {
  UserIds({
    this.id,
    this.name,});

  UserIds.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  int? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }

}