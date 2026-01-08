// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Activity _$ActivityFromJson(Map<String, dynamic> json) {
  return _Activity.fromJson(json);
}

/// @nodoc
mixin _$Activity {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get title => throw _privateConstructorUsedError;
  @HiveField(2)
  String get description => throw _privateConstructorUsedError;
  @HiveField(3)
  String get category => throw _privateConstructorUsedError;
  @HiveField(4)
  String get type => throw _privateConstructorUsedError;
  @HiveField(5)
  String get aspect => throw _privateConstructorUsedError;
  @HiveField(6)
  List<String> get ageRange => throw _privateConstructorUsedError;
  @HiveField(7)
  String get difficulty => throw _privateConstructorUsedError;
  @HiveField(8)
  int get duration => throw _privateConstructorUsedError;
  @HiveField(9)
  int get xpReward => throw _privateConstructorUsedError;
  @HiveField(10)
  String get thumbnailUrl => throw _privateConstructorUsedError;
  @HiveField(11)
  String? get contentUrl => throw _privateConstructorUsedError;
  @HiveField(12)
  List<String> get tags => throw _privateConstructorUsedError;
  @HiveField(13)
  List<String> get learningObjectives => throw _privateConstructorUsedError;
  @HiveField(14)
  String? get instructions => throw _privateConstructorUsedError;
  @HiveField(15)
  List<String>? get materialsNeeded => throw _privateConstructorUsedError;
  @HiveField(16)
  @JsonKey(name: 'is_offline_available')
  bool get isOfflineAvailable => throw _privateConstructorUsedError;
  @HiveField(17)
  @JsonKey(name: 'is_premium')
  bool get isPremium => throw _privateConstructorUsedError;
  @HiveField(18)
  @JsonKey(name: 'parent_approval_required')
  bool get parentApprovalRequired => throw _privateConstructorUsedError;
  @HiveField(19)
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @HiveField(20)
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;
  @HiveField(21)
  @JsonKey(name: 'completion_rate')
  double? get completionRate => throw _privateConstructorUsedError;
  @HiveField(22)
  @JsonKey(name: 'average_rating')
  double? get averageRating => throw _privateConstructorUsedError;
  @HiveField(23)
  @JsonKey(name: 'play_count')
  int get playCount => throw _privateConstructorUsedError;

  /// Serializes this Activity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Activity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActivityCopyWith<Activity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityCopyWith<$Res> {
  factory $ActivityCopyWith(Activity value, $Res Function(Activity) then) =
      _$ActivityCopyWithImpl<$Res, Activity>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String title,
      @HiveField(2) String description,
      @HiveField(3) String category,
      @HiveField(4) String type,
      @HiveField(5) String aspect,
      @HiveField(6) List<String> ageRange,
      @HiveField(7) String difficulty,
      @HiveField(8) int duration,
      @HiveField(9) int xpReward,
      @HiveField(10) String thumbnailUrl,
      @HiveField(11) String? contentUrl,
      @HiveField(12) List<String> tags,
      @HiveField(13) List<String> learningObjectives,
      @HiveField(14) String? instructions,
      @HiveField(15) List<String>? materialsNeeded,
      @HiveField(16)
      @JsonKey(name: 'is_offline_available')
      bool isOfflineAvailable,
      @HiveField(17) @JsonKey(name: 'is_premium') bool isPremium,
      @HiveField(18)
      @JsonKey(name: 'parent_approval_required')
      bool parentApprovalRequired,
      @HiveField(19) @JsonKey(name: 'created_at') DateTime createdAt,
      @HiveField(20) @JsonKey(name: 'updated_at') DateTime updatedAt,
      @HiveField(21) @JsonKey(name: 'completion_rate') double? completionRate,
      @HiveField(22) @JsonKey(name: 'average_rating') double? averageRating,
      @HiveField(23) @JsonKey(name: 'play_count') int playCount});
}

