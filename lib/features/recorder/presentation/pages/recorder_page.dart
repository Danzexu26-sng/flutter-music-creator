import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../config/app_config.dart';
import '../providers/recorder_provider.dart';

class RecorderPage extends StatelessWidget {
  const RecorderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recorder'),
        centerTitle: true,
      ),
      body: Center(
        child: Consumer<RecorderProvider>(
          builder: (context, recorderProvider, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  recorderProvider.isRecording ? Icons.mic : Icons.mic_none,
                  size: 72,
                  color: recorderProvider.isRecording ? Colors.red : Colors.deepPurple,
                ),
                const SizedBox(height: 20),
                Text(
                  recorderProvider.isRecording ? 'Recording in progress...' : 'Ready to record',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 12),
                Text(
                  _formatDuration(recorderProvider.recordingDuration),
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 40),
                ElevatedButton.icon(
                  onPressed: recorderProvider.isRecording
                      ? () => _stopRecording(context)
                      : () => _startRecording(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: recorderProvider.isRecording ? Colors.red : Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                  icon: Icon(recorderProvider.isRecording ? Icons.stop : Icons.mic),
                  label: Text(recorderProvider.isRecording ? 'Stop Recording' : 'Start Recording'),
                ),
                const SizedBox(height: 20),
                if (recorderProvider.currentRecordingPath != null)
                  Text(
                    'Last file: ${recorderProvider.currentRecordingPath!}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _startRecording(BuildContext context) async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Microphone permission is required.')),
        );
      }
      return;
    }

    final provider = context.read<RecorderProvider>();
    await provider.startRecording();
  }

  Future<void> _stopRecording(BuildContext context) async {
    final path = await context.read<RecorderProvider>().stopRecording();
    if (path != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saved: $path')),
      );
    }
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
