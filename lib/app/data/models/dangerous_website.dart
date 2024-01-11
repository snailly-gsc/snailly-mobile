class DangerousWebsite {
  final String url;
  final String title;
  final String label;
  final bool? grantAccess;

  const DangerousWebsite({
    required this.url,
    required this.title,
    required this.label,
    this.grantAccess,
  });

  // factory DangerousWebsite.fromJson(Map<String, dynamic> data) =>
  //     DangerousWebsite(
  //       url: (data['url'] as String).contains('//')
  //           ? (data['url'] as String).split('//')[1]
  //           : data['url'],
  //       title: data['title'] ?? data['url'],
  //       label: data['FINAL_label'],
  //       grantAccess: data['grant_access'],
  //     );

  factory DangerousWebsite.fromJson(String data) => DangerousWebsite(
        url: (data).contains('//') ? (data).split('//')[1] : data,
        title: data,
        label: 'berbahaya',
        grantAccess: false,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['title'] = title;
    data['FINAL_label'] = label;
    data['grant_access'] = grantAccess;
    return data;
  }

  static List<DangerousWebsite> fromJsonList(List list) {
    if (list.isEmpty) return List<DangerousWebsite>.empty();
    return list.map((item) => DangerousWebsite.fromJson(item)).toList();
  }
}
