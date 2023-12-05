import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_partiel_5al/api/post/post_api.dart';
import 'package:flutter_partiel_5al/model/post.dart';
import 'package:meta/meta.dart';

import '../../api/http_error.dart';
import '../state_status.dart';

part 'post_detail_event.dart';
part 'post_detail_state.dart';

class PostDetailBloc extends Bloc<PostDetailEvent, PostDetailState> {
  PostDetailBloc() : super(PostDetailState(status: StateStatus.initial())) {
    on<Init>(_onInit);
    on<Get>(_onGet);
  }

  void _onInit(Init event, Emitter<PostDetailState> emit) async {
    emit(PostDetailState(
      status: StateStatus.initial(),
    ));
  }

  void _onGet(Get event, Emitter<PostDetailState> emit) async {
    emit(PostDetailState(
      status: StateStatus.loading(),
    ));

    try {
      Post post = await PostApi.getById(event.postId);

      emit(PostDetailState(
        status: StateStatus.success(),
        post: post,
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
