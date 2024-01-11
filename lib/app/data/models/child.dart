class Child {
  String? id;
  String? idParent;
  String? name;
  String? createdAt;
  String? updatedAt;

  Child({this.id, this.idParent, this.name, this.createdAt, this.updatedAt});

  Child.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idParent = json['parentsId'];
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parentsId'] = this.idParent;
    data['name'] = this.name;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }

  static List<Child> fromJsonList(List list) {
    if (list.isEmpty) return List<Child>.empty();
    return list.map((item) => Child.fromJson(item)).toList();
  }
}
