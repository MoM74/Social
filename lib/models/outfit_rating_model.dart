class RateModel {
  String? name;
  String? uId;
  String? postId;
  double? rate;

  RateModel({
    this.name,
    this.uId,
    this.postId,
    this.rate,
  });

  RateModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    postId = json['postId'];
    rate = json['rate'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'postId': postId,
      'rate': rate,
    };
  }
}
