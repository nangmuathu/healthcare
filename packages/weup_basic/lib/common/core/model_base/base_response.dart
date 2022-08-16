class BaseResponse <T>{
  String? version;
  T? data;
  String? errorMsg;
  int? error;

  BaseResponse({this.version, this.data, this.errorMsg, this.error});

  BaseResponse.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    data = json['data'];
    if (json['error'] != 0 && json['error'] != null) {
      errorMsg = 'Error';
      errorMsg = json['error_msg'];
    }
    if (json['error'] == 0 || json['error'] == null) {
      errorMsg = 'Success';
      errorMsg = json['error_msg'];
    }
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['version'] = version;
    data['data'] = data;
    data['error_msg'] = errorMsg;
    data['error'] = error;
    return data;
  }
}
