import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_partiel_5al/datasource/repository/post_repository.dart';
import 'package:meta/meta.dart';

import '../../datasource/api/http_error.dart';


part 'post_management_event.dart';

part 'post_management_state.dart';

class PostManagementBloc extends Bloc<PostManagementEvent, PostManagementState> {
  final PostRepository postRepository;

  PostManagementBloc({required this.postRepository}) : super(PostManagementState(status: PostStatusEnum.initial)) {
    on<InitPostManagement>(_onInit);
    on<Create>(_onCreate);
    on<Delete>(_onDelete);
    on<Update>(_onUpdate);
  }

  void _onInit(InitPostManagement event, Emitter<PostManagementState> emit) async {
    emit(PostManagementState(
      status: PostStatusEnum.initial,
    ));
  }

  void _onCreate(Create event, Emitter<PostManagementState> emit) async {
    emit(PostManagementState(
        status: PostStatusEnum.loading,
    ));

    try {
      await postRepository.post(event.content, event.image);

      emit(PostManagementState(
        status: PostStatusEnum.created,
      ));
    } on HttpError catch (e) {
      emit(PostManagementState(
        status: PostStatusEnum.error,
        message: e.message,
      ));
    } catch (e) {
      emit(PostManagementState(
        status: PostStatusEnum.error,
        message: "Error, please retry later !",
      ));
    }
  }

  void _onUpdate(Update event, Emitter<PostManagementState> emit) async {
    emit(PostManagementState(
      status: PostStatusEnum.loading,
    ));

    try {
      await postRepository.patch(event.postId, event.content, event.image);

      emit(PostManagementState(
        status: PostStatusEnum.updated,
      ));
    } on HttpError catch (e) {
      emit(PostManagementState(
        status: PostStatusEnum.error,
        message: e.message,
      ));
    } catch (e) {
      print(e.toString());
      emit(PostManagementState(
        status: PostStatusEnum.error,
        message: "Error, please retry later !",
      ));
    }
  }

  void _onDelete(Delete event, Emitter<PostManagementState> emit) async {
    emit(PostManagementState(
      status: PostStatusEnum.loading,
    ));

    try {
      await postRepository.delete(event.postId);

      emit(PostManagementState(
        status: PostStatusEnum.deleted,
      ));
    } on HttpError catch (e) {
      emit(PostManagementState(
        message: e.message,
        status: PostStatusEnum.error
      ));
    } catch (e) {
      emit(PostManagementState(
        status: PostStatusEnum.error,
        message: "Error, please retry later !",
      ));
    }
  }
}
