import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/sequencer_provider.dart';

class SequencerPage extends StatefulWidget {
  const SequencerPage({Key? key}) : super(key: key);

  @override
  State<SequencerPage> createState() => _SequencerPageState();
}

class _SequencerPageState extends State<SequencerPage> {
  late TextEditingController _bpmController;

  @override
  void initState() {
    super.initState();
    _bpmController = TextEditingController(
      text: context.read<SequencerProvider>().currentBPM.toString(),
    );
  }

  @override
  void dispose() {
    _bpmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sequencer'),
        elevation: 0,
      ),
      body: Consumer<SequencerProvider>(
        builder: (context, sequencerProvider, _) {
          return Column(
            children: [
              // BPM Control
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _bpmController,
                        decoration: const InputDecoration(
                          labelText: 'BPM',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            sequencerProvider.setBPM(int.parse(value));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // Tracks List
              Expanded(
                child: sequencerProvider.tracks.isEmpty
                    ? const Center(
                        child: Text('No tracks added yet'),
                      )
                    : ListView.builder(
                        itemCount: sequencerProvider.tracks.length,
                        itemBuilder: (context, index) {
                          final track = sequencerProvider.tracks[index];
                          return ListTile(
                            title: Text(track.name),
                            subtitle: Text(track.filePath),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () =>
                                  sequencerProvider.removeTrack(track.id),
                            ),
                          );
                        },
                      ),
              ),
              // Playback Controls
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                      onPressed: sequencerProvider.isPlaying
                          ? null
                          : () => sequencerProvider.playSequence(),
                      child: const Icon(Icons.play_arrow),
                    ),
                    FloatingActionButton(
                      onPressed: sequencerProvider.isPlaying
                          ? () => sequencerProvider.stopSequence()
                          : null,
                      backgroundColor: Colors.red,
                      child: const Icon(Icons.stop),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
