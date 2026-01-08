// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'progress_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProgressRecord _$ProgressRecordFromJson(Map<String, dynamic> json) {
  return _ProgressRecord.fromJson(json);
}

/// @nodoc
mixin _$ProgressRecord {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get childId => throw _privateConstructorUsedError;
  @HiveField(2)
  String get activityId => throw _privateConstructorUsedError;
  @HiveField(3)
  DateTime get date => throw _privateConstructorUsedError;
  @HiveField(4)
  int get score => throw _privateConstructorUsedError;
  @HiveField(5)
  int get duration => throw _privateConstructorUsedError;
  @HiveField(6)
  int get xpEarned => throw _privateConstructorUsedError;
  @HiveField(7)
  String? get notes => throw _privateConstructorUsedError;
  @HiveField(8)
  @JsonKey(name: 'completion_status')
  String get completionStatus => throw _privateConstructorUsedError;
  @HiveField(9)
  @JsonKey(name: 'performance_metrics')
  Map<String, dynamic>? get performanceMetrics =>
      throw _privateConstructorUsedError;
  @HiveField(10)
  @JsonKey(name: 'ai_feedback')
  String? get aiFeedback => throw _privateConstructorUsedError;
  @HiveField(11)
  @JsonKey(name: 'mood_before')
  String? get moodBefore => throw _privateConstructorUsedError;
  @HiveField(12)
  @JsonKey(name: 'mood_after')
  String? get moodAfter => throw _privateConstructorUsedError;
  @HiveField(13)
  @JsonKey(name: 'difficulty_adjusted')
  bool? get difficultyAdjusted => throw _privateConstructorUsedError;
  @HiveField(14)
  @JsonKey(name: 'help_requested')
  bool? get helpRequested => throw _privateConstructorUsedError;
  @HiveField(15)
  @JsonKey(name: 'parent_approved')
  bool? get parentApproved => throw _privateConstructorUsedError;
  @HiveField(16)
  @JsonKey(name: 'sync_status')
  String get syncStatus => throw _privateConstructorUsedError;
  @HiveField(17)
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @HiveField(18)
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ProgressRecord to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProgressRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProgressRecordCopyWith<ProgressRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgressRecordCopyWith<$Res> {
  factory $ProgressRecordCopyWith(
          ProgressRecord value, $Res Function(ProgressRecord) then) =
      _$ProgressRecordCopyWithImpl<$Res, ProgressRecord>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String childId,
      @HiveField(2) String activityId,
      @HiveField(3) DateTime date,
      @HiveField(4) int score,
      @HiveField(5) int duration,
      @HiveField(6) int xpEarned,
      @HiveField(7) String? notes,
      @HiveField(8) @JsonKey(name: 'completion_status') String completionStatus,
      @HiveField(9)
      @JsonKey(name: 'performance_metrics')
      Map<String, dynamic>? performanceMetrics,
      @HiveField(10) @JsonKey(name: 'ai_feedback') String? aiFeedback,
      @HiveField(11) @JsonKey(name: 'mood_before') String? moodBefore,
      @HiveField(12) @JsonKey(name: 'mood_after') String? moodAfter,
      @HiveField(13)
      @JsonKey(name: 'difficulty_adjusted')
      bool? difficultyAdjusted,
      @HiveField(14) @JsonKey(name: 'help_requested') bool? helpRequested,
      @HiveField(15) @JsonKey(name: 'parent_approved') bool? parentApproved,
      @HiveField(16) @JsonKey(name: 'sync_status') String syncStatus,
      @HiveField(17) @JsonKey(name: 'created_at') DateTime createdAt,
      @HiveField(18) @JsonKey(name: 'updated_at') DateTime updatedAt});
}

