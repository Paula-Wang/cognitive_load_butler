import 'package:flutter/material.dart';
import 'package:cognitive_load_butler_client/cognitive_load_butler_client.dart';
import 'main.dart';

class ButlerDemoScreen extends StatefulWidget {
  @override
  State<ButlerDemoScreen> createState() => _ButlerDemoScreenState();
}

class _ButlerDemoScreenState extends State<ButlerDemoScreen> {
  List<TaskFocus> focusList = [];
  bool loading = false;

  Future<void> seedAndLoad() async {
    setState(() => loading = true);

    await client.butler.seedDemoTasks();
    final result = await client.butler.getTodayFocus();

    setState(() {
      focusList = result;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cognitive Load Butler')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: loading ? null : seedAndLoad,
              child: const Text('Generate Today’s Focus'),
            ),
          ),

          if (loading) const CircularProgressIndicator(),

          Expanded(
            child: ListView.builder(
              itemCount: focusList.length,
              itemBuilder: (context, index) {
                final focus = focusList[index];
                final task = focus.task;


                return ListTile(
                  title: Text(task.title),
                  subtitle: Text(
                    'Importance: ${task.importance} • Mental load: ${task.mentalLoad}',
                  ),
                  trailing: task.deadline != null
                      ? const Icon(Icons.warning, color: Colors.red)
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

