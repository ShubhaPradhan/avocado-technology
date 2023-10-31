class NewsResponse {
  List<News>? news;

  NewsResponse({this.news});

  NewsResponse.fromJson(List<dynamic> json) {
    if (json.isNotEmpty) {
      news = json.map((e) => News.fromJson(e)).toList();
    }
  }
}

class News {
  int? userId;
  int? id;
  String? title;
  String? body;

  News({this.userId, this.id, this.title, this.body});

  News.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }
}
