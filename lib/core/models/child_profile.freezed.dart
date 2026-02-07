// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'child_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChildProfile _$ChildProfileFromJson(Map<String, dynamic> json) {
  return _ChildProfile.fromJson(json);
}

/// @nodoc
mixin _$ChildProfile {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @HiveField(2)
  int get age => throw _privateConstructorUsedError;
  @HiveField(3)
  String get avatar => throw _privateConstructorUsedError;
  @HiveField(4)
  List<String> get interests => throw _privateConstructorUsedError;
  @HiveField(5)
  int get level => throw _privateConstructorUsedError;
  @HiveField(6)
  int get xp => throw _privateConstructorUsedError;
  @HiveField(7)
  int get streak => throw _privateConstructorUsedError;
  @HiveField(8)
  List<String> get favorites => throw _privateConstructorUsedError;
  @HiveField(9)
  String get parentId => throw _privateConstructorUsedError;
  @HiveField(10)
  @JsonKey(name: 'picture_password')
  List<String> get picturePassword => throw _privateConstructorUsedError;
  @HiveField(11)
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @HiveField(12)
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;
  @HiveField(13)
  @JsonKey(name: 'last_session')
  DateTime? get lastSession => throw _privateConstructorUsedError;
  @HiveField(14)
  @JsonKey(name: 'total_time_spent')
  int get totalTimeSpent => throw _privateConstructorUsedError;
  @HiveField(15)
  @JsonKey(name: 'activities_completed')
  int get activitiesCompleted => throw _privateConstructorUsedError;
  @HiveField(16)
  @JsonKey(name: 'current_mood')
  String? get currentMood => throw _privateConstructorUsedError;
  @HiveField(17)
  @JsonKey(name: 'learning_style')
  String? get learningStyle => throw _privateConstructorUsedError;
  @HiveField(18)
  @JsonKey(name: 'special_needs')
  List<String>? get specialNeeds => throw _privateConstructorUsedError;
  @HiveField(19)
  @JsonKey(name: 'accessibility_needs')
  List<String>? get accessibilityNeeds => throw _privateConstructorUsedError;

  /// Serializes this ChildProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChildProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChildProfileCopyWith<ChildProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChildProfileCopyWith<$Res> {
  factory $ChildProfileCopyWith(
          ChildProfile value, $Res Function(ChildProfile) then) =
      _$ChildProfileCopyWithImpl<$Res, ChildProfile>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) int age,
      @HiveField(3) String avatar,
      @HiveField(4) List<String> interests,
      @HiveField(5) int level,
      @HiveField(6) int xp,
      @HiveField(7) int streak,
      @HiveField(8) List<String> favorites,
      @HiveField(9) String parentId,
      @HiveField(10)
      @JsonKey(name: 'picture_password')
      List<String> picturePassword,
      @HiveField(11) @JsonKey(name: 'created_at') DateTime createdAt,
      @HiveField(12) @JsonKey(name: 'updated_at') DateTime updatedAt,
      @HiveField(13) @JsonKey(name: 'last_session') DateTime? lastSession,
      @HiveField(14) @JsonKey(name: 'total_time_spent') int totalTimeSpent,
      @HiveField(15)
      @JsonKey(name: 'activities_completed')
      int activitiesCompleted,
      @HiveField(16) @JsonKey(name: 'current_mood') String? currentMood,
      @HiveField(17) @JsonKey(name: 'learning_style') String? learningStyle,
      @HiveField(18) @JsonKey(name: 'special_needs') List<String>? specialNeeds,
      @HiveField(19)
      @JsonKey(name: 'accessibility_needs')
      List<String>? accessibilityNeeds});
}

