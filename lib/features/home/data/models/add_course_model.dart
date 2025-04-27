class AddCourseModel {
  AddCourseModel({
      this.jsonrpc, 
      this.id, 
      this.result,});

  AddCourseModel.fromJson(dynamic json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    result = json['result'];
  }
  String? jsonrpc;
  dynamic id;
  int? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['jsonrpc'] = jsonrpc;
    map['id'] = id;
    map['result'] = result;
    return map;
  }

}