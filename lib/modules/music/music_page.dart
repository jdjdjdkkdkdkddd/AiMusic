import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../themes/theme_color.dart';
import '../../themes/theme_size.dart';
import '../explore/models/play_list_detail/track.dart';
import 'bloc/music_page_bloc.dart';

class MusicPage extends StatelessWidget {
  static const String _tag = "MusicPage";
  const MusicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBgColor,
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return _buildMainContent(context);
  }

  _buildMainContent(BuildContext context) {
    BlocConsumer<MusicPageBloc, MusicPageState>(
      listener: (context, state) {},
      buildWhen: (previous, current) => current is AddPlayListSuccess,
      builder: (context, state) {
        return Stack(
          children: [
            _buildMusicListWidget(context),
            Column(
              children: [
                _buildStatusBar(context),
                _buildActionBar(context),
              ],
            )
          ],
        );
      },
    );
  }

  _buildMusicListWidget(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        final tracks = context.read<MusicPageBloc>().tracks;
        final track = tracks[index];
        return _buildMusicInfoItemWidget(context, index, track);
      },
    );
  }

  Container _buildMusicInfoItemWidget(BuildContext context, int index, Track track) {
    final colors = [Colors.amber, Colors.blue, Colors.green, Colors.purple, Colors.red];
    return Container(
      color: colors[index % colors.length],
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          _buildMusicPicWidget(context, track.al?.picUrl),
          const SizedBox(
            height: 40,
          ),
          _buildMusicLyricWidget(context),
          const Spacer(),
          _buildMusicControlWidget(context),
          SizedBox(
            height: defaultBottomNavigationBarHeight,
          )
        ],
      ),
    );
  }

  Padding _buildMusicPicWidget(BuildContext context, String? picUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        height: MediaQuery.of(context).size.width - 60,
        decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(picUrl ?? ""), fit: BoxFit.cover),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
      ),
    );
  }

  _buildMusicLyricWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        'And I don\'t want to miss a thing, I will never miss a thing',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  _buildMusicControlWidget(BuildContext context) {
    const iconSize = 35.0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "You're Beautiful",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "James Blunt",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: [
              Icon(Icons.favorite_sharp, size: iconSize),
              SizedBox(
                width: 20,
              ),
              Icon(Icons.message, size: iconSize),
              SizedBox(
                width: 20,
              ),
              Icon(Icons.share, size: iconSize),
              Spacer(),
              Icon(Icons.thumb_up, size: iconSize - 10),
              SizedBox(
                width: 20,
              ),
              Icon(Icons.more_vert, size: iconSize - 10),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "0:00",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Expanded(
                child: SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: Colors.white,
                    inactiveTrackColor: Colors.white.withOpacity(0.3),
                    thumbColor: Colors.white,
                    trackHeight: 2.0,
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 6.0,
                    ),
                  ),
                  child: Slider(
                    value: 0.0,
                    min: 0.0,
                    max: 100.0,
                    onChanged: (value) {
                      // TODO: 处理进度条拖动
                    },
                  ),
                ),
              ),
              Text(
                "3:45",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  _buildStatusBar(BuildContext context) {
    return SizedBox(height: defaultStatusBarHeight.toDouble());
  }

  _buildActionBar(BuildContext context) {
    const iconSize = 25.0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: defaultActionBarHeight.toDouble(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.menu, size: iconSize)),
            Text(
              "模式选择",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Spacer(),
            const Icon(Icons.search, size: iconSize),
          ],
        ),
      ),
    );
  }
}
