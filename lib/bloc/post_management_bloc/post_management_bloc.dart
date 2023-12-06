import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_partiel_5al/bloc/state_status.dart';
import 'package:flutter_partiel_5al/datasource/repository/post_repository.dart';
import 'package:meta/meta.dart';

import '../../datasource/api/http_error.dart';


part 'post_management_event.dart';

part 'post_management_state.dart';

class PostManagementBloc extends Bloc<PostManagementEvent, PostManagementState> {
  final PostRepository postRepository;

  PostManagementBloc({required this.postRepository}) : super(PostManagementState(status: StateStatus.initial())) {
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
      await postRepository.post(event.content, event.image);

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
