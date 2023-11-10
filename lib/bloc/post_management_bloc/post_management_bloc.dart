import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_partiel_5al/api/post/post_api.dart';
import 'package:flutter_partiel_5al/bloc/state_status.dart';
import 'package:meta/meta.dart';

import '../../api/http_error.dart';

part 'post_management_event.dart';

part 'post_management_state.dart';

class PostManagementBloc extends Bloc<PostManagementEvent, PostManagementState> {
  PostManagementBloc() : super(PostManagementState(status: StateStatus.initial())) {
    on<CreatePostEvent>(_onCreatePost);
    on<Init>(_onInit);
  }

  void _onInit(Init event, Emitter<PostManagementState> emit) async {
    emit(PostManagementState(
      status: StateStatus.initial(),
    ));
  }

  void _onCreatePost(CreatePostEvent event, Emitter<PostManagementState> emit) async {
    emit(PostManagementState(
        status: StateStatus.loading(),
    ));

    try {
      print(event.textMessage);
      print(event.base64Image);
      print("before");
      await PostApi.post(event.textMessage, event.base64Image);
      print("after");

      emit(PostManagementState(
        status: StateStatus.success(),
      ));
    } on HttpError catch (e) {
      emit(PostManagementState(
        status: StateStatus.error(
          message: e.message,
          payload: e.payload,
        ),
      ));
    } catch (e) {
      emit(PostManagementState(
        status: StateStatus.error(
          message: "Error, please retry later !",
        ),
      ));
    }
  }
}
