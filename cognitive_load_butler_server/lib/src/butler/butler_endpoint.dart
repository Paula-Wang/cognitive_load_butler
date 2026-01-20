import 'package:serverpod/serverpod.dart';
import 'package:cognitive_load_butler_client/cognitive_load_butler_client.dart';

class ButlerEndpoint extends Endpoint {
  Future<List<TaskFocus>> getTodayFocus(Session session) async {
    final now = DateTime.now();

    // ✅ Demo tasks (no database)
    final tasks = <Task>[
      Task(
        title: 'Prepare presentation',
        importance: 4,
        mentalLoad: 4,
        flexible: false,
        deadline: now,
      ),
      Task(
        title: 'Pay rent',
        importance: 5,
        mentalLoad: 2,
        flexible: false,
        deadline: now,
      ),
      Task(
        title: 'Read documentation',
        importance: 3,
        mentalLoad: 5,
        flexible: true,
      ),
      Task(
        title: 'Workout',
        importance: 2,
        mentalLoad: 3,
        flexible: true,
      ),
      Task(
        title: 'Reply to emails',
        importance: 3,
        mentalLoad: 1,
        flexible: true,
      ),
    ];

    // ✅ Simple prioritisation logic
    final sorted = [...tasks]
      ..sort((a, b) {
        final importanceCompare = b.importance.compareTo(a.importance);
        if (importanceCompare != 0) return importanceCompare;
        return a.mentalLoad.compareTo(b.mentalLoad);
      });

    // ✅ Convert → TaskFocus (with required fields)
    return sorted.take(5).map((task) {
      return TaskFocus(
        task: task,
        score: (task.importance * 2) - task.mentalLoad,
        reason: task.deadline != null
            ? 'Urgent or high priority'
            : 'Lower mental load task',
      );
    }).toList();
  }
}

