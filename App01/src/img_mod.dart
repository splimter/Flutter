class ImgMod {
  int id;
  String url;
  String title;

  ImgMod(this.id, this.url, this.title);

  ImgMod.fromJson(Map<String, dynamic> parsedJson){
    id = parsedJson['id'];
    url = parsedJson['url'];
    title = parsedJson['title'];
  }
}