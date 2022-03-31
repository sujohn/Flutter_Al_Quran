class Sajda {

  int? juz;
  String? name;
  String? englishName;
  String? revelationType;

  Sajda({this.juz, this.name, this.englishName, this.revelationType});

  factory Sajda.fromJSON(Map<String, dynamic> json) {
    return Sajda(
      juz: json['juz'],
      name: json['surah']['name'],
      englishName: json['surah']['englishName'],
      revelationType: json['surah']['revelationType'],
    );
  }
}