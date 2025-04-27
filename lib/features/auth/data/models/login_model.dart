class LoginModel {
  LoginModel({
    this.jsonrpc,
    this.id,
    this.result,});

  LoginModel.fromJson(dynamic json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  String? jsonrpc;
  dynamic id;
  Result? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['jsonrpc'] = jsonrpc;
    map['id'] = id;
    if (result != null) {
      map['result'] = result?.toJson();
    }
    return map;
  }

}

class Result {
  Result({
    this.uid,
    this.db,
    this.supportUrl,
    this.name,
    this.username,
    this.partnerDisplayName,
    this.companyId,
    this.partnerId,
    this.webbaseurl,
    this.activeIdsLimit,
    this.maxFileUploadSize,
    this.userId,
    });

  Result.fromJson(dynamic json) {
    uid = json['uid'];
    db = json['db'];
    supportUrl = json['support_url'];
    name = json['name'];
    username = json['username'];
    partnerDisplayName = json['partner_display_name'];
    companyId = json['company_id'];
    partnerId = json['partner_id'];
    webbaseurl = json['web.base.url'];
    activeIdsLimit = json['active_ids_limit'];
    maxFileUploadSize = json['max_file_upload_size'];
    userId = json['user_id'] != null ? json['user_id'].cast<int>() : [];
  }

  int? uid;
  String? db;
  String? supportUrl;
  String? name;
  String? username;
  String? partnerDisplayName;
  int? companyId;
  int? partnerId;
  String? webbaseurl;
  int? activeIdsLimit;
  int? maxFileUploadSize;
  List<int>? userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uid'] = uid;
    map['db'] = db;
    map['support_url'] = supportUrl;
    map['name'] = name;
    map['username'] = username;
    map['partner_display_name'] = partnerDisplayName;
    map['company_id'] = companyId;
    map['partner_id'] = partnerId;
    map['web.base.url'] = webbaseurl;
    map['active_ids_limit'] = activeIdsLimit;
    map['max_file_upload_size'] = maxFileUploadSize;
    map['user_id'] = userId;
    return map;
  }
}