/// @nodoc
class _$ChildProfileCopyWithImpl<$Res, $Val extends ChildProfile>
    implements $ChildProfileCopyWith<$Res> {
  _$ChildProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChildProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? age = null,
    Object? avatar = null,
    Object? interests = null,
    Object? level = null,
    Object? xp = null,
    Object? streak = null,
    Object? favorites = null,
    Object? parentId = null,
    Object? picturePassword = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? lastSession = freezed,
    Object? totalTimeSpent = null,
    Object? activitiesCompleted = null,
    Object? currentMood = freezed,
    Object? learningStyle = freezed,
    Object? specialNeeds = freezed,
    Object? accessibilityNeeds = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      interests: null == interests
          ? _value.interests
          : interests // ignore: cast_nullable_to_non_nullable
              as List<String>,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      xp: null == xp
          ? _value.xp
          : xp // ignore: cast_nullable_to_non_nullable
              as int,
      streak: null == streak
          ? _value.streak
          : streak // ignore: cast_nullable_to_non_nullable
              as int,
      favorites: null == favorites
          ? _value.favorites
          : favorites // ignore: cast_nullable_to_non_nullable
              as List<String>,
      parentId: null == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String,
      picturePassword: null == picturePassword
          ? _value.picturePassword
          : picturePassword // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastSession: freezed == lastSession
          ? _value.lastSession
          : lastSession // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      totalTimeSpent: null == totalTimeSpent
          ? _value.totalTimeSpent
          : totalTimeSpent // ignore: cast_nullable_to_non_nullable
              as int,
      activitiesCompleted: null == activitiesCompleted
          ? _value.activitiesCompleted
          : activitiesCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      currentMood: freezed == currentMood
          ? _value.currentMood
          : currentMood // ignore: cast_nullable_to_non_nullable
              as String?,
      learningStyle: freezed == learningStyle
          ? _value.learningStyle
          : learningStyle // ignore: cast_nullable_to_non_nullable
              as String?,
      specialNeeds: freezed == specialNeeds
          ? _value.specialNeeds
          : specialNeeds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      accessibilityNeeds: freezed == accessibilityNeeds
          ? _value.accessibilityNeeds
          : accessibilityNeeds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChildProfileImplCopyWith<$Res>
    implements $ChildProfileCopyWith<$Res> {
  factory _$$ChildProfileImplCopyWith(
          _$ChildProfileImpl value, $Res Function(_$ChildProfileImpl) then) =
      __$$ChildProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String name,
      @HiveField(2) int age,
      @HiveField(3) String avatar,
      @HiveField(4) List<String> interests,
      @HiveField(5) int level,
      @HiveField(6) int xp,
      @HiveField(7) int streak,
      @HiveField(8) List<String> favorites,
      @HiveField(9) String parentId,
      @HiveField(10)
      @JsonKey(name: 'picture_password')
      List<String> picturePassword,
      @HiveField(11) @JsonKey(name: 'created_at') DateTime createdAt,
      @HiveField(12) @JsonKey(name: 'updated_at') DateTime updatedAt,
      @HiveField(13) @JsonKey(name: 'last_session') DateTime? lastSession,
      @HiveField(14) @JsonKey(name: 'total_time_spent') int totalTimeSpent,
      @HiveField(15)
      @JsonKey(name: 'activities_completed')
      int activitiesCompleted,
      @HiveField(16) @JsonKey(name: 'current_mood') String? currentMood,
      @HiveField(17) @JsonKey(name: 'learning_style') String? learningStyle,
      @HiveField(18) @JsonKey(name: 'special_needs') List<String>? specialNeeds,
      @HiveField(19)
      @JsonKey(name: 'accessibility_needs')
      List<String>? accessibilityNeeds});
}

