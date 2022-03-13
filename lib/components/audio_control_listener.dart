import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:leave_me_alone/bloc/audio_control/audio_control_bloc.dart';

class AudioControlListener extends StatefulWidget {
  final AudioPlayer? audioPlayer;
  final Widget child;

  const AudioControlListener({
    Key? key,
    required this.audioPlayer,
    required this.child,
  }) : super(key: key);

  @override
  State<AudioControlListener> createState() => _AudioControlListenerState();
}

class _AudioControlListenerState extends State<AudioControlListener> with WidgetsBindingObserver {
  void updateAudioPlayer({required bool muted}) {
    widget.audioPlayer?.setVolume(muted ? 0.0 : 1.0);
  }

  @override
  void initState() {
    updateAudioPlayer(muted: false);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    updateAudioPlayer(muted: context.read<AudioControlBloc>().state.muted);
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant AudioControlListener oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateAudioPlayer(muted: context.read<AudioControlBloc>().state.muted);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      widget.audioPlayer?.stop();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AudioControlBloc, AudioControlState>(
      listener: (context, state) => updateAudioPlayer(muted: state.muted),
      child: widget.child,
    );
  }
}
