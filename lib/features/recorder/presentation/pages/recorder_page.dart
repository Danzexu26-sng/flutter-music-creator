import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/recorder_provider.dart';

class RecorderPage extends StatelessWidget {
  const RecorderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recorder'),
        elevation: 0,
      ),
      body: Center(
        child: Consumer<RecorderProvider>(
          builder: (context, recorderProvider, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  recorderProvider.isRecording ? 'Recording...' : 'Ready to Record',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                Text(
                  _formatDuration(recorderProvider.recordingDuration),
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 40),
                FloatingActionButton.extended(
                  onPressed: recorderProvider.isRecording
                      ? () => _stopRecording(context)
                      : () => _startRecording(context),
                  label: Text(recorderProvider.isRecording ? 'Stop' : 'Start'),
                  icon: Icon(
                    recorderProvider.isRecording ? Icons.stop : Icons.mic,
                  ),
                  backgroundColor: recorderProvider.isRecording
                      ? Colors.red
                      : Colors.deepPurple,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _startRecording(BuildContext context) {
    context.read<RecorderProvider>().startRecording();
  }

  void _stopRecording(BuildContext context) {
    context.read<RecorderProvider>().stopRecording();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }
}
