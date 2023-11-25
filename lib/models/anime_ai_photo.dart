class AnimeAiPhoto {
  String? parameters;
  String? images;

  AnimeAiPhoto({this.images, this.parameters});

  AnimeAiPhoto.fromJson(Map<String, dynamic> json)
      : this.parameters = json['parameters'],
        this.images = json['images'];

}