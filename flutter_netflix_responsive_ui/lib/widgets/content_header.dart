import 'package:flutter/material.dart';
import 'package:flutter_netflix_responsive_ui/models/content_model.dart';
import 'package:flutter_netflix_responsive_ui/widgets/vertical_icon_button.dart';
import 'package:flutter_netflix_responsive_ui/widgets/widgets.dart';
import 'package:video_player/video_player.dart';

class ContentHeader extends StatelessWidget {
  final Content featuredContent;

  const ContentHeader({Key key, this.featuredContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: ContentHeaderMobile(featuredContent: featuredContent),
        desktop: ContentHeaderDeskTop(featuredContent: featuredContent));
  }
}

class ContentHeaderDeskTop extends StatefulWidget {
  final Content featuredContent;

  const ContentHeaderDeskTop({Key key, this.featuredContent}) : super(key: key);

  @override
  _ContentHeaderDeskTopState createState() => _ContentHeaderDeskTopState();
}

class _ContentHeaderDeskTopState extends State<ContentHeaderDeskTop> {
  VideoPlayerController _videoPlayerController;
  bool _isMuted = true;

  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.network(widget.featuredContent.videoUrl)
          ..initialize().then((_) => setState(() {}))
          ..setVolume(0)
          ..play();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _videoPlayerController.value.isPlaying
          ? _videoPlayerController.pause()
          : _videoPlayerController.play(),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          AspectRatio(
            aspectRatio: _videoPlayerController.value.initialized
                ? _videoPlayerController.value.aspectRatio
                : 2.344,
            child: _videoPlayerController.value.initialized
                ? VideoPlayer(_videoPlayerController)
                : Image.asset(
                    widget.featuredContent.imageUrl,
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned(
            bottom: -1.0,
            left: 0,
            right: 0,
            child: AspectRatio(
              aspectRatio: _videoPlayerController.value.initialized
                  ? _videoPlayerController.value.aspectRatio
                  : 2.344,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 60.0,
            right: 60.0,
            bottom: 50.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 250.0,
                  child: Image.asset(widget.featuredContent.titleImageUrl),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  widget.featuredContent.description,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(2.0, 4.0),
                          blurRadius: 6.0),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    _PlayButton(),
                    const SizedBox(
                      width: 16,
                    ),
                    FlatButton.icon(
                      padding:
                          const EdgeInsets.fromLTRB(25.0, 10.0, 30.0, 10.0),
                      color: Colors.white,
                      onPressed: () => print("More İnfo"),
                      icon: const Icon(
                        Icons.info_outline,
                        size: 30,
                      ),
                      label: const Text(
                        "More Info",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    if (_videoPlayerController.value.initialized)
                      IconButton(
                        icon:
                            Icon(_isMuted ? Icons.volume_off : Icons.volume_up),
                        color: Colors.white,
                        iconSize: 30,
                        onPressed: () => setState(() {
                          _isMuted
                              ? _videoPlayerController.setVolume(100)
                              : _videoPlayerController.setVolume(0);
                          _isMuted = _videoPlayerController.value.volume == 0;
                        }),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ContentHeaderMobile extends StatelessWidget {
  final Content featuredContent;

  const ContentHeaderMobile({Key key, this.featuredContent}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 500.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(featuredContent.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 500.0,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        Positioned(
          bottom: 110.0,
          child: SizedBox(
            width: 250.0,
            child: Image.asset(featuredContent.titleImageUrl),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              VerticalIconButton(
                icon: Icons.add,
                title: "List",
                onTap: () => print("My List"),
              ),
              _PlayButton(),
              VerticalIconButton(
                icon: Icons.info_outline,
                title: "İnfo",
                onTap: () => print("info"),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _PlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      padding: !Responsive.isDesktop(context)
          ? const EdgeInsets.fromLTRB(15.0, 5.0, 20.0, 5.0)
          : const EdgeInsets.fromLTRB(25.0, 10.0, 30.0, 10.0),
      onPressed: () => print("play"),
      color: Colors.white,
      icon: const Icon(
        Icons.play_arrow,
        size: 30.0,
      ),
      label: const Text(
        "Play",
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
      ),
    );
  }
}
