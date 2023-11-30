class Months{
  final int? id;
  final String? month;
  final int? yearId;
  Months({this.id,this.month,this.yearId});
  Map<String, dynamic> toMap() {
    return {'id': id! > 0 ? id : 0, 'month': month,'yearId':yearId};
  }

  factory Months.fromMap(Map<String, dynamic> map) {
    return Months(
        id: map['id'], month: map['month'],yearId:map['yearId']);
  }
}