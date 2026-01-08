// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get email => throw _privateConstructorUsedError;
  @HiveField(2)
  String get role => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get name => throw _privateConstructorUsedError;
  @HiveField(4)
  String? get phone => throw _privateConstructorUsedError;
  @HiveField(5)
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @HiveField(6)
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;
  @HiveField(7)
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @HiveField(8)
  @JsonKey(name: 'subscription_status')
  String? get subscriptionStatus => throw _privateConstructorUsedError;
  @HiveField(9)
  @JsonKey(name: 'trial_end_date')
  DateTime? get trialEndDate => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String email,
      @HiveField(2) String role,
      @HiveField(3) String? name,
      @HiveField(4) String? phone,
      @HiveField(5) @JsonKey(name: 'created_at') DateTime createdAt,
      @HiveField(6) @JsonKey(name: 'updated_at') DateTime updatedAt,
      @HiveField(7) @JsonKey(name: 'is_active') bool isActive,
      @HiveField(8)
      @JsonKey(name: 'subscription_status')
      String? subscriptionStatus,
      @HiveField(9) @JsonKey(name: 'trial_end_date') DateTime? trialEndDate});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? role = null,
    Object? name = freezed,
    Object? phone = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? isActive = null,
    Object? subscriptionStatus = freezed,
    Object? trialEndDate = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      subscriptionStatus: freezed == subscriptionStatus
          ? _value.subscriptionStatus
          : subscriptionStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      trialEndDate: freezed == trialEndDate
          ? _value.trialEndDate
          : trialEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String email,
      @HiveField(2) String role,
      @HiveField(3) String? name,
      @HiveField(4) String? phone,
      @HiveField(5) @JsonKey(name: 'created_at') DateTime createdAt,
      @HiveField(6) @JsonKey(name: 'updated_at') DateTime updatedAt,
      @HiveField(7) @JsonKey(name: 'is_active') bool isActive,
      @HiveField(8)
      @JsonKey(name: 'subscription_status')
      String? subscriptionStatus,
      @HiveField(9) @JsonKey(name: 'trial_end_date') DateTime? trialEndDate});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? role = null,
    Object? name = freezed,
    Object? phone = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? isActive = null,
    Object? subscriptionStatus = freezed,
    Object? trialEndDate = freezed,
  }) {
    return _then(_$UserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      subscriptionStatus: freezed == subscriptionStatus
          ? _value.subscriptionStatus
          : subscriptionStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      trialEndDate: freezed == trialEndDate
          ? _value.trialEndDate
          : trialEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 1)
class _$UserImpl extends _User {
  const _$UserImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.email,
      @HiveField(2) required this.role,
      @HiveField(3) this.name,
      @HiveField(4) this.phone,
      @HiveField(5) @JsonKey(name: 'created_at') required this.createdAt,
      @HiveField(6) @JsonKey(name: 'updated_at') required this.updatedAt,
      @HiveField(7) @JsonKey(name: 'is_active') required this.isActive,
      @HiveField(8)
      @JsonKey(name: 'subscription_status')
      this.subscriptionStatus,
      @HiveField(9) @JsonKey(name: 'trial_end_date') this.trialEndDate})
      : super._();

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String email;
  @override
  @HiveField(2)
  final String role;
  @override
  @HiveField(3)
  final String? name;
  @override
  @HiveField(4)
  final String? phone;
  @override
  @HiveField(5)
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @HiveField(6)
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @override
  @HiveField(7)
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @HiveField(8)
  @JsonKey(name: 'subscription_status')
  final String? subscriptionStatus;
  @override
  @HiveField(9)
  @JsonKey(name: 'trial_end_date')
  final DateTime? trialEndDate;

  @override
  String toString() {
    return 'User(id: $id, email: $email, role: $role, name: $name, phone: $phone, createdAt: $createdAt, updatedAt: $updatedAt, isActive: $isActive, subscriptionStatus: $subscriptionStatus, trialEndDate: $trialEndDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.subscriptionStatus, subscriptionStatus) ||
                other.subscriptionStatus == subscriptionStatus) &&
            (identical(other.trialEndDate, trialEndDate) ||
                other.trialEndDate == trialEndDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, email, role, name, phone,
      createdAt, updatedAt, isActive, subscriptionStatus, trialEndDate);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User extends User {
  const factory _User(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String email,
      @HiveField(2) required final String role,
      @HiveField(3) final String? name,
      @HiveField(4) final String? phone,
      @HiveField(5)
      @JsonKey(name: 'created_at')
      required final DateTime createdAt,
      @HiveField(6)
      @JsonKey(name: 'updated_at')
      required final DateTime updatedAt,
      @HiveField(7) @JsonKey(name: 'is_active') required final bool isActive,
      @HiveField(8)
      @JsonKey(name: 'subscription_status')
      final String? subscriptionStatus,
      @HiveField(9)
      @JsonKey(name: 'trial_end_date')
      final DateTime? trialEndDate}) = _$UserImpl;
  const _User._() : super._();

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get email;
  @override
  @HiveField(2)
  String get role;
  @override
  @HiveField(3)
  String? get name;
  @override
  @HiveField(4)
  String? get phone;
  @override
  @HiveField(5)
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @HiveField(6)
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;
  @override
  @HiveField(7)
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @HiveField(8)
  @JsonKey(name: 'subscription_status')
  String? get subscriptionStatus;
  @override
  @HiveField(9)
  @JsonKey(name: 'trial_end_date')
  DateTime? get trialEndDate;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
