class Model{
  String? title;
  String? link;

  Model(
      {
        this.title,
      this.link,
      });

  Model.fromJson(Map<String,dynamic> json)
  {
    title = json['title'];
    link =json['link'];
  }
}