class Quri {

  String? name;
  String? path;
  String? format;

  Quri({this.name, this.path, this.format});

  factory Quri.fromJSON(Map<String, dynamic> json) {
    return Quri(
      name: json['name'],
      path: json['relative_path'],
      format: json['file_formats'],
    );
  }
}