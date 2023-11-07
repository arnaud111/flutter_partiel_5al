class Image {

  String? path;
  String? name;
  String? type;
  int? size;
  String? mime;
  Map<String, dynamic>? meta;
  String? url;

  Image({
    this.path,
    this.name,
    this.type,
    this.size,
    this.mime,
    this.meta,
    this.url,
  });

  static Image fromJson(Map<String, dynamic> json) {
    return Image(
      path: json['path'],
      name: json['name'],
      type: json['type'],
      size: json['size'],
      mime: json['mime'],
      meta: json['meta'],
      url: json['url'],
    );
  }
}