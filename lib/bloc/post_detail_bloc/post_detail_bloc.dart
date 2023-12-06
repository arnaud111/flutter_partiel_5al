import 'package:bloc/bloc.dart';
import 'package:flutter_partiel_5al/model/post.dart';
import 'package:meta/meta.dart';

import '../../datasource/api/http_error.dart';
import '../../datasource/repository/post_repository.dart';
import '../state_status.dart';

part 'post_detail_event.dart';
part 'post_detail_state.dart';

class PostDetailBloc extends Bloc<PostDetailEvent, PostDetailState> {
  final PostRepository postRepository;

  PostDetailBloc({required this.postRepository}) : super(PostDetailState(status: StateStatus.initial())) {
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
      Post post = await postRepository.getById(event.postId);

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
