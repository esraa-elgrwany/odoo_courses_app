class GetCoursesModel {
  GetCoursesModel({
    this.jsonrpc,
    this.id,
    this.result,
  });

  GetCoursesModel.fromJson(Map<String, dynamic> json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(CoursesResult.fromJson(v));
      });
    }
  }

  String? jsonrpc;
  dynamic id;
  List<CoursesResult>? result;

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

class CoursesResult {
  CoursesResult({
    this.id,
    this.seq,
    this.name,
    this.stateId,
    this.city,
    this.gender,
    this.status,
    this.phone,
    this.bookingResponsable,
    this.howKnowUs,
    this.batchNum,
    this.age,
    this.note,
    this.workStatus,
    this.date,
    this.payMethod,
    this.gradImage,});

  CoursesResult.fromJson(dynamic json) {
    id = json['id'];
    seq = json['seq'];
    name = json['name'];
    stateId = json['state_id'] != null ? json['state_id'].cast<dynamic>() : [];
    city = json['city'];
    gender = json['gender'];
    status = json['status'] != null ? json['status'].cast<dynamic>() : [];
    phone = json['phone'];
    bookingResponsable = json['booking_responsable'] != null? json['booking_responsable'].cast<dynamic>() : [];
    howKnowUs = json['how_know_us'] != null ? json['how_know_us'].cast<dynamic>() : [];
    batchNum = json['batch_num'];
    age = json['age'];
    note= json['note'] != null && json['note'] != false
        ? json['note'].toString()
        : null;
    workStatus= json['work_status'] != null && json['work_status'] != false
        ? json['work_status'].toString()
        : null;
    date = json['create_date'] is String ? json['create_date'] : null;
    payMethod= json['pay_method'] != null && json['pay_method'] != false
        ? json['pay_method'].toString()
        : null;
    gradImage= json['grad_image'] != null && json['grad_image'] != false
        ? json['grad_image'].toString()
        : null;
  }
  int? id;
  String? seq;
  String? name;
  List<dynamic>? stateId;
  String? city;
  String? gender;
  List<dynamic>? status;
  String? phone;
  List<dynamic>? bookingResponsable;
  List<dynamic>? howKnowUs;
  int? batchNum;
  int? age;
  dynamic? note;
  dynamic? workStatus;
  String? date;
  dynamic? payMethod;
  dynamic? gradImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['seq'] = seq;
    map['name'] = name;
    map['state_id'] = stateId;
    map['city'] = city;
    map['gender'] = gender;
    map['status'] = status;
    map['phone'] = phone;
    map['booking_responsable'] = bookingResponsable;
    map['how_know_us'] = howKnowUs;
    map['batch_num'] = batchNum;
    map['age'] = age;
    map['note'] = note;
    map['work_status'] = workStatus;
    map['create_date']=date;
    map['pay_method'] = payMethod;
    map['grad_image'] = gradImage;
    return map;
  }

}


