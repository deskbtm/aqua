import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:pure_video_player/pure_video_player.dart';
import 'package:pure_video_player/src/helpers/responsive.dart';
import 'package:pure_video_player/src/helpers/utils.dart';
import 'package:pure_video_player/src/widgets/fullscreen_button.dart';
import 'package:pure_video_player/src/widgets/mute_sound_button.dart';
import 'package:pure_video_player/src/widgets/pip_button.dart';
import 'package:pure_video_player/src/widgets/play_pause_button.dart';
import 'package:pure_video_player/src/widgets/player_slider.dart';

class SecondaryBottomControls extends StatelessWidget {
  final Responsive responsive;
  const SecondaryBottomControls({Key? key, required this.responsive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _ = PurePlayerController.of(context);
    final fontSize = responsive.ip(2);
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: fontSize > 17 ? 17 : fontSize,
    );

    final tmp = responsive.ip(8);
    final buttonsSize = tmp < 45.0 ? tmp : 45.0;

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Transform.translate(
            offset: Offset(0, 4),
            child: PlayerSlider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(width: 5),
                  PlayPauseButton(
                    size: buttonsSize,
                  ),
                  SizedBox(width: 5),
                  Obx(
                    () {
                      String text = "";
                      if (_.duration.inMinutes >= 60) {
                        // if the duration is >= 1 hour
                        text =
                            "${printDurationWithHours(_.position)} / ${printDurationWithHours(_.duration)}";
                      } else {
                        text =
                            "${printDuration(_.position)} / ${printDuration(_.duration)}";
                      }
                      return Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Text(
                          text,
                          style: textStyle,
                        ),
                      );
                    },
                  ),
                  // PlayerButton(
                  //   onPressed: _.rewind,
                  //   size: buttonsSize,
                  //   iconColor: Colors.white,
                  //   backgrounColor: Colors.transparent,
                  //   iconPath: 'assets/icons/rewind.png',
                  // ),
                  // PlayerButton(
                  //   onPressed: _.fastForward,
                  //   iconColor: Colors.white,
                  //   backgrounColor: Colors.transparent,
                  //   size: buttonsSize,
                  //   iconPath: 'assets/icons/fast-forward.png',
                  // ),
                  SizedBox(width: 5),
                ],
              ),
              Row(
                children: [
                  if (_.bottomRight != null) ...[
                    _.bottomRight!,
                    SizedBox(width: 10)
                  ],
                  if (_.enabledButtons.pip) PipButton(responsive: responsive),
                  if (_.enabledButtons.muteAndSound)
                    MuteSoundButton(responsive: responsive),
                  if (_.enabledButtons.fullscreen) ...[
                    FullscreenButton(
                      size: buttonsSize,
                    ),
                    SizedBox(width: 5),
                  ],
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
