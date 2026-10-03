import 'package:flutter/material.dart';
import '../../../recorder/presentation/pages/recorder_page.dart';
import '../../../sequencer/presentation/pages/sequencer_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const RecorderPage(),
    const SequencerPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.mic),
            label: 'Recorder',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: 'Sequencer',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
