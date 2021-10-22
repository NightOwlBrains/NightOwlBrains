import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:catch_the_monkey/Utils/assets.dart';
// import 'package:catch_the_monkey/Utils/assets.dart';

class MusicService {
  static MusicService? _selfInstance;

  MusicService._internal();

  factory MusicService() {
    if (_selfInstance == null) {
      _selfInstance = MusicService._internal();
    }
    return _selfInstance!;
  }

  AudioCache? _bgMusicCache;
  AudioPlayer? _bgInstance;
  AudioCache? _monkeyMusicCache;
  AudioPlayer? _monkeyInstance;
  AudioCache? _gameOverMusicCache;
  AudioPlayer? _gameOverInstance;
  Timer? _timer;

  // stopBackgroundMusic() {
  //   _bgInstance?.pause();
  // }

  playGameOverMusic() async {
    stopAllAudio();
    _gameOverMusicCache = AudioCache(prefix: Assets.prefix);
    _gameOverInstance = await _gameOverMusicCache?.play(Assets.gameOverMusic);
  }

  // stopGameOverInstance() {
  //   _gameOverInstance?.pause();
  // }

  playMonkeyMusic() async {
    // _timer = Timer.periodic(Duration(seconds: 5), (timer) async {
    //   _monkeyMusicCache = AudioCache(prefix: Assets.prefix);
    //   _monkeyInstance = await _monkeyMusicCache?.play(Assets.monkeyLaughMusic);
    // });
    stopAllAudio();
    _monkeyMusicCache = AudioCache(prefix: Assets.prefix);
    _monkeyInstance = await _monkeyMusicCache?.loop(Assets.monkeyLaughMusic);
  }

  // stopMonkeyMusic() {
  //   _timer?.cancel();
  //   _monkeyInstance?.pause();
  // }

  stopAllAudio() {
    _timer?.cancel();
    _gameOverInstance?.stop();
    _gameOverInstance = null;
    _bgInstance?.stop();
    _bgInstance = null;
    _monkeyInstance?.stop();
    _monkeyInstance = null;
  }
}
