class Year{
  final int? id;
  final int? year;
  Year({this.id,this.year});
  Map<String, dynamic> toMap() {
    return {'id': id! > 0 ? id : 0, 'year': year};
  }

  factory Year.fromMap(Map<String, dynamic> map) {
    return Year(
        id: map['id'], year: map['year']);
  }
}