/// @nodoc
class _$ProgressRecordCopyWithImpl<$Res, $Val extends ProgressRecord>
    implements $ProgressRecordCopyWith<$Res> {
  _$ProgressRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProgressRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? childId = null,
    Object? activityId = null,
    Object? date = null,
    Object? score = null,
    Object? duration = null,
    Object? xpEarned = null,
    Object? notes = freezed,
    Object? completionStatus = null,
    Object? performanceMetrics = freezed,
    Object? aiFeedback = freezed,
    Object? moodBefore = freezed,
    Object? moodAfter = freezed,
    Object? difficultyAdjusted = freezed,
    Object? helpRequested = freezed,
    Object? parentApproved = freezed,
    Object? syncStatus = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      childId: null == childId
          ? _value.childId
          : childId // ignore: cast_nullable_to_non_nullable
              as String,
      activityId: null == activityId
          ? _value.activityId
          : activityId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      xpEarned: null == xpEarned
          ? _value.xpEarned
          : xpEarned // ignore: cast_nullable_to_non_nullable
              as int,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      completionStatus: null == completionStatus
          ? _value.completionStatus
          : completionStatus // ignore: cast_nullable_to_non_nullable
              as String,
      performanceMetrics: freezed == performanceMetrics
          ? _value.performanceMetrics
          : performanceMetrics // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      aiFeedback: freezed == aiFeedback
          ? _value.aiFeedback
          : aiFeedback // ignore: cast_nullable_to_non_nullable
              as String?,
      moodBefore: freezed == moodBefore
          ? _value.moodBefore
          : moodBefore // ignore: cast_nullable_to_non_nullable
              as String?,
      moodAfter: freezed == moodAfter
          ? _value.moodAfter
          : moodAfter // ignore: cast_nullable_to_non_nullable
              as String?,
      difficultyAdjusted: freezed == difficultyAdjusted
          ? _value.difficultyAdjusted
          : difficultyAdjusted // ignore: cast_nullable_to_non_nullable
              as bool?,
      helpRequested: freezed == helpRequested
          ? _value.helpRequested
          : helpRequested // ignore: cast_nullable_to_non_nullable
              as bool?,
      parentApproved: freezed == parentApproved
          ? _value.parentApproved
          : parentApproved // ignore: cast_nullable_to_non_nullable
              as bool?,
      syncStatus: null == syncStatus
          ? _value.syncStatus
          : syncStatus // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProgressRecordImplCopyWith<$Res>
    implements $ProgressRecordCopyWith<$Res> {
  factory _$$ProgressRecordImplCopyWith(_$ProgressRecordImpl value,
          $Res Function(_$ProgressRecordImpl) then) =
      __$$ProgressRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) String childId,
      @HiveField(2) String activityId,
      @HiveField(3) DateTime date,
      @HiveField(4) int score,
      @HiveField(5) int duration,
      @HiveField(6) int xpEarned,
      @HiveField(7) String? notes,
      @HiveField(8) @JsonKey(name: 'completion_status') String completionStatus,
      @HiveField(9)
      @JsonKey(name: 'performance_metrics')
      Map<String, dynamic>? performanceMetrics,
      @HiveField(10) @JsonKey(name: 'ai_feedback') String? aiFeedback,
      @HiveField(11) @JsonKey(name: 'mood_before') String? moodBefore,
      @HiveField(12) @JsonKey(name: 'mood_after') String? moodAfter,
      @HiveField(13)
      @JsonKey(name: 'difficulty_adjusted')
      bool? difficultyAdjusted,
      @HiveField(14) @JsonKey(name: 'help_requested') bool? helpRequested,
      @HiveField(15) @JsonKey(name: 'parent_approved') bool? parentApproved,
      @HiveField(16) @JsonKey(name: 'sync_status') String syncStatus,
      @HiveField(17) @JsonKey(name: 'created_at') DateTime createdAt,
      @HiveField(18) @JsonKey(name: 'updated_at') DateTime updatedAt});
}

