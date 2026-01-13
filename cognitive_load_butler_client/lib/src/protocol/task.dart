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

abstract class Task implements _i1.SerializableModel {
  Task._({
    this.id,
    required this.title,
    required this.importance,
    required this.mentalLoad,
    this.deadline,
    required this.flexible,
  });

  factory Task({
    int? id,
    required String title,
    required int importance,
    required int mentalLoad,
    DateTime? deadline,
    required bool flexible,
  }) = _TaskImpl;

  factory Task.fromJson(Map<String, dynamic> jsonSerialization) {
    return Task(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      importance: jsonSerialization['importance'] as int,
      mentalLoad: jsonSerialization['mentalLoad'] as int,
      deadline: jsonSerialization['deadline'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['deadline']),
      flexible: jsonSerialization['flexible'] as bool,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String title;

  int importance;

  int mentalLoad;

  DateTime? deadline;

  bool flexible;

  /// Returns a shallow copy of this [Task]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Task copyWith({
    int? id,
    String? title,
    int? importance,
    int? mentalLoad,
    DateTime? deadline,
    bool? flexible,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Task',
      if (id != null) 'id': id,
      'title': title,
      'importance': importance,
      'mentalLoad': mentalLoad,
      if (deadline != null) 'deadline': deadline?.toJson(),
      'flexible': flexible,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TaskImpl extends Task {
  _TaskImpl({
    int? id,
    required String title,
    required int importance,
    required int mentalLoad,
    DateTime? deadline,
    required bool flexible,
  }) : super._(
         id: id,
         title: title,
         importance: importance,
         mentalLoad: mentalLoad,
         deadline: deadline,
         flexible: flexible,
       );

  /// Returns a shallow copy of this [Task]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Task copyWith({
    Object? id = _Undefined,
    String? title,
    int? importance,
    int? mentalLoad,
    Object? deadline = _Undefined,
    bool? flexible,
  }) {
    return Task(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      importance: importance ?? this.importance,
      mentalLoad: mentalLoad ?? this.mentalLoad,
      deadline: deadline is DateTime? ? deadline : this.deadline,
      flexible: flexible ?? this.flexible,
    );
  }
}
