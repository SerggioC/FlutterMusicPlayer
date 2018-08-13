import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttermusicplayer/theme.dart';
import 'package:fluttery_audio/fluttery_audio.dart';
import 'package:fluttery_audio/src/_audio_player_widgets.dart';

class BottomControls extends StatelessWidget {
  const BottomControls({
    Key key,
    this.songName,
    this.artistName,
    this.listSize,
  }) : super(key: key);

  final String songName;
  final String artistName;
  final int listSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Material(
        shadowColor: const Color(0x44000000),
        color: accentColor,
        child: Padding(
          padding: EdgeInsets.only(bottom: 50.0, left: 8.0, right: 8.0, top: 40.0),
          child: Column(
            children: <Widget>[
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(text: '', children: [
                  TextSpan(
                    text: '$songName\n',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4.0,
                      height: 1.5,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  TextSpan(
                    text: artistName,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.75),
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3.0,
                      height: 1.5,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Row(
                  children: <Widget>[
                    Expanded(child: Container()),

                    //Previous Button
                    PreviousButton(
                      listSize: listSize,
                    ),

                    Expanded(child: Container()),

                    //Play Pause Button
                    PlayPauseButton(),

                    Expanded(child: Container()),

                    // Next Button
                    NextButton(
                      listSize: listSize,
                    ),

                    Expanded(child: Container()),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PlayPauseButton extends StatelessWidget {
  const PlayPauseButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AudioComponent(
      updateMe: [
        WatchableAudioProperties.audioPlayerState,
      ],
      playerBuilder: (BuildContext context, AudioPlayer player, Widget child) {
        IconData icon = Icons.music_note;
        Color buttonColor = darkAccentColor;
        Function onPressed;

        if (player.state == AudioPlayerState.playing) {
          icon = Icons.pause;
          buttonColor = Colors.white;
          onPressed = player.pause;
        } else if (player.state == AudioPlayerState.paused ||
            player.state == AudioPlayerState.idle ||
            player.state == AudioPlayerState.completed ||
            player.state == AudioPlayerState.stopped) {
          icon = Icons.play_arrow;
          buttonColor = Colors.white;
          onPressed = player.play;
        } else if (player.state == AudioPlayerState.loading) {
          icon = Icons.music_note;
        }

        return new RawMaterialButton(
            shape: CircleBorder(),
            fillColor: buttonColor,
            splashColor: lightAccentColor,
            elevation: 10.0,
            highlightElevation: 5.0,
            highlightColor: lightAccentColor.withOpacity(0.5),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                icon,
                color: lightAccentColor,
                size: 35.0,
              ),
            ),
            onPressed: onPressed);
      },
    );
  }
}

class PreviousButton extends StatelessWidget {
  const PreviousButton({
    Key key,
    this.listSize,
  }) : super(key: key);

  final int listSize;

  @override
  Widget build(BuildContext context) {
    return AudioPlaylistComponent(
      playlistBuilder: (BuildContext context, Playlist playlist, Widget child) {
        return IconButton(
            splashColor: lightAccentColor,
            highlightColor: Colors.transparent,
            icon: Icon(
              Icons.skip_previous,
              color: playlist.activeIndex > 0 ? Colors.white : Colors.grey,
              size: 35.0,
            ),
            onPressed: () {
              if (playlist.activeIndex >= 0) {
                playlist.previous();
              }
            });
      },
    );
  }
}

class NextButton extends StatelessWidget {
  const NextButton({
    Key key, this.listSize,
  }) : super(key: key);

  final int listSize;

  @override
  Widget build(BuildContext context) {
    return AudioPlaylistComponent(
        playlistBuilder: (BuildContext context, Playlist playlist, Widget child) {
      return IconButton(
          splashColor: lightAccentColor,
          highlightColor: Colors.transparent,
          icon: Icon(
            Icons.skip_next,
            color: playlist.activeIndex < listSize - 1 ? Colors.white : Colors.grey,
            size: 35.0,
          ),
          onPressed: () {
            if (playlist.activeIndex < listSize - 1) {
              playlist.next();
            }
          });
    });
  }
}