/// @nodoc
class __$$ChildProfileImplCopyWithImpl<$Res>
    extends _$ChildProfileCopyWithImpl<$Res, _$ChildProfileImpl>
    implements _$$ChildProfileImplCopyWith<$Res> {
  __$$ChildProfileImplCopyWithImpl(
      _$ChildProfileImpl _value, $Res Function(_$ChildProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChildProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? age = null,
    Object? avatar = null,
    Object? interests = null,
    Object? level = null,
    Object? xp = null,
    Object? streak = null,
    Object? favorites = null,
    Object? parentId = null,
    Object? picturePassword = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? lastSession = freezed,
    Object? totalTimeSpent = null,
    Object? activitiesCompleted = null,
    Object? currentMood = freezed,
    Object? learningStyle = freezed,
    Object? specialNeeds = freezed,
    Object? accessibilityNeeds = freezed,
  }) {
    return _then(_$ChildProfileImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      interests: null == interests
          ? _value._interests
          : interests // ignore: cast_nullable_to_non_nullable
              as List<String>,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      xp: null == xp
          ? _value.xp
          : xp // ignore: cast_nullable_to_non_nullable
              as int,
      streak: null == streak
          ? _value.streak
          : streak // ignore: cast_nullable_to_non_nullable
              as int,
      favorites: null == favorites
          ? _value._favorites
          : favorites // ignore: cast_nullable_to_non_nullable
              as List<String>,
      parentId: null == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String,
      picturePassword: null == picturePassword
          ? _value._picturePassword
          : picturePassword // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastSession: freezed == lastSession
          ? _value.lastSession
          : lastSession // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      totalTimeSpent: null == totalTimeSpent
          ? _value.totalTimeSpent
          : totalTimeSpent // ignore: cast_nullable_to_non_nullable
              as int,
      activitiesCompleted: null == activitiesCompleted
          ? _value.activitiesCompleted
          : activitiesCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      currentMood: freezed == currentMood
          ? _value.currentMood
          : currentMood // ignore: cast_nullable_to_non_nullable
              as String?,
      learningStyle: freezed == learningStyle
          ? _value.learningStyle
          : learningStyle // ignore: cast_nullable_to_non_nullable
              as String?,
      specialNeeds: freezed == specialNeeds
          ? _value._specialNeeds
          : specialNeeds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      accessibilityNeeds: freezed == accessibilityNeeds
          ? _value._accessibilityNeeds
          : accessibilityNeeds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 2)
class _$ChildProfileImpl extends _ChildProfile {
  const _$ChildProfileImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.name,
      @HiveField(2) required this.age,
      @HiveField(3) required this.avatar,
      @HiveField(4) required final List<String> interests,
      @HiveField(5) required this.level,
      @HiveField(6) required this.xp,
      @HiveField(7) required this.streak,
      @HiveField(8) required final List<String> favorites,
      @HiveField(9) required this.parentId,
      @HiveField(10)
      @JsonKey(name: 'picture_password')
      required final List<String> picturePassword,
      @HiveField(11) @JsonKey(name: 'created_at') required this.createdAt,
      @HiveField(12) @JsonKey(name: 'updated_at') required this.updatedAt,
      @HiveField(13) @JsonKey(name: 'last_session') this.lastSession,
      @HiveField(14)
      @JsonKey(name: 'total_time_spent')
      required this.totalTimeSpent,
      @HiveField(15)
      @JsonKey(name: 'activities_completed')
      required this.activitiesCompleted,
      @HiveField(16) @JsonKey(name: 'current_mood') this.currentMood,
      @HiveField(17) @JsonKey(name: 'learning_style') this.learningStyle,
      @HiveField(18)
      @JsonKey(name: 'special_needs')
      final List<String>? specialNeeds,
      @HiveField(19)
      @JsonKey(name: 'accessibility_needs')
      final List<String>? accessibilityNeeds})
      : _interests = interests,
        _favorites = favorites,
        _picturePassword = picturePassword,
        _specialNeeds = specialNeeds,
        _accessibilityNeeds = accessibilityNeeds,
        super._();

  factory _$ChildProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChildProfileImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String name;
  @override
  @HiveField(2)
  final int age;
  @override
  @HiveField(3)
  final String avatar;
  final List<String> _interests;
  @override
  @HiveField(4)
  List<String> get interests {
    if (_interests is EqualUnmodifiableListView) return _interests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_interests);
  }

  @override
  @HiveField(5)
  final int level;
  @override
  @HiveField(6)
  final int xp;
  @override
  @HiveField(7)
  final int streak;
  final List<String> _favorites;
  @override
  @HiveField(8)
  List<String> get favorites {
    if (_favorites is EqualUnmodifiableListView) return _favorites;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_favorites);
  }

  @override
  @HiveField(9)
  final String parentId;
  final List<String> _picturePassword;
  @override
  @HiveField(10)
  @JsonKey(name: 'picture_password')
  List<String> get picturePassword {
    if (_picturePassword is EqualUnmodifiableListView) return _picturePassword;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_picturePassword);
  }

  @override
  @HiveField(11)
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @HiveField(12)
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @override
  @HiveField(13)
  @JsonKey(name: 'last_session')
  final DateTime? lastSession;
  @override
  @HiveField(14)
  @JsonKey(name: 'total_time_spent')
  final int totalTimeSpent;
  @override
  @HiveField(15)
  @JsonKey(name: 'activities_completed')
  final int activitiesCompleted;
  @override
  @HiveField(16)
  @JsonKey(name: 'current_mood')
  final String? currentMood;
  @override
  @HiveField(17)
  @JsonKey(name: 'learning_style')
  final String? learningStyle;
  final List<String>? _specialNeeds;
  @override
  @HiveField(18)
  @JsonKey(name: 'special_needs')
  List<String>? get specialNeeds {
    final value = _specialNeeds;
    if (value == null) return null;
    if (_specialNeeds is EqualUnmodifiableListView) return _specialNeeds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _accessibilityNeeds;
  @override
  @HiveField(19)
  @JsonKey(name: 'accessibility_needs')
  List<String>? get accessibilityNeeds {
    final value = _accessibilityNeeds;
    if (value == null) return null;
    if (_accessibilityNeeds is EqualUnmodifiableListView)
      return _accessibilityNeeds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ChildProfile(id: $id, name: $name, age: $age, avatar: $avatar, interests: $interests, level: $level, xp: $xp, streak: $streak, favorites: $favorites, parentId: $parentId, picturePassword: $picturePassword, createdAt: $createdAt, updatedAt: $updatedAt, lastSession: $lastSession, totalTimeSpent: $totalTimeSpent, activitiesCompleted: $activitiesCompleted, currentMood: $currentMood, learningStyle: $learningStyle, specialNeeds: $specialNeeds, accessibilityNeeds: $accessibilityNeeds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChildProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            const DeepCollectionEquality()
                .equals(other._interests, _interests) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.xp, xp) || other.xp == xp) &&
            (identical(other.streak, streak) || other.streak == streak) &&
            const DeepCollectionEquality()
                .equals(other._favorites, _favorites) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            const DeepCollectionEquality()
                .equals(other._picturePassword, _picturePassword) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.lastSession, lastSession) ||
                other.lastSession == lastSession) &&
            (identical(other.totalTimeSpent, totalTimeSpent) ||
                other.totalTimeSpent == totalTimeSpent) &&
            (identical(other.activitiesCompleted, activitiesCompleted) ||
                other.activitiesCompleted == activitiesCompleted) &&
            (identical(other.currentMood, currentMood) ||
                other.currentMood == currentMood) &&
            (identical(other.learningStyle, learningStyle) ||
                other.learningStyle == learningStyle) &&
            const DeepCollectionEquality()
                .equals(other._specialNeeds, _specialNeeds) &&
            const DeepCollectionEquality()
                .equals(other._accessibilityNeeds, _accessibilityNeeds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        age,
        avatar,
        const DeepCollectionEquality().hash(_interests),
        level,
        xp,
        streak,
        const DeepCollectionEquality().hash(_favorites),
        parentId,
        const DeepCollectionEquality().hash(_picturePassword),
        createdAt,
        updatedAt,
        lastSession,
        totalTimeSpent,
        activitiesCompleted,
        currentMood,
        learningStyle,
        const DeepCollectionEquality().hash(_specialNeeds),
        const DeepCollectionEquality().hash(_accessibilityNeeds)
      ]);

  /// Create a copy of ChildProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChildProfileImplCopyWith<_$ChildProfileImpl> get copyWith =>
      __$$ChildProfileImplCopyWithImpl<_$ChildProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChildProfileImplToJson(
      this,
    );
  }
}

