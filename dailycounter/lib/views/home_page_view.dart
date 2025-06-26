import 'package:dailycounter/views/create_counter_view.dart';
import 'package:dailycounter/views/glowing_counter_ui.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? counterName;
  int? initialValue;
  int? incrementBy;

  Color appBarColor = Colors.deepPurple;
  Color bodyColor = Colors.deepPurple.shade50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Counter'),
        centerTitle: true,
        backgroundColor: appBarColor,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'settings') {
                _showSettings(context);
              } else if (value == 'delete') {
                _deleteCounter();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'settings',
                child: Text('Settings'),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Delete Counter'),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: bodyColor,
      body: Center(
        child: counterName == null
            ? const Text(
                'No counter created.\nPress + to create one.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              )
            : GlowingCounterUI(
                title: counterName!,
                startValue: initialValue!,
                incrementBy: incrementBy!,
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreateCounterScreen()),
          );
          if (result != null && result is Map<String, dynamic>) {
            setState(() {
              counterName = result['name'];
              initialValue = result['initial'];
              incrementBy = result['step'];
            });
          }
        },
        label: const Text('Add Counter'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  void _showSettings(BuildContext context) {
    final appBarColors = {
      'Deep Purple': Colors.deepPurple,
      'Indigo': Colors.indigo,
      'Teal': Colors.teal,
      'Orange': Colors.orange,
      'Red': Colors.red,
    };

    final bodyColors = {
      'Light Purple': Colors.deepPurple.shade50,
      'Light Indigo': Colors.indigo.shade50,
      'Light Teal': Colors.teal.shade50,
      'Light Orange': Colors.orange.shade50,
      'Light Red': Colors.red.shade50,
    };

    Color? selectedAppBarColor = appBarColor;
    Color? selectedBodyColor = bodyColor;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Settings'),
          content: StatefulBuilder(
            builder: (context, setDialogState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Select AppBar Color'),
                  DropdownButton<Color>(
                    value: selectedAppBarColor,
                    items: appBarColors.entries
                        .map((e) => DropdownMenuItem<Color>(
                              value: e.value,
                              child: Text(e.key),
                            ))
                        .toList(),
                    onChanged: (color) {
                      setDialogState(() {
                        selectedAppBarColor = color;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text('Select Body Background Color'),
                  DropdownButton<Color>(
                    value: selectedBodyColor,
                    items: bodyColors.entries
                        .map((e) => DropdownMenuItem<Color>(
                              value: e.value,
                              child: Text(e.key),
                            ))
                        .toList(),
                    onChanged: (color) {
                      setDialogState(() {
                        selectedBodyColor = color;
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Cancel
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  appBarColor = selectedAppBarColor!;
                  bodyColor = selectedBodyColor!;
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteCounter() {
    setState(() {
      counterName = null;
      initialValue = null;
      incrementBy = null;
    });
  }
}
