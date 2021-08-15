import 'package:flutter/material.dart';
import 'package:flutter_netflix_responsive_ui/assets.dart';
import 'package:flutter_netflix_responsive_ui/widgets/widgets.dart';

class CustomAppBar extends StatelessWidget {
  final double scrollOffSet;

  const CustomAppBar({Key key, this.scrollOffSet = 0.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
        color: Colors.black
            .withOpacity((scrollOffSet / 350).clamp(0, 1).toDouble()),
        child: Responsive(
          mobile: CustomAppBarMobile(),
          desktop: CustomAppBarDesktop(),
        ));
  }
}

class CustomAppBarMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Image.asset(Assets.netflixLogo0),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _AppBarButton(
                    title: "TV Shows", onTap: () => print("Tv Shows")),
                _AppBarButton(title: "Movies", onTap: () => print("Movies")),
                _AppBarButton(title: "My List", onTap: () => print("My List")),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomAppBarDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Image.asset(Assets.netflixLogo1),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _AppBarButton(title: "Home", onTap: () => print("Home")),
                _AppBarButton(
                    title: "TV Shows", onTap: () => print("Tv Shows")),
                _AppBarButton(title: "Movies", onTap: () => print("Movies")),
                _AppBarButton(title: "Latest", onTap: () => print("Latest")),
                _AppBarButton(title: "My List", onTap: () => print("My List")),
              ],
            ),
          ),
          const Spacer(),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => print("searcg"),
                  icon: Icon(Icons.search),
                  iconSize: 28,
                  color: Colors.white,
                ),
                _AppBarButton(title: "KIDS", onTap: () => print("KIDS")),
                _AppBarButton(title: "DVD", onTap: () => print("DVD")),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => print("giftcard"),
                  icon: Icon(Icons.card_giftcard),
                  iconSize: 28,
                  color: Colors.white,
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => print("notifications"),
                  icon: Icon(Icons.notifications),
                  iconSize: 28,
                  color: Colors.white,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _AppBarButton extends StatelessWidget {
  final String title;
  final Function onTap;

  const _AppBarButton({Key key, this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w600),
      ),
    );
  }
}
