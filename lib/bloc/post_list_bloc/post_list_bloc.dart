import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_partiel_5al/api/post/post_api.dart';
import 'package:flutter_partiel_5al/model/post_list.dart';
import 'package:meta/meta.dart';

import '../../api/http_error.dart';
import '../state_status.dart';

part 'post_list_event.dart';

part 'post_list_state.dart';

class PostListBloc extends Bloc<PostListEvent, PostListState> {
  PostListBloc() : super(PostListState(status: StateStatus.initial())) {
    on<Init>(_onInit);
    on<GetListPost>(_onGetListPost);
  }

  void _onInit(Init event, Emitter<PostListState> emit) async {
    emit(PostListState(
      status: StateStatus.initial(),
    ));
  }

  void _onGetListPost(GetListPost event, Emitter<PostListState> emit) async {
    emit(PostListState(
      status: StateStatus.loading(),
    ));

    try {
      PostList postList = await PostApi.get(null, null);

      emit(PostListState(
        status: StateStatus.success(),
        postList: postList,
      ));
    } on HttpError catch (e) {
      emit(state.copyWith(
        status: StateStatus.error(
          message: e.message,
        ),
      ));
    } catch (e) {
      emit(state.copyWith(
        status: StateStatus.error(
          message: "Error, please retry later !",
        ),
      ));
    }
  }
}
