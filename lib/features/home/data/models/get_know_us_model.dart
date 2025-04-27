class GetKnowUsModel {
  GetKnowUsModel({
      this.jsonrpc, 
      this.id, 
      this.result,});

  GetKnowUsModel.fromJson(dynamic json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(KnowUsResult.fromJson(v));
      });
    }
  }
  String? jsonrpc;
  dynamic id;
  List<KnowUsResult>? result;

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

class KnowUsResult {
  KnowUsResult({
      this.id, 
      this.name,});

  KnowUsResult.fromJson(dynamic json) {
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