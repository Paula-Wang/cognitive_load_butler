import 'package:serverpod/serverpod.dart';
import 'package:cognitive_load_butler_server/src/generated/protocol.dart';

class ButlerEndpoint extends Endpoint {
  Future<List<TaskFocus>> getTodayFocus(Session session) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final tasks = await Task.db.find(session);

    final List<TaskFocus> focusList = [];

    for (final task in tasks) {
      final bool isImportant = task.importance >= 4;
      final bool isDue =
          task.deadline != null && !task.deadline!.isAfter(today);

      final int score =
          (task.importance * 2) + (isDue ? 3 : 0);

      final String reason = isDue
          ? 'Due today or overdue'
          : isImportant
              ? 'High importance'
              : 'Low mental load';

      focusList.add(
        TaskFocus(
          task: task,
          score: score,
          reason: reason,
        ),
      );
    }

    focusList.sort((a, b) => b.score.compareTo(a.score));

    return focusList.take(5).toList();
  }
}

