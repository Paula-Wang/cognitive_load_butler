/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'task.dart' as _i2;
import 'package:cognitive_load_butler_client/src/protocol/protocol.dart' as _i3;

abstract class TaskFocus implements _i1.SerializableModel {
  TaskFocus._({
    required this.task,
    required this.score,
    required this.reason,
  });

  factory TaskFocus({
    required _i2.Task task,
    required int score,
    required String reason,
  }) = _TaskFocusImpl;

  factory TaskFocus.fromJson(Map<String, dynamic> jsonSerialization) {
    return TaskFocus(
      task: _i3.Protocol().deserialize<_i2.Task>(jsonSerialization['task']),
      score: jsonSerialization['score'] as int,
      reason: jsonSerialization['reason'] as String,
    );
  }

  _i2.Task task;

  int score;

  String reason;

  /// Returns a shallow copy of this [TaskFocus]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TaskFocus copyWith({
    _i2.Task? task,
    int? score,
    String? reason,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TaskFocus',
      'task': task.toJson(),
      'score': score,
      'reason': reason,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _TaskFocusImpl extends TaskFocus {
  _TaskFocusImpl({
    required _i2.Task task,
    required int score,
    required String reason,
  }) : super._(
         task: task,
         score: score,
         reason: reason,
       );

  /// Returns a shallow copy of this [TaskFocus]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TaskFocus copyWith({
    _i2.Task? task,
    int? score,
    String? reason,
  }) {
    return TaskFocus(
      task: task ?? this.task.copyWith(),
      score: score ?? this.score,
      reason: reason ?? this.reason,
    );
  }
}
