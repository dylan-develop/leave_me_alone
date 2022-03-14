import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:leave_me_alone/bloc/audio_control/audio_control_bloc.dart';
import 'package:leave_me_alone/components/responsive_layout_builder.dart';

class AudioControl extends StatelessWidget {
  const AudioControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioMuted = context.select((AudioControlBloc bloc) => bloc.state.muted);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          context.read<AudioControlBloc>().add(AudioToggled());
        },
        child: ResponsiveLayoutBuilder(
            small: (context, child) => child,
            large: (context, child) => child,
            child: (size) {
              final iconWidth = size == ResponsiveLayoutSize.large ? 32.0 : 24.0;

              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: SvgPicture.asset(
                  'assets/icons/volume-${audioMuted ? 'x' : '1'}.svg',
                  key: ValueKey(audioMuted),
                  width: iconWidth,
                ),
              );
            }),
      ),
    );
  }
}
