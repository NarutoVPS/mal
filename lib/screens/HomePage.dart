import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/anime_detail_provider.dart';
import '../models/anime_title.dart';
import '../widgets/anime_tile.dart';
import 'anime_detail_screen.dart';
import 'package:mal/widgets/nav_menu.dart';
import 'package:mal/widgets/app_drawer.dart';
import 'package:mal/widgets/homepage_skeleton.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool _isloading;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Provider.of<AnimeDetailProvider>(context, listen: false)
        .fetchUpcomingTitles();

    _isloading = true;
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isloading = false;
      });
    });

    super.initState();
  }

  void onTitleClick(id) {
    Provider.of<AnimeDetailProvider>(context, listen: false)
        .updateCurrentSelectedTitle(id);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AnimeDetailScreen(
            id: Provider.of<AnimeDetailProvider>(context, listen: false)
                .currentSelectedTitle)));
  }

  @override
  Widget build(BuildContext context) {
    List<AnimeTitle> upComingAnimes =
        Provider.of<AnimeDetailProvider>(context).upComingTitles;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff2e51a2),
        title: const Text(
          'MAL',
          style: TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          icon: const Icon(Icons.account_circle),
        ),
      ),
      drawer: const AppDrawer(),
      body: Container(
        margin: const EdgeInsets.only(top: 8.0),
        child: Column(
          children: [
            Expanded(
              child: _isloading
                  ? ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, i) {
                        return const HomePageSkeleton();
                      })
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: upComingAnimes.length,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () => onTitleClick(upComingAnimes[i].id),
                          child: AnimeTile(
                              upComingAnimes[i].title,
                              upComingAnimes[i].imgUrl,
                              upComingAnimes[i].members,
                              upComingAnimes[i].startDate),
                        );
                      },
                      separatorBuilder: (context, i) {
                        return const Divider(
                          height: 1,
                        );
                      },
                    ),
            ),
            const NavMenu(),
          ],
        ),
      ),
    );
  }
}
