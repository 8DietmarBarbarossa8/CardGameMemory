import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  static final audioPlayer = AudioPlayer();

  static Future playAudio(String mp3) async {
    await audioPlayer.play(AssetSource('audio/$mp3.mp3'));
  }
}