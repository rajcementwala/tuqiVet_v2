import 'package:built_value/built_value.dart';
import '../../api/entities/user.dart';
import '../../core/screen_state.dart';

part 'user_list_contractor.g.dart';

abstract class UserListData
    implements Built<UserListData, UserListDataBuilder> {
  factory UserListData([void Function(UserListDataBuilder) updates]) =
      _$UserListData;

  UserListData._();

  ScreenState get state;

  String? get errorMessage;

  List<User> get users;
}

abstract class UserListEvent {}

class InitEvent extends UserListEvent {}

class GetUsersEvent extends UserListEvent {}

class UpdateUserListState extends UserListEvent {
  final UserListData state;

  UpdateUserListState(this.state);
}
