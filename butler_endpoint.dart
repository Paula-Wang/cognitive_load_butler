import 'package:serverpod/serverpod.dart';
import 'package:cognitive_load_butler_client/cognitive_load_butler_client.dart';

class ButlerEndpoint extends Endpoint {
  Future<List<Task>> getTodayFocus(Session session) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final tasks = await Task.db.find(session);

    final criticalTasks = tasks.where((task) {
      final isImportant = task.importance >= 4;
      final isDue = task.deadline != null &&
          !task.deadline!.isAfter(today);

      return isImportant || isDue;
    }).toList();

    final nonCritical = tasks.where((task) {
      return task.importance < 4 &&
          (task.deadline == null || task.deadline!.isAfter(today));
    }).toList();

    nonCritical.sort((a, b) => a.mentalLoad.compareTo(b.mentalLoad));

    return [
      ...criticalTasks,
      ...nonCritical.take(3),
    ];
  }
}

