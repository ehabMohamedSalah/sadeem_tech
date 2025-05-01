/// rating : 3
/// comment : "Would not recommend!"
/// date : "2025-04-30T09:41:02.053Z"
/// reviewerName : "Eleanor Collins"
/// reviewerEmail : "eleanor.collins@x.dummyjson.com"

class Reviews {
  Reviews({
      this.rating, 
      this.comment, 
      this.date, 
      this.reviewerName, 
      this.reviewerEmail,});

  Reviews.fromJson(dynamic json) {
    rating = json['rating'];
    comment = json['comment'];
    date = json['date'];
    reviewerName = json['reviewerName'];
    reviewerEmail = json['reviewerEmail'];
  }
  int? rating;
  String? comment;
  String? date;
  String? reviewerName;
  String? reviewerEmail;
Reviews copyWith({  int? rating,
  String? comment,
  String? date,
  String? reviewerName,
  String? reviewerEmail,
}) => Reviews(  rating: rating ?? this.rating,
  comment: comment ?? this.comment,
  date: date ?? this.date,
  reviewerName: reviewerName ?? this.reviewerName,
  reviewerEmail: reviewerEmail ?? this.reviewerEmail,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rating'] = rating;
    map['comment'] = comment;
    map['date'] = date;
    map['reviewerName'] = reviewerName;
    map['reviewerEmail'] = reviewerEmail;
    return map;
  }

}