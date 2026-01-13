import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class ButlerEndpoint extends Endpoint {

  /// Create a new task
  Future<Task> createTask(Session session, Task task) async {
    final newTask = task.copyWith(id: null);
    await Task.db.insert(session, [newTask]);
    return newTask;
  }

  /// Fetch all tasks
  Future<List<Task>> getAllTasks(Session session) async {
    return await Task.db.find(session);
  }

  /// Ranked "Today's Focus"
  Future<List<TaskFocus>> getTodayFocus(Session session) async {
    final tasks = await Task.db.find(session);
    final today = DateTime.now();

    final scoredTasks = tasks.map((task) {
      int score = 0;
      final reasons = <String>[];

      // 🔴 Urgency
      if (task.deadline != null) {
        if (task.deadline!.isBefore(today)) {
          score -= 20;
          reasons.add('Overdue');
        } else if (task.deadline!.difference(today).inDays == 0) {
          score -= 10;
          reasons.add('Due today');
        }
      }

      // 🔵 Importance
      if (task.importance >= 4) {
        score -= task.importance * 3;
        reasons.add('High importance');
      }

      // 🟡 Mental load
      if (task.mentalLoad <= 2) {
        score += task.mentalLoad * 2;
        reasons.add('Low mental load');
      }

      // 🟢 Flexibility
      if (task.flexible && task.importance < 4) {
        score += 3;
        reasons.add('Flexible task');
      }

      return TaskFocus(
        task: task,
        score: score,
        reason: reasons.join(' • '),
      );
    }).toList();

    scoredTasks.sort((a, b) => a.score.compareTo(b.score));
    return scoredTasks;
  }

  /// Demo-only seed
  Future<void> seedDemoTasks(Session session) async {
    final existing = await Task.db.find(session);
    if (existing.isNotEmpty) return;

    final demoTasks = [
      Task(
        title: 'Pay rent',
        importance: 5,
        mentalLoad: 2,
        deadline: DateTime.now().subtract(const Duration(days: 1)),
        flexible: false,
      ),
      Task(
        title: 'Prepare presentation',
        importance: 4,
        mentalLoad: 4,
        deadline: DateTime.now(),
        flexible: false,
      ),
      Task(
        title: 'Reply to emails',
        importance: 3,
        mentalLoad: 1,
        deadline: null,
        flexible: true,
      ),
      Task(
        title: 'Workout',
        importance: 2,
        mentalLoad: 3,
        deadline: null,
        flexible: true,
      ),
      Task(
        title: 'Read documentation',
        importance: 3,
        mentalLoad: 5,
        deadline: DateTime.now().add(const Duration(days: 3)),
        flexible: true,
      ),
    ];

    await Task.db.insert(session, demoTasks);
  }
}

