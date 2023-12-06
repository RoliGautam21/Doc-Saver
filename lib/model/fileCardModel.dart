class FileCardModel {
  String title;
  String note;
  String date;
  String fileName;
  String fileUrl;
  String fileType;
  FileCardModel(
      {required this.title,
      required this.note,
      required this.date,
      required this.fileName,
      required this.fileType,
      required this.fileUrl});

  factory FileCardModel.fromJson(Map<dynamic, dynamic> json) {
    return FileCardModel(
      title: json['title'] ?? '',
      date: json['date'] ?? '',
      note: json['note'] ?? '',
      fileName: json['fileName'] ?? '',
      fileType: json['fileType'] ?? '',
      fileUrl: json['fileUrl'] ?? '',
    );
  }
}