/// @nodoc
class __$$ProgressRecordImplCopyWithImpl<$Res>
    extends _$ProgressRecordCopyWithImpl<$Res, _$ProgressRecordImpl>
    implements _$$ProgressRecordImplCopyWith<$Res> {
  __$$ProgressRecordImplCopyWithImpl(
      _$ProgressRecordImpl _value, $Res Function(_$ProgressRecordImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProgressRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? childId = null,
    Object? activityId = null,
    Object? date = null,
    Object? score = null,
    Object? duration = null,
    Object? xpEarned = null,
    Object? notes = freezed,
    Object? completionStatus = null,
    Object? performanceMetrics = freezed,
    Object? aiFeedback = freezed,
    Object? moodBefore = freezed,
    Object? moodAfter = freezed,
    Object? difficultyAdjusted = freezed,
    Object? helpRequested = freezed,
    Object? parentApproved = freezed,
    Object? syncStatus = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$ProgressRecordImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      childId: null == childId
          ? _value.childId
          : childId // ignore: cast_nullable_to_non_nullable
              as String,
      activityId: null == activityId
          ? _value.activityId
          : activityId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      xpEarned: null == xpEarned
          ? _value.xpEarned
          : xpEarned // ignore: cast_nullable_to_non_nullable
              as int,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      completionStatus: null == completionStatus
          ? _value.completionStatus
          : completionStatus // ignore: cast_nullable_to_non_nullable
              as String,
      performanceMetrics: freezed == performanceMetrics
          ? _value._performanceMetrics
          : performanceMetrics // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      aiFeedback: freezed == aiFeedback
          ? _value.aiFeedback
          : aiFeedback // ignore: cast_nullable_to_non_nullable
              as String?,
      moodBefore: freezed == moodBefore
          ? _value.moodBefore
          : moodBefore // ignore: cast_nullable_to_non_nullable
              as String?,
      moodAfter: freezed == moodAfter
          ? _value.moodAfter
          : moodAfter // ignore: cast_nullable_to_non_nullable
              as String?,
      difficultyAdjusted: freezed == difficultyAdjusted
          ? _value.difficultyAdjusted
          : difficultyAdjusted // ignore: cast_nullable_to_non_nullable
              as bool?,
      helpRequested: freezed == helpRequested
          ? _value.helpRequested
          : helpRequested // ignore: cast_nullable_to_non_nullable
              as bool?,
      parentApproved: freezed == parentApproved
          ? _value.parentApproved
          : parentApproved // ignore: cast_nullable_to_non_nullable
              as bool?,
      syncStatus: null == syncStatus
          ? _value.syncStatus
          : syncStatus // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 4)
class _$ProgressRecordImpl extends _ProgressRecord {
  const _$ProgressRecordImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.childId,
      @HiveField(2) required this.activityId,
      @HiveField(3) required this.date,
      @HiveField(4) required this.score,
      @HiveField(5) required this.duration,
      @HiveField(6) required this.xpEarned,
      @HiveField(7) this.notes,
      @HiveField(8)
      @JsonKey(name: 'completion_status')
      required this.completionStatus,
      @HiveField(9)
      @JsonKey(name: 'performance_metrics')
      final Map<String, dynamic>? performanceMetrics,
      @HiveField(10) @JsonKey(name: 'ai_feedback') this.aiFeedback,
      @HiveField(11) @JsonKey(name: 'mood_before') this.moodBefore,
      @HiveField(12) @JsonKey(name: 'mood_after') this.moodAfter,
      @HiveField(13)
      @JsonKey(name: 'difficulty_adjusted')
      this.difficultyAdjusted,
      @HiveField(14) @JsonKey(name: 'help_requested') this.helpRequested,
      @HiveField(15) @JsonKey(name: 'parent_approved') this.parentApproved,
      @HiveField(16) @JsonKey(name: 'sync_status') required this.syncStatus,
      @HiveField(17) @JsonKey(name: 'created_at') required this.createdAt,
      @HiveField(18) @JsonKey(name: 'updated_at') required this.updatedAt})
      : _performanceMetrics = performanceMetrics,
        super._();

  factory _$ProgressRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProgressRecordImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String childId;
  @override
  @HiveField(2)
  final String activityId;
  @override
  @HiveField(3)
  final DateTime date;
  @override
  @HiveField(4)
  final int score;
  @override
  @HiveField(5)
  final int duration;
  @override
  @HiveField(6)
  final int xpEarned;
  @override
  @HiveField(7)
  final String? notes;
  @override
  @HiveField(8)
  @JsonKey(name: 'completion_status')
  final String completionStatus;
  final Map<String, dynamic>? _performanceMetrics;
  @override
  @HiveField(9)
  @JsonKey(name: 'performance_metrics')
  Map<String, dynamic>? get performanceMetrics {
    final value = _performanceMetrics;
    if (value == null) return null;
    if (_performanceMetrics is EqualUnmodifiableMapView)
      return _performanceMetrics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @HiveField(10)
  @JsonKey(name: 'ai_feedback')
  final String? aiFeedback;
  @override
  @HiveField(11)
  @JsonKey(name: 'mood_before')
  final String? moodBefore;
  @override
  @HiveField(12)
  @JsonKey(name: 'mood_after')
  final String? moodAfter;
  @override
  @HiveField(13)
  @JsonKey(name: 'difficulty_adjusted')
  final bool? difficultyAdjusted;
  @override
  @HiveField(14)
  @JsonKey(name: 'help_requested')
  final bool? helpRequested;
  @override
  @HiveField(15)
  @JsonKey(name: 'parent_approved')
  final bool? parentApproved;
  @override
  @HiveField(16)
  @JsonKey(name: 'sync_status')
  final String syncStatus;
  @override
  @HiveField(17)
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @HiveField(18)
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @override
  String toString() {
    return 'ProgressRecord(id: $id, childId: $childId, activityId: $activityId, date: $date, score: $score, duration: $duration, xpEarned: $xpEarned, notes: $notes, completionStatus: $completionStatus, performanceMetrics: $performanceMetrics, aiFeedback: $aiFeedback, moodBefore: $moodBefore, moodAfter: $moodAfter, difficultyAdjusted: $difficultyAdjusted, helpRequested: $helpRequested, parentApproved: $parentApproved, syncStatus: $syncStatus, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProgressRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.childId, childId) || other.childId == childId) &&
            (identical(other.activityId, activityId) ||
                other.activityId == activityId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.xpEarned, xpEarned) ||
                other.xpEarned == xpEarned) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.completionStatus, completionStatus) ||
                other.completionStatus == completionStatus) &&
            const DeepCollectionEquality()
                .equals(other._performanceMetrics, _performanceMetrics) &&
            (identical(other.aiFeedback, aiFeedback) ||
                other.aiFeedback == aiFeedback) &&
            (identical(other.moodBefore, moodBefore) ||
                other.moodBefore == moodBefore) &&
            (identical(other.moodAfter, moodAfter) ||
                other.moodAfter == moodAfter) &&
            (identical(other.difficultyAdjusted, difficultyAdjusted) ||
                other.difficultyAdjusted == difficultyAdjusted) &&
            (identical(other.helpRequested, helpRequested) ||
                other.helpRequested == helpRequested) &&
            (identical(other.parentApproved, parentApproved) ||
                other.parentApproved == parentApproved) &&
            (identical(other.syncStatus, syncStatus) ||
                other.syncStatus == syncStatus) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        childId,
        activityId,
        date,
        score,
        duration,
        xpEarned,
        notes,
        completionStatus,
        const DeepCollectionEquality().hash(_performanceMetrics),
        aiFeedback,
        moodBefore,
        moodAfter,
        difficultyAdjusted,
        helpRequested,
        parentApproved,
        syncStatus,
        createdAt,
        updatedAt
      ]);

  /// Create a copy of ProgressRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProgressRecordImplCopyWith<_$ProgressRecordImpl> get copyWith =>
      __$$ProgressRecordImplCopyWithImpl<_$ProgressRecordImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProgressRecordImplToJson(
      this,
    );
  }
}

