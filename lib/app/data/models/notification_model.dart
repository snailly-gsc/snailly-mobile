class NotificationModel {
  String? id;
  String? parentChild;
  String? childId;
  String? logId;
  String? title;
  String? text;
  DateTime? createdAt;

  NotificationModel({
    this.id,
    this.parentChild,
    this.childId,
    this.logId,
    this.title,
    this.text,
    this.createdAt,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentChild = json['parentChild'];
    childId = json['childId'];
    logId = json['logId'];
    title = json['title'];
    text = json['text'];
    createdAt = json['createdAt'] != null
        ? DateTime.parse(json['createdAt']).toLocal()
        : DateTime.now().toLocal();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['parentChild'] = parentChild;
    data['childId'] = childId;
    data['logId'] = logId;
    data['title'] = title;
    data['text'] = text;
    data['createdAt'] = createdAt;
    return data;
  }

  static List<NotificationModel> fromJsonList(List list) {
    if (list.isEmpty) return List<NotificationModel>.empty();
    return list.map((item) => NotificationModel.fromJson(item)).toList();
  }
}