/// @nodoc
class _$ActivityCopyWithImpl<$Res, $Val extends Activity>
    implements $ActivityCopyWith<$Res> {
  _$ActivityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Activity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? category = null,
    Object? type = null,
    Object? aspect = null,
    Object? ageRange = null,
    Object? difficulty = null,
    Object? duration = null,
    Object? xpReward = null,
    Object? thumbnailUrl = null,
    Object? contentUrl = freezed,
    Object? tags = null,
    Object? learningObjectives = null,
    Object? instructions = freezed,
    Object? materialsNeeded = freezed,
    Object? isOfflineAvailable = null,
    Object? isPremium = null,
    Object? parentApprovalRequired = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? completionRate = freezed,
    Object? averageRating = freezed,
    Object? playCount = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      aspect: null == aspect
          ? _value.aspect
          : aspect // ignore: cast_nullable_to_non_nullable
              as String,
      ageRange: null == ageRange
          ? _value.ageRange
          : ageRange // ignore: cast_nullable_to_non_nullable
              as List<String>,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      xpReward: null == xpReward
          ? _value.xpReward
          : xpReward // ignore: cast_nullable_to_non_nullable
              as int,
      thumbnailUrl: null == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String,
      contentUrl: freezed == contentUrl
          ? _value.contentUrl
          : contentUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      learningObjectives: null == learningObjectives
          ? _value.learningObjectives
          : learningObjectives // ignore: cast_nullable_to_non_nullable
              as List<String>,
      instructions: freezed == instructions
          ? _value.instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as String?,
      materialsNeeded: freezed == materialsNeeded
          ? _value.materialsNeeded
          : materialsNeeded // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isOfflineAvailable: null == isOfflineAvailable
          ? _value.isOfflineAvailable
          : isOfflineAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      isPremium: null == isPremium
          ? _value.isPremium
          : isPremium // ignore: cast_nullable_to_non_nullable
              as bool,
      parentApprovalRequired: null == parentApprovalRequired
          ? _value.parentApprovalRequired
          : parentApprovalRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      completionRate: freezed == completionRate
          ? _value.completionRate
          : completionRate // ignore: cast_nullable_to_non_nullable
              as double?,
      averageRating: freezed == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double?,
      playCount: null == playCount
          ? _value.playCount
          : playCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ActivityImplCopyWith<$Res>
    implements $ActivityCopyWith<$Res> {
  factory _$$ActivityImplCopyWith(
          _$ActivityImpl value, $Res Function(_$ActivityImpl) then) =
      __$$ActivityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String title,
      @HiveField(2) String description,
      @HiveField(3) String category,
      @HiveField(4) String type,
      @HiveField(5) String aspect,
      @HiveField(6) List<String> ageRange,
      @HiveField(7) String difficulty,
      @HiveField(8) int duration,
      @HiveField(9) int xpReward,
      @HiveField(10) String thumbnailUrl,
      @HiveField(11) String? contentUrl,
      @HiveField(12) List<String> tags,
      @HiveField(13) List<String> learningObjectives,
      @HiveField(14) String? instructions,
      @HiveField(15) List<String>? materialsNeeded,
      @HiveField(16)
      @JsonKey(name: 'is_offline_available')
      bool isOfflineAvailable,
      @HiveField(17) @JsonKey(name: 'is_premium') bool isPremium,
      @HiveField(18)
      @JsonKey(name: 'parent_approval_required')
      bool parentApprovalRequired,
      @HiveField(19) @JsonKey(name: 'created_at') DateTime createdAt,
      @HiveField(20) @JsonKey(name: 'updated_at') DateTime updatedAt,
      @HiveField(21) @JsonKey(name: 'completion_rate') double? completionRate,
      @HiveField(22) @JsonKey(name: 'average_rating') double? averageRating,
      @HiveField(23) @JsonKey(name: 'play_count') int playCount});
}