abstract class _ProgressRecord extends ProgressRecord {
  const factory _ProgressRecord(
      {@HiveField(0) required final String id,
      @HiveField(1) required final String childId,
      @HiveField(2) required final String activityId,
      @HiveField(3) required final DateTime date,
      @HiveField(4) required final int score,
      @HiveField(5) required final int duration,
      @HiveField(6) required final int xpEarned,
      @HiveField(7) final String? notes,
      @HiveField(8)
      @JsonKey(name: 'completion_status')
      required final String completionStatus,
      @HiveField(9)
      @JsonKey(name: 'performance_metrics')
      final Map<String, dynamic>? performanceMetrics,
      @HiveField(10) @JsonKey(name: 'ai_feedback') final String? aiFeedback,
      @HiveField(11) @JsonKey(name: 'mood_before') final String? moodBefore,
      @HiveField(12) @JsonKey(name: 'mood_after') final String? moodAfter,
      @HiveField(13)
      @JsonKey(name: 'difficulty_adjusted')
      final bool? difficultyAdjusted,
      @HiveField(14) @JsonKey(name: 'help_requested') final bool? helpRequested,
      @HiveField(15)
      @JsonKey(name: 'parent_approved')
      final bool? parentApproved,
      @HiveField(16)
      @JsonKey(name: 'sync_status')
      required final String syncStatus,
      @HiveField(17)
      @JsonKey(name: 'created_at')
      required final DateTime createdAt,
      @HiveField(18)
      @JsonKey(name: 'updated_at')
      required final DateTime updatedAt}) = _$ProgressRecordImpl;
  const _ProgressRecord._() : super._();

  factory _ProgressRecord.fromJson(Map<String, dynamic> json) =
      _$ProgressRecordImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get childId;
  @override
  @HiveField(2)
  String get activityId;
  @override
  @HiveField(3)
  DateTime get date;
  @override
  @HiveField(4)
  int get score;
  @override
  @HiveField(5)
  int get duration;
  @override
  @HiveField(6)
  int get xpEarned;
  @override
  @HiveField(7)
  String? get notes;
  @override
  @HiveField(8)
  @JsonKey(name: 'completion_status')
  String get completionStatus;
  @override
  @HiveField(9)
  @JsonKey(name: 'performance_metrics')
  Map<String, dynamic>? get performanceMetrics;
  @override
  @HiveField(10)
  @JsonKey(name: 'ai_feedback')
  String? get aiFeedback;
  @override
  @HiveField(11)
  @JsonKey(name: 'mood_before')
  String? get moodBefore;
  @override
  @HiveField(12)
  @JsonKey(name: 'mood_after')
  String? get moodAfter;
  @override
  @HiveField(13)
  @JsonKey(name: 'difficulty_adjusted')
  bool? get difficultyAdjusted;
  @override
  @HiveField(14)
  @JsonKey(name: 'help_requested')
  bool? get helpRequested;
  @override
  @HiveField(15)
  @JsonKey(name: 'parent_approved')
  bool? get parentApproved;
  @override
  @HiveField(16)
  @JsonKey(name: 'sync_status')
  String get syncStatus;
  @override
  @HiveField(17)
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @HiveField(18)
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;

  /// Create a copy of ProgressRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProgressRecordImplCopyWith<_$ProgressRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
