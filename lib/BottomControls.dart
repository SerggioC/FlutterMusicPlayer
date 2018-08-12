import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttermusicplayer/main.dart';
import 'package:fluttermusicplayer/theme.dart';

class BottomControls extends StatelessWidget {
  const BottomControls({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Material(
        shadowColor: const Color(0x44000000),
        color: accentColor,
        child: Padding(
          padding: EdgeInsets.only(
              bottom: 50.0, left: 8.0, right: 8.0, top: 40.0),
          child: Column(
            children: <Widget>[
              RichText(
                text: TextSpan(text: '', children: [
                  TextSpan(
                    text: 'Song Title\n',
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
                    text: 'Artist Name',
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
                    new PreviousButton(),

                    Expanded(child: Container()),

                    //Play Pause Button
                    new PlayPauseButton(),

                    Expanded(child: Container()),

                    // Next Button
                    new NextButton(),

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