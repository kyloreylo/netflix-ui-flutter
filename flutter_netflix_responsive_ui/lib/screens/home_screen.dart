import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_netflix_responsive_ui/cubits/appbar/app_bar_cubit.dart';

import 'package:flutter_netflix_responsive_ui/data/data.dart';

import 'package:flutter_netflix_responsive_ui/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        context.bloc<AppBarCubit>().setOffset(_scrollController.offset);
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 50.0),
        child: BlocBuilder<AppBarCubit, double>(
          builder: (context, scrolloffset) {
            return CustomAppBar(
              scrollOffSet: scrolloffset,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[850],
        child: const Icon(Icons.cast),
        onPressed: () {
          print("cast");
        },
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
              child: ContentHeader(featuredContent: sintelContent)),
          SliverPadding(
            padding: const EdgeInsets.only(top: 20),
            sliver: SliverToBoxAdapter(
              child: Previews(
                title: "Preveiews",
                contentList: previews,
                key: PageStorageKey("previews"),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ContentList(
              title: "My List",
              contentList: myList,
              key: PageStorageKey("myList"),
            ),
          ),
          SliverToBoxAdapter(
            child: ContentList(
                key: PageStorageKey("netflixOriginals"),
                title: "Netflix Originals",
                contentList: originals,
                isOriginals: true),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 20),
            sliver: SliverToBoxAdapter(
              child: ContentList(
                title: "Trending",
                contentList: trending,
                key: PageStorageKey("trending"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
