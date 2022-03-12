import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'audio_control_event.dart';
part 'audio_control_state.dart';


class AudioControlBloc extends Bloc<AudioControlEvent, AudioControlState> {
  AudioControlBloc() : super(const AudioControlState()) {
    on<AudioToggled>((event, emit) {
      emit(AudioControlState(muted: !state.muted));
    });
  }
}
