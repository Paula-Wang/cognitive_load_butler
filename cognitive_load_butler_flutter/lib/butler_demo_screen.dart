import 'package:flutter/material.dart';
import 'package:cognitive_load_butler_client/cognitive_load_butler_client.dart';
import 'main.dart';

class ButlerDemoScreen extends StatefulWidget {
  const ButlerDemoScreen({super.key});

  @override
  State<ButlerDemoScreen> createState() => _ButlerDemoScreenState();
}

class _ButlerDemoScreenState extends State<ButlerDemoScreen> {
  List<TaskFocus> focusList = [];
  bool loading = false;

  Future<void> seedAndLoad() async {
    setState(() => loading = true);

    try {
      final result = await client.butler.getTodayFocus();

      if (!mounted) return;

      setState(() {
        focusList = result;
      });
    } catch (e, stack) {
      debugPrint('Error loading focus: $e');
      debugPrintStack(stackTrace: stack);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to generate focus. Please try again.'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cognitive Load Butler')),
      body: Column(
        children: [
          const SizedBox(height: 24),

          ElevatedButton(
            onPressed: loading ? null : seedAndLoad,
            child: const Text('Generate Today’s Focus'),
          ),

          const SizedBox(height: 24),

          if (loading) const CircularProgressIndicator(),

          if (!loading && focusList.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Click “Generate Today’s Focus” to see your priorities.',
                style: TextStyle(color: Colors.grey),
              ),
            ),

          Expanded(
            child: ListView.builder(
              itemCount: focusList.length,
              itemBuilder: (context, index) {
                final focus = focusList[index];
                final task = focus.task;

                return ListTile(
                  title: Text(task.title),
                  subtitle: Text(
                    '${focus.reason}\n'
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


