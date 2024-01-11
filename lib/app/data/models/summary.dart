class Summary {
  int? totalSafeWebsite;
  int? totalDangerousWebsite;
  int? persentageSafeWebsite;
  int? persentageDangerousWebsite;

  Summary({
    this.totalSafeWebsite = 0,
    this.totalDangerousWebsite = 0,
    this.persentageSafeWebsite = 0,
    this.persentageDangerousWebsite = 0,
  });

  Summary.fromJson(Map<String, dynamic> json) {
    totalSafeWebsite = (json['totalSafeWebsites'] as num).round();
    totalDangerousWebsite = (json['totalDangerousWebsites'] as num).round();
    persentageSafeWebsite = (json['persentageSafeWebsite'] as num).round();
    persentageDangerousWebsite =
        (json['persentageDangerousWebsite'] as num).round();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalSafeWebsite'] = totalSafeWebsite;
    data['totalDangerousWebsite'] = totalDangerousWebsite;
    data['persentageSafeWebsite'] = persentageSafeWebsite;
    data['persentageDangerousWebsite'] = persentageDangerousWebsite;
    return data;
  }
}
