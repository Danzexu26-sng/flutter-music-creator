import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/models/audio_track.dart';
import '../providers/sequencer_provider.dart';

class SequencerPage extends StatelessWidget {
  const SequencerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sequencer'),
        centerTitle: true,
      ),
      body: Consumer<SequencerProvider>(
        builder: (context, sequencerProvider, _) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text('BPM: '),
                    Expanded(
                      child: Slider(
                        value: sequencerProvider.currentBPM.toDouble(),
                        min: 60,
                        max: 180,
                        divisions: 120,
                        label: sequencerProvider.currentBPM.toString(),
                        onChanged: (value) {
                          sequencerProvider.setBPM(value.round());
                        },
                      ),
                    ),
                    Text(sequencerProvider.currentBPM.toString()),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: sequencerProvider.tracks.isEmpty ? null : () => sequencerProvider.playSequence(),
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Play'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: sequencerProvider.isPlaying ? () => sequencerProvider.stopSequence() : null,
                        icon: const Icon(Icons.stop),
                        label: const Text('Stop'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    final track = AudioTrack(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: 'Track ${sequencerProvider.tracks.length + 1}',
                      filePath: 'demo_track_${DateTime.now().millisecondsSinceEpoch}.m4a',
                      duration: const Duration(seconds: 8),
                    );

                    sequencerProvider.addTrack(track);
                  },
                  icon: const Icon(Icons.queue_music),
                  label: const Text('Add demo track'),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: sequencerProvider.tracks.isEmpty
                      ? const Center(child: Text('No tracks yet. Add a demo track to begin.'))
                      : ListView.builder(
                          itemCount: sequencerProvider.tracks.length,
                          itemBuilder: (context, index) {
                            final track = sequencerProvider.tracks[index];
                            return Card(
                              child: ListTile(
                                leading: const Icon(Icons.music_note),
                                title: Text(track.name),
                                subtitle: Text(track.filePath),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete_outline),
                                  onPressed: () => sequencerProvider.removeTrack(track.id),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
