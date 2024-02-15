import 'package:bloc/bloc.dart';
import 'package:flutter_partiel_5al/model/post_list.dart';
import 'package:meta/meta.dart';

import '../../datasource/api/http_error.dart';
import '../../datasource/repository/post_repository.dart';
import '../../model/post.dart';
import '../state_status.dart';

part 'post_list_event.dart';

part 'post_list_state.dart';

class PostListBloc extends Bloc<PostListEvent, PostListState> {
  final PostRepository postRepository;

  PostListBloc({required this.postRepository})
      : super(PostListState(status: StateStatus.initial())) {
    on<Init>(_onInit);
    on<GetListPost>(_onGetListPost);
    on<AddListPost>(_onAddListPost);
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
      PostList postList = await postRepository.get(1, 15);

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

  void _onAddListPost(AddListPost event, Emitter<PostListState> emit) async {
    emit(state.copyWith(
      status: StateStatus(
        status: StateStatusEnum.loadingNewItems,
      ),
    ));

    try {
      print(state.postList?.nextPage);
      PostList postList = await postRepository.get(state.postList?.nextPage, 15);
      print(postList.nextPage);
      if (postList.items != null) {
        state.addInList(postList);
        emit(state.copyWith(
          status: StateStatus(
            status: StateStatusEnum.success,
          ),
        ));
      }
    } on HttpError catch (e) {
      emit(state.copyWith(
        status: StateStatus.error(
          message: e.message,
        ),
      ));
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(
        status: StateStatus.error(
          message: "Error, please retry later !",
        ),
      ));
    }
  }
}
