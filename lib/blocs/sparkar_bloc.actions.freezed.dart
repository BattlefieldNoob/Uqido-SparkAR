// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'sparkar_bloc.actions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$SparkARActionTearOff {
  const _$SparkARActionTearOff();

  _UpdateAction update() {
    return const _UpdateAction();
  }

  _SelectAction selectUser(int selectedUser) {
    return _SelectAction(
      selectedUser,
    );
  }

  _SearchAction search(String keyword) {
    return _SearchAction(
      keyword,
    );
  }

  _LoginAction login({String? email, String? password}) {
    return _LoginAction(
      email: email,
      password: password,
    );
  }
}

/// @nodoc
const $SparkARAction = _$SparkARActionTearOff();

/// @nodoc
mixin _$SparkARAction {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() update,
    required TResult Function(int selectedUser) selectUser,
    required TResult Function(String keyword) search,
    required TResult Function(String? email, String? password) login,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? update,
    TResult Function(int selectedUser)? selectUser,
    TResult Function(String keyword)? search,
    TResult Function(String? email, String? password)? login,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UpdateAction value) update,
    required TResult Function(_SelectAction value) selectUser,
    required TResult Function(_SearchAction value) search,
    required TResult Function(_LoginAction value) login,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UpdateAction value)? update,
    TResult Function(_SelectAction value)? selectUser,
    TResult Function(_SearchAction value)? search,
    TResult Function(_LoginAction value)? login,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SparkARActionCopyWith<$Res> {
  factory $SparkARActionCopyWith(
          SparkARAction value, $Res Function(SparkARAction) then) =
      _$SparkARActionCopyWithImpl<$Res>;
}

/// @nodoc
class _$SparkARActionCopyWithImpl<$Res>
    implements $SparkARActionCopyWith<$Res> {
  _$SparkARActionCopyWithImpl(this._value, this._then);

  final SparkARAction _value;
  // ignore: unused_field
  final $Res Function(SparkARAction) _then;
}

/// @nodoc
abstract class _$UpdateActionCopyWith<$Res> {
  factory _$UpdateActionCopyWith(
          _UpdateAction value, $Res Function(_UpdateAction) then) =
      __$UpdateActionCopyWithImpl<$Res>;
}

/// @nodoc
class __$UpdateActionCopyWithImpl<$Res>
    extends _$SparkARActionCopyWithImpl<$Res>
    implements _$UpdateActionCopyWith<$Res> {
  __$UpdateActionCopyWithImpl(
      _UpdateAction _value, $Res Function(_UpdateAction) _then)
      : super(_value, (v) => _then(v as _UpdateAction));

  @override
  _UpdateAction get _value => super._value as _UpdateAction;
}

/// @nodoc
class _$_UpdateAction implements _UpdateAction {
  const _$_UpdateAction();

  @override
  String toString() {
    return 'SparkARAction.update()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _UpdateAction);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() update,
    required TResult Function(int selectedUser) selectUser,
    required TResult Function(String keyword) search,
    required TResult Function(String? email, String? password) login,
  }) {
    return update();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? update,
    TResult Function(int selectedUser)? selectUser,
    TResult Function(String keyword)? search,
    TResult Function(String? email, String? password)? login,
    required TResult orElse(),
  }) {
    if (update != null) {
      return update();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UpdateAction value) update,
    required TResult Function(_SelectAction value) selectUser,
    required TResult Function(_SearchAction value) search,
    required TResult Function(_LoginAction value) login,
  }) {
    return update(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UpdateAction value)? update,
    TResult Function(_SelectAction value)? selectUser,
    TResult Function(_SearchAction value)? search,
    TResult Function(_LoginAction value)? login,
    required TResult orElse(),
  }) {
    if (update != null) {
      return update(this);
    }
    return orElse();
  }
}

abstract class _UpdateAction implements SparkARAction {
  const factory _UpdateAction() = _$_UpdateAction;
}

