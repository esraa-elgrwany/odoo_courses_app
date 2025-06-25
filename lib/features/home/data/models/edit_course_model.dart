class EditCourseModel {
  EditCourseModel({
      this.jsonrpc, 
      this.id, 
      this.result,});

  EditCourseModel.fromJson(dynamic json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    result = json['result'];
  }
  String? jsonrpc;
  dynamic id;
  bool? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['jsonrpc'] = jsonrpc;
    map['id'] = id;
    map['result'] = result;
    return map;
  }

}