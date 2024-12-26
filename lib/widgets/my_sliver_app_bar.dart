import 'package:flutter/material.dart';

import 'package:movie_app/utils/placeholder.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MySliverAppBar extends StatelessWidget {
  const MySliverAppBar({
    super.key,
    required this.data,
    this.errorMessage,
  });

  final List<String> data;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final videoId = data.isNotEmpty ? data.first : null;

    return SliverAppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: Colors.transparent,
      pinned: true,
      expandedHeight: 250,
      collapsedHeight: 250,
      floating: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(vertical: 0),
        title: videoId == null
            ? Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: buildShimmerPlaceholder(
                    width: MediaQuery.sizeOf(context).width, height: 250),
              )
            : data.isEmpty
                ? Text(errorMessage ?? 'No video available')
                : Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Container(
                      color: Colors.transparent,
                      height: 250,
                      child: YoutubePlayer(
                        progressColors: const ProgressBarColors(
                            handleColor: Colors.green,
                            playedColor: Colors.green),
                        showVideoProgressIndicator: true,
                        controlsTimeOut: const Duration(seconds: 5),
                        controller: YoutubePlayerController(
                          initialVideoId: videoId,
                          flags: const YoutubePlayerFlags(
                            autoPlay: true,
                            loop: false,
                            isLive: false,
                            forceHD: false,
                            enableCaption: false,
                            controlsVisibleAtStart: true,
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
