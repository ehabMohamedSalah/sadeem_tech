class Meta {
  Meta({
    this.createdAt,
    this.updatedAt,
    this.barcode,
    this.qrCode,
    this.count,
  });

  String? createdAt;
  String? updatedAt;
  String? barcode;
  String? qrCode;
  int? count;

  Meta copyWith({
    String? createdAt,
    String? updatedAt,
    String? barcode,
    String? qrCode,
    int? count,
  }) =>
      Meta(
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        barcode: barcode ?? this.barcode,
        qrCode: qrCode ?? this.qrCode,
        count: count ?? this.count,
      );

  Meta.fromJson(dynamic json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    barcode = json['barcode'];
    qrCode = json['qrCode'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['barcode'] = barcode;
    map['qrCode'] = qrCode;
    map['count'] = count;
    return map;
  }
}
