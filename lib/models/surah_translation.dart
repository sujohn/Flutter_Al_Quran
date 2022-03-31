
class SurahTranslation {
  String? surah;
  String? aya;
  String? arabic_text;
  String? translation;

  SurahTranslation({this.surah, this.aya, this.arabic_text, this.translation,});

  factory SurahTranslation.fromJSON(Map<String, dynamic> json) {
    return SurahTranslation(
      surah: json['surah'],
      aya: json['aya'],
      arabic_text: json['arabic_text'],
      translation: json['translation'],
    );
  }
}

class SurahTranslationList {
  final List<SurahTranslation> translationList;

  SurahTranslationList({required this.translationList});

  factory SurahTranslationList.fromJSON(Map<String, dynamic> map) {
    Iterable iterable = map['result'];
    List<SurahTranslation> list = iterable.map((e) => SurahTranslation.fromJSON(e)).toList();
    print(list.length);
    return SurahTranslationList(translationList: list);
  }
}