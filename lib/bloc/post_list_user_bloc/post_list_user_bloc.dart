import 'package:bloc/bloc.dart';
import 'package:flutter_partiel_5al/bloc/state_status.dart';
import 'package:meta/meta.dart';

import '../../datasource/api/http_error.dart';
import '../../datasource/repository/user_repository.dart';
import '../../model/post_list.dart';

part 'post_list_user_event.dart';
part 'post_list_user_state.dart';

class PostListUserBloc extends Bloc<PostListUserEvent, PostListUserState> {
  final UserRepository userRepository;

  PostListUserBloc({required this.userRepository}) : super(PostListUserState(status: StateStatus.initial())) {
    on<Init>(_onInit);
    on<GetListPost>(_onGetListPost);
  }

  void _onInit(Init event, Emitter<PostListUserState> emit) async {
    emit(PostListUserState(
      status: StateStatus.initial(),
    ));
  }

  void _onGetListPost(GetListPost event, Emitter<PostListUserState> emit) async {
    emit(PostListUserState(
      status: StateStatus.loading(),
    ));

    try {
      PostList postList = await userRepository.getPostByUserId(event.userId, null, null);

      emit(PostListUserState(
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
