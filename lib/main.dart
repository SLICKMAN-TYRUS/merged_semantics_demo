import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MergedSemantics Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyWidgetDemo(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyWidgetDemo extends StatefulWidget {
  const MyWidgetDemo({super.key});

  @override
  State<MyWidgetDemo> createState() => _MyWidgetDemoState();
}

class _MyWidgetDemoState extends State<MyWidgetDemo> {
  // We'll use this state to toggle merging on and off for comparison
  bool _isMerged = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MergedSemantics Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Scenario: Compare how screen readers interpret this card with and without merging.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            
            // Toggle Switch
            Row(
              children: [
                const Text('Enable MergedSemantics: '),
                Switch(
                  value: _isMerged,
                  onChanged: (value) {
                    setState(() {
                      _isMerged = value;
                    });
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // The Demo Widget
            Center(
              child: _isMerged 
                  ? MergeSemantics(
                      child: _buildComplexCard(),
                    )
                  : _buildComplexCard(),
            ),
            
            const SizedBox(height: 40),
            
            const Text(
              'Attributes Demonstrated:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            _buildAttributeItem('1. child', 'The widget tree to be merged into a single semantic node.'),
            _buildAttributeItem('2. Semantics.label (in child)', 'Individual text labels are concatenated.'),
            _buildAttributeItem('3. Semantics.button (in child)', 'Interactive elements make the whole node clickable.'),
          ],
        ),
      ),
    );
  }

  Widget _buildAttributeItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(description),
        ],
      ),
    );
  }

  Widget _buildComplexCard() {
    return Semantics(
      container: true,
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.blue[50], // Light blue background
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blueAccent),
        ),
        child: Row(
          children: [
            const Icon(Icons.music_note, size: 40, color: Colors.blue),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Bohemian Rhapsody',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Queen',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            // We use Semantics here to explicitly label the action
            Semantics(
              label: 'Play',
              button: true,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Playing song...')),
                );
              },
              child: IconButton(
                icon: const Icon(Icons.play_arrow),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Playing song...')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}