/// @nodoc
class __$$ActivityImplCopyWithImpl<$Res>
    extends _$ActivityCopyWithImpl<$Res, _$ActivityImpl>
    implements _$$ActivityImplCopyWith<$Res> {
  __$$ActivityImplCopyWithImpl(
      _$ActivityImpl _value, $Res Function(_$ActivityImpl) _then)
      : super(_value, _then);

  /// Create a copy of Activity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? category = null,
    Object? type = null,
    Object? aspect = null,
    Object? ageRange = null,
    Object? difficulty = null,
    Object? duration = null,
    Object? xpReward = null,
    Object? thumbnailUrl = null,
    Object? contentUrl = freezed,
    Object? tags = null,
    Object? learningObjectives = null,
    Object? instructions = freezed,
    Object? materialsNeeded = freezed,
    Object? isOfflineAvailable = null,
    Object? isPremium = null,
    Object? parentApprovalRequired = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? completionRate = freezed,
    Object? averageRating = freezed,
    Object? playCount = null,
  }) {
    return _then(_$ActivityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      aspect: null == aspect
          ? _value.aspect
          : aspect // ignore: cast_nullable_to_non_nullable
              as String,
      ageRange: null == ageRange
          ? _value._ageRange
          : ageRange // ignore: cast_nullable_to_non_nullable
              as List<String>,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      xpReward: null == xpReward
          ? _value.xpReward
          : xpReward // ignore: cast_nullable_to_non_nullable
              as int,
      thumbnailUrl: null == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String,
      contentUrl: freezed == contentUrl
          ? _value.contentUrl
          : contentUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      learningObjectives: null == learningObjectives
          ? _value._learningObjectives
          : learningObjectives // ignore: cast_nullable_to_non_nullable
              as List<String>,
      instructions: freezed == instructions
          ? _value.instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as String?,
      materialsNeeded: freezed == materialsNeeded
          ? _value._materialsNeeded
          : materialsNeeded // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isOfflineAvailable: null == isOfflineAvailable
          ? _value.isOfflineAvailable
          : isOfflineAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      isPremium: null == isPremium
          ? _value.isPremium
          : isPremium // ignore: cast_nullable_to_non_nullable
              as bool,
      parentApprovalRequired: null == parentApprovalRequired
          ? _value.parentApprovalRequired
          : parentApprovalRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      completionRate: freezed == completionRate
          ? _value.completionRate
          : completionRate // ignore: cast_nullable_to_non_nullable
              as double?,
      averageRating: freezed == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double?,
      playCount: null == playCount
          ? _value.playCount
          : playCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 3)
class _$ActivityImpl extends _Activity {
  const _$ActivityImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.title,
      @HiveField(2) required this.description,
      @HiveField(3) required this.category,
      @HiveField(4) required this.type,
      @HiveField(5) required this.aspect,
      @HiveField(6) required final List<String> ageRange,
      @HiveField(7) required this.difficulty,
      @HiveField(8) required this.duration,
      @HiveField(9) required this.xpReward,
      @HiveField(10) required this.thumbnailUrl,
      @HiveField(11) this.contentUrl,
      @HiveField(12) required final List<String> tags,
      @HiveField(13) required final List<String> learningObjectives,
      @HiveField(14) this.instructions,
      @HiveField(15) final List<String>? materialsNeeded,
      @HiveField(16)
      @JsonKey(name: 'is_offline_available')
      required this.isOfflineAvailable,
      @HiveField(17) @JsonKey(name: 'is_premium') required this.isPremium,
      @HiveField(18)
      @JsonKey(name: 'parent_approval_required')
      required this.parentApprovalRequired,
      @HiveField(19) @JsonKey(name: 'created_at') required this.createdAt,
      @HiveField(20) @JsonKey(name: 'updated_at') required this.updatedAt,
      @HiveField(21) @JsonKey(name: 'completion_rate') this.completionRate,
      @HiveField(22) @JsonKey(name: 'average_rating') this.averageRating,
      @HiveField(23) @JsonKey(name: 'play_count') required this.playCount})
      : _ageRange = ageRange,
        _tags = tags,
        _learningObjectives = learningObjectives,
        _materialsNeeded = materialsNeeded,
        super._();

  factory _$ActivityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActivityImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String title;
  @override
  @HiveField(2)
  final String description;
  @override
  @HiveField(3)
  final String category;
  @override
  @HiveField(4)
  final String type;
  @override
  @HiveField(5)
  final String aspect;
  final List<String> _ageRange;
  @override
  @HiveField(6)
  List<String> get ageRange {
    if (_ageRange is EqualUnmodifiableListView) return _ageRange;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ageRange);
  }

  @override
  @HiveField(7)
  final String difficulty;
  @override
  @HiveField(8)
  final int duration;
  @override
  @HiveField(9)
  final int xpReward;
  @override
  @HiveField(10)
  final String thumbnailUrl;
  @override
  @HiveField(11)
  final String? contentUrl;
  final List<String> _tags;
  @override
  @HiveField(12)
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  final List<String> _learningObjectives;
  @override
  @HiveField(13)
  List<String> get learningObjectives {
    if (_learningObjectives is EqualUnmodifiableListView)
      return _learningObjectives;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_learningObjectives);
  }

  @override
  @HiveField(14)
  final String? instructions;
  final List<String>? _materialsNeeded;
  @override
  @HiveField(15)
  List<String>? get materialsNeeded {
    final value = _materialsNeeded;
    if (value == null) return null;
    if (_materialsNeeded is EqualUnmodifiableListView) return _materialsNeeded;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @HiveField(16)
  @JsonKey(name: 'is_offline_available')
  final bool isOfflineAvailable;
  @override
  @HiveField(17)
  @JsonKey(name: 'is_premium')
  final bool isPremium;
  @override
  @HiveField(18)
  @JsonKey(name: 'parent_approval_required')
  final bool parentApprovalRequired;
  @override
  @HiveField(19)
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @HiveField(20)
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @override
  @HiveField(21)
  @JsonKey(name: 'completion_rate')
  final double? completionRate;
  @override
  @HiveField(22)
  @JsonKey(name: 'average_rating')
  final double? averageRating;
  @override
  @HiveField(23)
  @JsonKey(name: 'play_count')
  final int playCount;

  @override
  String toString() {
    return 'Activity(id: $id, title: $title, description: $description, category: $category, type: $type, aspect: $aspect, ageRange: $ageRange, difficulty: $difficulty, duration: $duration, xpReward: $xpReward, thumbnailUrl: $thumbnailUrl, contentUrl: $contentUrl, tags: $tags, learningObjectives: $learningObjectives, instructions: $instructions, materialsNeeded: $materialsNeeded, isOfflineAvailable: $isOfflineAvailable, isPremium: $isPremium, parentApprovalRequired: $parentApprovalRequired, createdAt: $createdAt, updatedAt: $updatedAt, completionRate: $completionRate, averageRating: $averageRating, playCount: $playCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.aspect, aspect) || other.aspect == aspect) &&
            const DeepCollectionEquality().equals(other._ageRange, _ageRange) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.xpReward, xpReward) ||
                other.xpReward == xpReward) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.contentUrl, contentUrl) ||
                other.contentUrl == contentUrl) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality()
                .equals(other._learningObjectives, _learningObjectives) &&
            (identical(other.instructions, instructions) ||
                other.instructions == instructions) &&
            const DeepCollectionEquality()
                .equals(other._materialsNeeded, _materialsNeeded) &&
            (identical(other.isOfflineAvailable, isOfflineAvailable) ||
                other.isOfflineAvailable == isOfflineAvailable) &&
            (identical(other.isPremium, isPremium) ||
                other.isPremium == isPremium) &&
            (identical(other.parentApprovalRequired, parentApprovalRequired) ||
                other.parentApprovalRequired == parentApprovalRequired) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.completionRate, completionRate) ||
                other.completionRate == completionRate) &&
            (identical(other.averageRating, averageRating) ||
                other.averageRating == averageRating) &&
            (identical(other.playCount, playCount) ||
                other.playCount == playCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        title,
        description,
        category,
        type,
        aspect,
        const DeepCollectionEquality().hash(_ageRange),
        difficulty,
        duration,
        xpReward,
        thumbnailUrl,
        contentUrl,
        const DeepCollectionEquality().hash(_tags),
        const DeepCollectionEquality().hash(_learningObjectives),
        instructions,
        const DeepCollectionEquality().hash(_materialsNeeded),
        isOfflineAvailable,
        isPremium,
        parentApprovalRequired,
        createdAt,
        updatedAt,
        completionRate,
        averageRating,
        playCount
      ]);

  /// Create a copy of Activity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivityImplCopyWith<_$ActivityImpl> get copyWith =>
      __$$ActivityImplCopyWithImpl<_$ActivityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActivityImplToJson(
      this,
    );
  }
}