abstract class _ChildProfile extends ChildProfile {
  const factory _ChildProfile(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String name,
      @HiveField(2) required final int age,
      @HiveField(3) required final String avatar,
      @HiveField(4) required final List<String> interests,
      @HiveField(5) required final int level,
      @HiveField(6) required final int xp,
      @HiveField(7) required final int streak,
      @HiveField(8) required final List<String> favorites,
      @HiveField(9) required final String parentId,
      @HiveField(10)
      @JsonKey(name: 'picture_password')
      required final List<String> picturePassword,
      @HiveField(11)
      @JsonKey(name: 'created_at')
      required final DateTime createdAt,
      @HiveField(12)
      @JsonKey(name: 'updated_at')
      required final DateTime updatedAt,
      @HiveField(13) @JsonKey(name: 'last_session') final DateTime? lastSession,
      @HiveField(14)
      @JsonKey(name: 'total_time_spent')
      required final int totalTimeSpent,
      @HiveField(15)
      @JsonKey(name: 'activities_completed')
      required final int activitiesCompleted,
      @HiveField(16) @JsonKey(name: 'current_mood') final String? currentMood,
      @HiveField(17)
      @JsonKey(name: 'learning_style')
      final String? learningStyle,
      @HiveField(18)
      @JsonKey(name: 'special_needs')
      final List<String>? specialNeeds,
      @HiveField(19)
      @JsonKey(name: 'accessibility_needs')
      final List<String>? accessibilityNeeds}) = _$ChildProfileImpl;
  const _ChildProfile._() : super._();

  factory _ChildProfile.fromJson(Map<String, dynamic> json) =
      _$ChildProfileImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get name;
  @override
  @HiveField(2)
  int get age;
  @override
  @HiveField(3)
  String get avatar;
  @override
  @HiveField(4)
  List<String> get interests;
  @override
  @HiveField(5)
  int get level;
  @override
  @HiveField(6)
  int get xp;
  @override
  @HiveField(7)
  int get streak;
  @override
  @HiveField(8)
  List<String> get favorites;
  @override
  @HiveField(9)
  String get parentId;
  @override
  @HiveField(10)
  @JsonKey(name: 'picture_password')
  List<String> get picturePassword;
  @override
  @HiveField(11)
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @HiveField(12)
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;
  @override
  @HiveField(13)
  @JsonKey(name: 'last_session')
  DateTime? get lastSession;
  @override
  @HiveField(14)
  @JsonKey(name: 'total_time_spent')
  int get totalTimeSpent;
  @override
  @HiveField(15)
  @JsonKey(name: 'activities_completed')
  int get activitiesCompleted;
  @override
  @HiveField(16)
  @JsonKey(name: 'current_mood')
  String? get currentMood;
  @override
  @HiveField(17)
  @JsonKey(name: 'learning_style')
  String? get learningStyle;
  @override
  @HiveField(18)
  @JsonKey(name: 'special_needs')
  List<String>? get specialNeeds;
  @override
  @HiveField(19)
  @JsonKey(name: 'accessibility_needs')
  List<String>? get accessibilityNeeds;

  /// Create a copy of ChildProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChildProfileImplCopyWith<_$ChildProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