/// @nodoc
abstract class _$SelectActionCopyWith<$Res> {
  factory _$SelectActionCopyWith(
          _SelectAction value, $Res Function(_SelectAction) then) =
      __$SelectActionCopyWithImpl<$Res>;
  $Res call({int selectedUser});
}

/// @nodoc
class __$SelectActionCopyWithImpl<$Res>
    extends _$SparkARActionCopyWithImpl<$Res>
    implements _$SelectActionCopyWith<$Res> {
  __$SelectActionCopyWithImpl(
      _SelectAction _value, $Res Function(_SelectAction) _then)
      : super(_value, (v) => _then(v as _SelectAction));

  @override
  _SelectAction get _value => super._value as _SelectAction;

  @override
  $Res call({
    Object? selectedUser = freezed,
  }) {
    return _then(_SelectAction(
      selectedUser == freezed ? _value.selectedUser : selectedUser as int,
    ));
  }
}

/// @nodoc
class _$_SelectAction implements _SelectAction {
  const _$_SelectAction(this.selectedUser);

  @override
  final int selectedUser;

  @override
  String toString() {
    return 'SparkARAction.selectUser(selectedUser: $selectedUser)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SelectAction &&
            (identical(other.selectedUser, selectedUser) ||
                const DeepCollectionEquality()
                    .equals(other.selectedUser, selectedUser)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(selectedUser);

  @JsonKey(ignore: true)
  @override
  _$SelectActionCopyWith<_SelectAction> get copyWith =>
      __$SelectActionCopyWithImpl<_SelectAction>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() update,
    required TResult Function(int selectedUser) selectUser,
    required TResult Function(String keyword) search,
    required TResult Function(String? email, String? password) login,
  }) {
    return selectUser(selectedUser);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? update,
    TResult Function(int selectedUser)? selectUser,
    TResult Function(String keyword)? search,
    TResult Function(String? email, String? password)? login,
    required TResult orElse(),
  }) {
    if (selectUser != null) {
      return selectUser(selectedUser);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UpdateAction value) update,
    required TResult Function(_SelectAction value) selectUser,
    required TResult Function(_SearchAction value) search,
    required TResult Function(_LoginAction value) login,
  }) {
    return selectUser(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UpdateAction value)? update,
    TResult Function(_SelectAction value)? selectUser,
    TResult Function(_SearchAction value)? search,
    TResult Function(_LoginAction value)? login,
    required TResult orElse(),
  }) {
    if (selectUser != null) {
      return selectUser(this);
    }
    return orElse();
  }
}

abstract class _SelectAction implements SparkARAction {
  const factory _SelectAction(int selectedUser) = _$_SelectAction;

  int get selectedUser => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$SelectActionCopyWith<_SelectAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$SearchActionCopyWith<$Res> {
  factory _$SearchActionCopyWith(
          _SearchAction value, $Res Function(_SearchAction) then) =
      __$SearchActionCopyWithImpl<$Res>;
  $Res call({String keyword});
}

/// @nodoc
class __$SearchActionCopyWithImpl<$Res>
    extends _$SparkARActionCopyWithImpl<$Res>
    implements _$SearchActionCopyWith<$Res> {
  __$SearchActionCopyWithImpl(
      _SearchAction _value, $Res Function(_SearchAction) _then)
      : super(_value, (v) => _then(v as _SearchAction));

  @override
  _SearchAction get _value => super._value as _SearchAction;

  @override
  $Res call({
    Object? keyword = freezed,
  }) {
    return _then(_SearchAction(
      keyword == freezed ? _value.keyword : keyword as String,
    ));
  }
}

/// @nodoc
class _$_SearchAction implements _SearchAction {
  const _$_SearchAction(this.keyword);

  @override
  final String keyword;

