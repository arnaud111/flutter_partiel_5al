import 'package:flutter_partiel_5al/model/post.dart';

class PostList {
  int? itemsReceived;
  int? curPage;
  int? nextPage;
  int? prevPage;
  int? offSet;
  int? itemsTotal;
  int? pageTotal;
  List<Post>? items;

  PostList({
    this.itemsReceived,
    this.curPage,
    this.nextPage,
    this.prevPage,
    this.offSet,
    this.itemsTotal,
    this.pageTotal,
    this.items,
  });

  static PostList fromJson(Map<String, dynamic> json) {
    return PostList(
      itemsReceived: json['itemsReceived'],
      curPage: json['curPage'],
      nextPage: json['nextPage'],
      prevPage: json['prevPage'],
      offSet: json['offSet'],
      itemsTotal: json['itemsTotal'],
      pageTotal: json['pageTotal'],
      items: (json['items'] as List<dynamic>).map((comment) => Post.fromJson(comment)).toList(),
    );
  }
}