
import 'package:flutter/material.dart';

class CreateCounterScreen extends StatefulWidget {
  const CreateCounterScreen({super.key});

  @override
  State<CreateCounterScreen> createState() => _CreateCounterScreenState();
}

class _CreateCounterScreenState extends State<CreateCounterScreen> {
  final nameController = TextEditingController();
  final initialValueController = TextEditingController(text: '0');
  final incrementByController = TextEditingController(text: '1');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Counter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Counter Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: initialValueController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Initial Value',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: incrementByController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Increment By',
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                final name = nameController.text.trim();
                final initial = int.tryParse(initialValueController.text) ?? 0;
                final step = int.tryParse(incrementByController.text) ?? 1;

                if (name.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Enter a counter name')),
                  );
                  return;
                }

                Navigator.pop(context, {
                  'name': name,
                  'initial': initial,
                  'step': step,
                });
              },
              icon: const Icon(Icons.check),
              label: const Text('Create Counter'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

