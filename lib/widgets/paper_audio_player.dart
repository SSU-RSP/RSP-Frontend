// Description: 논문 오디오 플레이어 위젯
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import '../../models/paper_item.dart';

class PaperAudioPlayer extends StatefulWidget {
  final PaperItem paper;

  const PaperAudioPlayer({super.key, required this.paper});

  @override
  State<PaperAudioPlayer> createState() => _PaperAudioPlayerState();
}

class _PaperAudioPlayerState extends State<PaperAudioPlayer> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initAudio();
  }

  Future<void> _initAudio() async {
    try {
      // 오디오 세션 설정
      final session = await AudioSession.instance;
      await session.configure(const AudioSessionConfiguration(
        avAudioSessionCategory: AVAudioSessionCategory.playback,
        avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.none,
        avAudioSessionMode: AVAudioSessionMode.defaultMode,
        avAudioSessionRouteSharingPolicy: AVAudioSessionRouteSharingPolicy.defaultPolicy,
        avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
        androidAudioAttributes: AndroidAudioAttributes(
          contentType: AndroidAudioContentType.music,
          flags: AndroidAudioFlags.none,
          usage: AndroidAudioUsage.media,
        ),
        androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
        androidWillPauseWhenDucked: false,
      ));

      // assets의 오디오 파일 로드
      await _audioPlayer.setAsset('assets/padcasts.m4a');
      
      // 오디오 길이 가져오기
      _audioPlayer.durationStream.listen((duration) {
        if (duration != null) {
          setState(() {
            _duration = duration;
          });
        }
      });

      // 현재 재생 위치 가져오기
      _audioPlayer.positionStream.listen((position) {
        setState(() {
          _position = position;
        });
      });

      // 재생 상태 감지
      _audioPlayer.playerStateStream.listen((state) {
        setState(() {
          _isPlaying = state.playing;
        });
      });

      // 재생 완료 시 처음으로 돌아가기
      _audioPlayer.processingStateStream.listen((state) {
        if (state == ProcessingState.completed) {
          _audioPlayer.seek(Duration.zero);
          _audioPlayer.pause();
        }
      });
    } catch (e) {
      debugPrint('오디오 로드 실패: $e');
      // 에러 발생 시 사용자에게 알림
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('오디오 로드 실패: $e')),
        );
      }
    }
  }

  void _togglePlayPause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play();
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _showPodcastScript(BuildContext context, String script) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 핸들 바
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // 제목
              Row(
                children: const [
                  Icon(Icons.mic, color: Color(0xFF6593FF)),
                  SizedBox(width: 8),
                  Text(
                    "팟캐스트 스크립트",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Divider(height: 24),

              // 스크립트 내용
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Text(
                    script,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 20),

        // 논문 아이콘
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(
            Icons.description,
            color: Colors.white,
            size: 42,
          ),
        ),
        const SizedBox(height: 10),

        // 논문 제목
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            widget.paper.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 4),

        // 저자/컨퍼런스
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "${widget.paper.conference} ${widget.paper.year}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 12),

        // 재생 시간 표시
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDuration(_position),
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                ),
              ),
              Text(
                _formatDuration(_duration),
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),

        // 진행 바
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5),
              trackHeight: 2.5,
            ),
            child: Slider(
              value: _position.inSeconds.toDouble(),
              max: _duration.inSeconds.toDouble() > 0 
                  ? _duration.inSeconds.toDouble() 
                  : 1.0,
              onChanged: (value) {
                _audioPlayer.seek(Duration(seconds: value.toInt()));
              },
              activeColor: Colors.white,
              inactiveColor: Colors.white30,
            ),
          ),
        ),
        const SizedBox(height: 6),

        // 재생/일시정지 버튼
        ElevatedButton(
          onPressed: _togglePlayPause,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(16),
            backgroundColor: Colors.white,
            shadowColor: Colors.black26,
            elevation: 6,
          ),
          child: Icon(
            _isPlaying ? Icons.pause : Icons.play_arrow,
            color: const Color(0xFF6593FF),
            size: 28,
          ),
        ),
        const SizedBox(height: 6),

        // 스크립트 보기 버튼
        TextButton.icon(
          onPressed: () {
            if (widget.paper.podcastScript != null) {
              _showPodcastScript(context, widget.paper.podcastScript!);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("팟캐스트 스크립트가 없습니다.")),
              );
            }
          },
          icon: const Icon(Icons.description, color: Colors.white70, size: 16),
          label: const Text(
            "스크립트 보기",
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