  @override
  String toString() {
    return 'SparkARAction.search(keyword: $keyword)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SearchAction &&
            (identical(other.keyword, keyword) ||
                const DeepCollectionEquality().equals(other.keyword, keyword)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(keyword);

  @JsonKey(ignore: true)
  @override
  _$SearchActionCopyWith<_SearchAction> get copyWith =>
      __$SearchActionCopyWithImpl<_SearchAction>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() update,
    required TResult Function(int selectedUser) selectUser,
    required TResult Function(String keyword) search,
    required TResult Function(String? email, String? password) login,
  }) {
    return search(keyword);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? update,
    TResult Function(int selectedUser)? selectUser,
    TResult Function(String keyword)? search,
    TResult Function(String? email, String? password)? login,
    required TResult orElse(),
  }) {
    if (search != null) {
      return search(keyword);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UpdateAction value) update,
    required TResult Function(_SelectAction value) selectUser,
    required TResult Function(_SearchAction value) search,
    required TResult Function(_LoginAction value) login,
  }) {
    return search(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UpdateAction value)? update,
    TResult Function(_SelectAction value)? selectUser,
    TResult Function(_SearchAction value)? search,
    TResult Function(_LoginAction value)? login,
    required TResult orElse(),
  }) {
    if (search != null) {
      return search(this);
    }
    return orElse();
  }
}

abstract class _SearchAction implements SparkARAction {
  const factory _SearchAction(String keyword) = _$_SearchAction;

  String get keyword => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$SearchActionCopyWith<_SearchAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$LoginActionCopyWith<$Res> {
  factory _$LoginActionCopyWith(
          _LoginAction value, $Res Function(_LoginAction) then) =
      __$LoginActionCopyWithImpl<$Res>;
  $Res call({String? email, String? password});
}

/// @nodoc
class __$LoginActionCopyWithImpl<$Res> extends _$SparkARActionCopyWithImpl<$Res>
    implements _$LoginActionCopyWith<$Res> {
  __$LoginActionCopyWithImpl(
      _LoginAction _value, $Res Function(_LoginAction) _then)
      : super(_value, (v) => _then(v as _LoginAction));

  @override
  _LoginAction get _value => super._value as _LoginAction;

  @override
  $Res call({
    Object? email = freezed,
    Object? password = freezed,
  }) {
    return _then(_LoginAction(
      email: email == freezed ? _value.email : email as String?,
      password: password == freezed ? _value.password : password as String?,
    ));
  }
}

/// @nodoc
class _$_LoginAction implements _LoginAction {
  const _$_LoginAction({this.email, this.password});

  @override
  final String? email;
  @override
  final String? password;

  @override
  String toString() {
    return 'SparkARAction.login(email: $email, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _LoginAction &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(password);

  @JsonKey(ignore: true)
  @override
  _$LoginActionCopyWith<_LoginAction> get copyWith =>
      __$LoginActionCopyWithImpl<_LoginAction>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() update,
    required TResult Function(int selectedUser) selectUser,
    required TResult Function(String keyword) search,
    required TResult Function(String? email, String? password) login,
  }) {
    return login(email, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? update,
    TResult Function(int selectedUser)? selectUser,
    TResult Function(String keyword)? search,
    TResult Function(String? email, String? password)? login,
    required TResult orElse(),
  }) {
    if (login != null) {
      return login(email, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UpdateAction value) update,
    required TResult Function(_SelectAction value) selectUser,
    required TResult Function(_SearchAction value) search,
    required TResult Function(_LoginAction value) login,
  }) {
    return login(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UpdateAction value)? update,
    TResult Function(_SelectAction value)? selectUser,
    TResult Function(_SearchAction value)? search,
    TResult Function(_LoginAction value)? login,
    required TResult orElse(),
  }) {
    if (login != null) {
      return login(this);
    }
    return orElse();
  }
}

abstract class _LoginAction implements SparkARAction {
  const factory _LoginAction({String? email, String? password}) =
      _$_LoginAction;

  String? get email => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$LoginActionCopyWith<_LoginAction> get copyWith =>
      throw _privateConstructorUsedError;
}
