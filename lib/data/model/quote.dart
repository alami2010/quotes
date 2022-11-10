
import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Quote  extends HiveObject  {

  @HiveField(4)
  String? author;

  @HiveField(1)
  String? quotes;

  @HiveField(2)
  String? url;

  @HiveField(3)
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


class QuoteAdapter extends TypeAdapter<Quote> {
  @override
  final typeId = 1;

  @override
  Quote read(BinaryReader reader) {
    dynamic read = reader.read();
    print("read ");
    print(read);
    return Quote.fromJson(read);
  }

  @override
  void write(BinaryWriter writer, Quote obj) {

    print("write ");
    print(obj);
    writer.write(obj.quotes);
  }
}