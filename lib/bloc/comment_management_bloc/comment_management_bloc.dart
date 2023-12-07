import 'package:bloc/bloc.dart';
import 'package:flutter_partiel_5al/datasource/repository/comment_repository.dart';
import 'package:meta/meta.dart';

import '../../datasource/api/http_error.dart';

part 'comment_management_event.dart';
part 'comment_management_state.dart';

class CommentManagementBloc extends Bloc<CommentManagementEvent, CommentManagementState> {
  final CommentRepository commentRepository;

  CommentManagementBloc({required this.commentRepository}) : super(CommentManagementState(status: CommentStatusEnum.initial)) {
    on<InitCommentManagement>(_onInit);
    on<CreateComment>(_onCreate);
    on<UpdateComment>(_onUpdate);
    on<DeleteComment>(_onDelete);
  }

  void _onInit(InitCommentManagement event, Emitter<CommentManagementState> emit) async {
    emit(CommentManagementState(
      status: CommentStatusEnum.initial,
    ));
  }

  void _onCreate(CreateComment event, Emitter<CommentManagementState> emit) async {
    emit(CommentManagementState(
      status: CommentStatusEnum.loading,
    ));

    try {
      await commentRepository.post(event.postId, event.content);

      emit(CommentManagementState(
        status: CommentStatusEnum.created,
      ));
    } on HttpError catch (e) {
      emit(CommentManagementState(
        status: CommentStatusEnum.error,
        message: e.message,
      ));
    } catch (e) {
      emit(CommentManagementState(
        status: CommentStatusEnum.error,
        message: "Error, please retry later !",
      ));
    }
  }

  void _onUpdate(UpdateComment event, Emitter<CommentManagementState> emit) async {
    emit(CommentManagementState(
      status: CommentStatusEnum.loading,
    ));

    try {
      await commentRepository.patch(event.commentId, event.content);

      emit(CommentManagementState(
        status: CommentStatusEnum.updated,
      ));
    } on HttpError catch (e) {
      emit(CommentManagementState(
        status: CommentStatusEnum.error,
        message: e.message,
      ));
    } catch (e) {
      emit(CommentManagementState(
        status: CommentStatusEnum.error,
        message: "Error, please retry later !",
      ));
    }
  }

  void _onDelete(DeleteComment event, Emitter<CommentManagementState> emit) async {
    emit(CommentManagementState(
      status: CommentStatusEnum.loading,
    ));

    try {
      await commentRepository.delete(event.commentId);

      emit(CommentManagementState(
        status: CommentStatusEnum.deleted,
      ));
    } on HttpError catch (e) {
      emit(CommentManagementState(
          message: e.message,
          status: CommentStatusEnum.error
      ));
    } catch (e) {
      emit(CommentManagementState(
        status: CommentStatusEnum.error,
        message: "Error, please retry later !",
      ));
    }
  }
}