abstract class _Activity extends Activity {
  const factory _Activity(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String title,
      @HiveField(2) required final String description,
      @HiveField(3) required final String category,
      @HiveField(4) required final String type,
      @HiveField(5) required final String aspect,
      @HiveField(6) required final List<String> ageRange,
      @HiveField(7) required final String difficulty,
      @HiveField(8) required final int duration,
      @HiveField(9) required final int xpReward,
      @HiveField(10) required final String thumbnailUrl,
      @HiveField(11) final String? contentUrl,
      @HiveField(12) required final List<String> tags,
      @HiveField(13) required final List<String> learningObjectives,
      @HiveField(14) final String? instructions,
      @HiveField(15) final List<String>? materialsNeeded,
      @HiveField(16)
      @JsonKey(name: 'is_offline_available')
      required final bool isOfflineAvailable,
      @HiveField(17) @JsonKey(name: 'is_premium') required final bool isPremium,
      @HiveField(18)
      @JsonKey(name: 'parent_approval_required')
      required final bool parentApprovalRequired,
      @HiveField(19)
      @JsonKey(name: 'created_at')
      required final DateTime createdAt,
      @HiveField(20)
      @JsonKey(name: 'updated_at')
      required final DateTime updatedAt,
      @HiveField(21)
      @JsonKey(name: 'completion_rate')
      final double? completionRate,
      @HiveField(22)
      @JsonKey(name: 'average_rating')
      final double? averageRating,
      @HiveField(23)
      @JsonKey(name: 'play_count')
      required final int playCount}) = _$ActivityImpl;
  const _Activity._() : super._();

  factory _Activity.fromJson(Map<String, dynamic> json) =
      _$ActivityImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get title;
  @override
  @HiveField(2)
  String get description;
  @override
  @HiveField(3)
  String get category;
  @override
  @HiveField(4)
  String get type;
  @override
  @HiveField(5)
  String get aspect;
  @override
  @HiveField(6)
  List<String> get ageRange;
  @override
  @HiveField(7)
  String get difficulty;
  @override
  @HiveField(8)
  int get duration;
  @override
  @HiveField(9)
  int get xpReward;
  @override
  @HiveField(10)
  String get thumbnailUrl;
  @override
  @HiveField(11)
  String? get contentUrl;
  @override
  @HiveField(12)
  List<String> get tags;
  @override
  @HiveField(13)
  List<String> get learningObjectives;
  @override
  @HiveField(14)
  String? get instructions;
  @override
  @HiveField(15)
  List<String>? get materialsNeeded;
  @override
  @HiveField(16)
  @JsonKey(name: 'is_offline_available')
  bool get isOfflineAvailable;
  @override
  @HiveField(17)
  @JsonKey(name: 'is_premium')
  bool get isPremium;
  @override
  @HiveField(18)
  @JsonKey(name: 'parent_approval_required')
  bool get parentApprovalRequired;
  @override
  @HiveField(19)
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @HiveField(20)
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;
  @override
  @HiveField(21)
  @JsonKey(name: 'completion_rate')
  double? get completionRate;
  @override
  @HiveField(22)
  @JsonKey(name: 'average_rating')
  double? get averageRating;
  @override
  @HiveField(23)
  @JsonKey(name: 'play_count')
  int get playCount;

  /// Create a copy of Activity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActivityImplCopyWith<_$ActivityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
