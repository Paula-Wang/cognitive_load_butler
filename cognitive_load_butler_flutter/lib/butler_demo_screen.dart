import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

class LocalTask {
  String title;
  int importance;
  int mentalLoad;

  LocalTask({
    required this.title,
    required this.importance,
    required this.mentalLoad,
  });
}

class ButlerDemoScreen extends StatefulWidget {
  const ButlerDemoScreen({super.key});

  @override
  State<ButlerDemoScreen> createState() => _ButlerDemoScreenState();
}

class _ButlerDemoScreenState extends State<ButlerDemoScreen> {
  final List<LocalTask> tasks = [];
  List<LocalTask> todayFocus = [];

  // Browser Notification Trigger
  void notifyUser(String message) {
    if (html.Notification.permission == 'granted') {
      html.Notification('Butler Alert', body: message);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  // Algorithm to generate focus based on Cognitive Load vs Importance
  void generateFocus() {
    setState(() {
      todayFocus = [...tasks]
        ..sort((a, b) {
          final scoreA = (a.importance * 3) - a.mentalLoad;
          final scoreB = (b.importance * 3) - b.mentalLoad;
          return scoreB.compareTo(scoreA);
        });
    });

    bool hasHighImpact = todayFocus.any((t) => (t.importance * 3) - t.mentalLoad >= 8);
    if (hasHighImpact) {
      notifyUser("Master, a high-impact task requires your attention.");
    }
  }

  void showAddTaskDialog() {
    final titleController = TextEditingController();
    int importance = 3;
    int mentalLoad = 3;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Add New Task'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: 'What needs to be done?'),
                  ),
                  const SizedBox(height: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Importance: $importance', style: const TextStyle(fontWeight: FontWeight.bold)),
                      Slider(
                        value: importance.toDouble(),
                        min: 1, max: 5, divisions: 4,
                        label: importance.toString(),
                        onChanged: (v) => setDialogState(() => importance = v.toInt()),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Mental Load: $mentalLoad', style: const TextStyle(fontWeight: FontWeight.bold)),
                      Slider(
                        value: mentalLoad.toDouble(),
                        min: 1, max: 5, divisions: 4,
                        label: mentalLoad.toString(),
                        onChanged: (v) => setDialogState(() => mentalLoad = v.toInt()),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (titleController.text.trim().isNotEmpty) {
                      setState(() {
                        tasks.add(LocalTask(
                          title: titleController.text.trim(),
                          importance: importance,
                          mentalLoad: mentalLoad,
                        ));
                      });
                      Navigator.pop(dialogContext);
                    }
                  },
                  child: const Text('Add Task'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget stickyNoteCard(LocalTask task, {bool highlight = false, bool isFocus = false}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: highlight ? const Color(0xFFF0FFF4) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: highlight ? Colors.green[200]! : Colors.grey[200]!,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            offset: const Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, height: 1.2),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Row(
                children: [
                  _statChip('Imp: ${task.importance}', Colors.blueGrey[50]!),
                  const SizedBox(width: 8),
                  _statChip('Load: ${task.mentalLoad}', Colors.orange[50]!),
                ],
              ),
            ],
          ),
          
          // The Praise & Vanish Logic
          if (isFocus)
            Positioned(
              bottom: -10,
              right: -10,
              child: IconButton(
                icon: const Icon(Icons.check_circle_rounded, color: Colors.green, size: 30),
                tooltip: 'Complete Task',
                onPressed: () {
                  // Butler praises the user
                  notifyUser("Splendid job, Master! '${task.title}' is completed.");
                  
                  // Task vanishes from both lists
                  setState(() {
                    tasks.remove(task);
                    todayFocus.remove(task);
                  });
                },
              ),
            ),

          if (highlight)
            const Positioned(
              top: -4,
              right: -4,
              child: Icon(Icons.push_pin, color: Colors.redAccent, size: 24),
            ),
        ],
      ),
    );
  }

  Widget _statChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      child: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }

  Widget buildTaskGrid(List<LocalTask> taskList, {bool isFocus = false}) {
    if (taskList.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.02),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black.withOpacity(0.05)),
        ),
        child: const Center(child: Text("Your butler is waiting for tasks...")),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 320,
        mainAxisExtent: 160,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: taskList.length,
      itemBuilder: (context, index) {
        final t = taskList[index];
        final score = (t.importance * 3) - t.mentalLoad;
        return stickyNoteCard(t, highlight: isFocus && score >= 8, isFocus: isFocus);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Cognitive Load Butler', style: TextStyle(fontWeight: FontWeight.w800)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Wrap(
                spacing: 16,
                children: [
                  ElevatedButton.icon(
                    onPressed: showAddTaskDialog,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Task'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: tasks.isEmpty ? null : generateFocus,
                    icon: const Icon(Icons.psychology),
                    label: const Text("Generate Today’s Focus"),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            const Text('Your Tasks', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            buildTaskGrid(tasks, isFocus: false),
            const Padding(padding: EdgeInsets.symmetric(vertical: 40), child: Divider()),
            const Text("Today's High Impact Focus", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const Text('The butler suggests prioritizing these high-value tasks first.', style: TextStyle(fontSize: 16, color: Colors.blueGrey)),
            const SizedBox(height: 20),
            buildTaskGrid(todayFocus, isFocus: true),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
