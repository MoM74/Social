class CommentModel {
  String? name;
  String? commentImage;
  String? image;
  String? commentText;
  String? dateTime;
  String? uId;
  String? postId;

  CommentModel(
      {
      this.image,
      this.dateTime,
      this.name,
      this.commentImage,
      this.commentText,
      this.uId,
      this.postId});

  CommentModel.fromJson(Map<String, dynamic> json) {
    commentImage = json['imageComment'];
    dateTime = json['dateTime'];
    image = json['image'];
    name = json['name'];
    commentText = json['commentText'];
    uId = json['uId'];
    postId = json['postId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dateTime': dateTime,
      'image': image,
      'imageComment': commentImage,
      'commentText': commentText,
      'uId': uId,
      'postId': postId
    };
  }
}
