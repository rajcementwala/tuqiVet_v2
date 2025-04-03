import '../../core/base_bloc.dart';
import '../../core/screen_state.dart';
import '../../services/on_boarding/on_boarding_service.dart';
import 'user_list_contractor.dart';

class UserListBloc extends BaseBloc<UserListEvent, UserListData> {
  UserListBloc(this._onBoardingService) : super(initState) {
    on<InitEvent>((event, emit) => add(GetUsersEvent()));
    on<GetUsersEvent>((event, emit) => _fetchUserList());
    on<UpdateUserListState>((event, emit) => emit(event.state));
  }

  final OnBoardingService _onBoardingService;

  static UserListData get initState => (UserListDataBuilder()
        ..state = ScreenState.loading
        ..users = [])
      .build();

  void _fetchUserList() {
  /*  _onBoardingService.users().then((response) {
      if (response.errorResult == null) {
        add(UpdateUserListState(state.rebuild((u) {
          u.state = ScreenState.content;
          u.users = response.data;
        })));
      } else {
        add(UpdateUserListState(state.rebuild((u) {
          u.state = ScreenState.error;
          u.errorMessage = response.errorResult!.errorMessage;
        })));
      }
    }).catchError((error) {
      add(UpdateUserListState(state.rebuild((u) {
        u.state = ScreenState.error;
        u.errorMessage = error.toString();
      })));
    });*/
  }
}
