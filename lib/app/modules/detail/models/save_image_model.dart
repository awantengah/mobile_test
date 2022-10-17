class SaveImageModel {
  String? filePath;
  dynamic errorMessage;
  bool? isSuccess;

  SaveImageModel({this.filePath, this.errorMessage, this.isSuccess});

  SaveImageModel.fromJson(Map<String, dynamic> json) {
    filePath = json['filePath'];
    errorMessage = json['errorMessage'];
    isSuccess = json['isSuccess'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['filePath'] = filePath;
    data['errorMessage'] = errorMessage;
    data['isSuccess'] = isSuccess;
    return data;
  }
}
