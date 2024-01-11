enum StatusLog { unknown, positive, negative }

class LogActivityModel {
  String? id;
  String? idChild;
  String? webUrl;
  String? webTitle;
  String? finalLabel;
  bool? grantAccess;
  DateTime? createdAt;
  String? updatedAt;
  StatusLog statusLog = StatusLog.unknown;

  LogActivityModel({
    this.id,
    this.idChild,
    this.webUrl,
    this.webTitle,
    this.finalLabel,
    this.createdAt,
    this.updatedAt,
  });

  LogActivityModel.fromJson(Map<String, dynamic> json) {
    id = json['log_id'];
    idChild = json['childId'];
    webUrl = json['url'];
    webTitle = (json['classified_url'] as List).isNotEmpty
        ? json['classified_url'][0]['title'] ?? json['url']
        : json['url'];
    finalLabel = (json['classified_url'] as List).isNotEmpty
        ? json['classified_url'][0]['FINAL_label'] ?? json['url']
        : json['url'];
    grantAccess = json['grant_access'];
    createdAt = json['createdAt'] != null
        ? DateTime.parse(json['createdAt']).toLocal()
        : DateTime.now().toLocal();
    updatedAt = json['updatedAt'];
    statusLog = json['grant_access'] == true
        ? StatusLog.positive
        : (json['classified_url'] as List).isEmpty
            ? StatusLog.unknown
            : json['classified_url'][0]['FINAL_label'] == 'aman'
                ? StatusLog.positive
                : StatusLog.negative;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['log_id'] = id;
    data['childId'] = idChild;
    data['url'] = webUrl;
    data['classified_url']['title'] = webTitle;
    data['classified_url']['FINAL_label'] = finalLabel;
    data['grant_access'] = grantAccess;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  static List<LogActivityModel> fromJsonList(List list) {
    if (list.isEmpty) return List<LogActivityModel>.empty();
    return list.map((item) => LogActivityModel.fromJson(item)).toList();
  }
}
