class UserModel {
  String? first;
  String? middle;
  String? last;
  int? born;

  UserModel({this.first, this.middle, this.last, this.born});

  UserModel.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    middle = json['middle'];
    last = json['last'];
    born = json['born'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first'] = this.first;
    data['middle'] = this.middle;
    data['last'] = this.last;
    data['born'] = this.born;
    return data;
  }
}
