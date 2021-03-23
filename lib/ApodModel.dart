class ApodModel {
  var copyright;
  var explanation;
  var date;
  var hdurl;
  var title;

  ApodModel(
      {this.copyright, this.explanation, this.date, this.hdurl, this.title});

  factory ApodModel.fromJson(Map<String, dynamic> json) {
    return ApodModel(
        copyright: json['copyright'] as String,
        date: json['date'] as String,
        explanation: json['explanation'] as String,
        hdurl: json['hdurl'] as String,
        title: json['title'] as String);
  }
  Map<String, dynamic> toJson() {
    return {
      'copyright': copyright,
      'date': date,
      'explanation': explanation,
      'hdurl': hdurl,
      'title': title
    };
  }
}
