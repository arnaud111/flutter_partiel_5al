part of 'post_list_bloc.dart';

@immutable
abstract class PostListEvent {}

class Init extends PostListEvent {}

class GetListPost extends PostListEvent {}

class AddListPost extends PostListEvent {}
