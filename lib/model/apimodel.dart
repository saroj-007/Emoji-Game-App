class SmileyModel {
  String? question;
  int? solution;

  SmileyModel({this.question, this.solution});

  SmileyModel.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    solution = json['solution'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['solution'] = this.solution;
    return data;
  }
}