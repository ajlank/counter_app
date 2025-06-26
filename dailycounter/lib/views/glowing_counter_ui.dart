import 'package:flutter/material.dart';

class GlowingCounterUI extends StatefulWidget {
  final String title;
  final int startValue;
  final int incrementBy;

  const GlowingCounterUI({
    super.key,
    required this.title,
    required this.startValue,
    required this.incrementBy,
  });

  @override
  State<GlowingCounterUI> createState() => _GlowingCounterUIState();
}

class _GlowingCounterUIState extends State<GlowingCounterUI> {
  late int _counter;

  @override
  void initState() {
    super.initState();
    _counter = widget.startValue;
  }

  void _increment() {
    setState(() => _counter += widget.incrementBy);
  }
  void _decrement(){
    setState(() {
      _counter-=1;
    });
  }
  void _reset() {
    setState(() => _counter = widget.startValue);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 24),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color.fromRGBO(103, 58, 183, 0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Text(
              '$_counter',
              style: const TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildGlassButton(Icons.remove, _decrement),
              _buildGlassButton(Icons.refresh, _reset),
              _buildGlassButton(Icons.add, _increment),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGlassButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.deepPurple.shade100, width: 2),
          boxShadow: [
            BoxShadow(
              color: const Color.fromRGBO(103, 58, 183, 0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Icon(
          icon,
          size: 30,
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}
