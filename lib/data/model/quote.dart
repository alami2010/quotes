class Quote {
  String? author;
  String? quotes;
  String? url;
  String? type;

  Quote({this.author, this.quotes, this.url, this.type});

  Quote.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    quotes = json['quotes'];
    url = json['url'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author'] = this.author;
    data['quotes'] = this.quotes;
    data['url'] = this.url;
    data['type'] = this.type;
    return data;
  }

  fromJson(i) {}

  @override
  String toString() {
    return 'Quote{author: $author, quotes: $quotes, url: $url, type: $type}';
  }
}