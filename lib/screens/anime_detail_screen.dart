import 'package:flutter/material.dart';
import 'package:mal/models/app_state_provider.dart';
import 'package:mal/utils/colors.dart';
import 'package:mal/widgets/anime_detail_screen_skeleton.dart';
import 'package:mal/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:share_plus/share_plus.dart';

import 'package:mal/widgets/additional_info.dart';
import 'package:mal/widgets/character_staffs.dart';
import '../models/anime_detail_provider.dart';
import '../models/anime_details_model.dart';

class AnimeDetailScreen extends StatefulWidget {
  final int id;
  final bool updateData;
  const AnimeDetailScreen({
    this.id = 0,
    this.updateData = false,
    Key? key,
  }) : super(key: key);

  @override
  State<AnimeDetailScreen> createState() => _AnimeDetailScreenState();
}

class _AnimeDetailScreenState extends State<AnimeDetailScreen> {
  late bool _isLoading;
  AnimeDetails details = AnimeDetails();
  @override
  void initState() {
    if (widget.updateData) {
      Provider.of<AnimeDetailProvider>(context, listen: false)
          .updateCurrentSelectedTitle(widget.id);
    }
    _isLoading = true;
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    details = Provider.of<AnimeDetailProvider>(context).animeDetails;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MAL',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor:
            Provider.of<AppStateProvider>(context).themeMode == 'LIGHT'
                ? HEADER_LIGHT
                : HEADER_DARK,
        actions: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.favorite_border_outlined,
              size: 27,
            ),
          ),
          GestureDetector(
            onTap: () async {
              await Share.share(
                  'Yo check this anime \nhttps://myanimelist.net/anime/${widget.id}');
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.share,
                size: 27,
              ),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const AnimeDetailScreenSkeleton()
          : SingleChildScrollView(
              child: Container(
                color:
                    Provider.of<AppStateProvider>(context).themeMode == 'LIGHT'
                        ? BACKGROUND_LIGHT
                        : BACKGROUND_DARK,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 325,
                      child: Stack(
                        children: [
                          Container(
                            height: 100,
                            color: Provider.of<AppStateProvider>(context)
                                        .themeMode ==
                                    'LIGHT'
                                ? HEADER_LIGHT
                                : HEADER_DARK,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(12.0),
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black45),
                                    color: Colors.white),
                                child: Image.network(
                                  details.imgUrl,
                                  height: 300,
                                  width: 200,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        const Text(
                                          'Score',
                                          style:
                                              TextStyle(color: Colors.white70),
                                        ),
                                        Text(
                                          '⭐ ' + details.score.toString(),
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        const CustomText('Rank', 14),
                                        Text(
                                          '#' + details.rank.toString(),
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        const CustomText('Popularity', 14),
                                        Text(
                                          '#' + details.popularity.toString(),
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        const CustomText('Members', 14),
                                        Text(
                                          details.members.toString(),
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        const CustomText('Favourites', 14),
                                        Text(
                                          details.favourites.toString(),
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(
                        child: Text(
                          details.title,
                          style: TextStyle(
                              color: Provider.of<AppStateProvider>(context)
                                          .themeMode ==
                                      'LIGHT'
                                  ? TEXT_LIGHT
                                  : TEXT_DARK,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      color: Colors.black12,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomText(details.type, 14),
                          CustomText(details.status, 14),
                          CustomText(details.duration, 14),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ExpandableText(
                        details.synopsis,
                        expandText: 'Show More',
                        collapseText: 'Show Less',
                        maxLines: 4,
                        animation: true,
                        animationDuration: const Duration(seconds: 1),
                        linkColor: Theme.of(context).primaryColor,
                        style: TextStyle(
                          color: Provider.of<AppStateProvider>(context)
                                      .themeMode ==
                                  'LIGHT'
                              ? TEXT_LIGHT
                              : TEXT_DARK,
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(12.0),
                    //   child: Trailer(),
                    // ),
                    const AdditionalInfo(),
                    const CharacterStaffs(),
                    details.openingThemes.length > 10
                        ? const Padding(
                            padding: EdgeInsets.only(left: 12.0),
                            child: CustomText('Opening Theme', 16),
                          )
                        : Container(),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                        right: 12,
                        bottom: 12,
                      ),
                      child: ExpandableText(
                        details.openingThemes,
                        expandText: 'Show More',
                        collapseText: 'Show Less',
                        maxLines: 7,
                        animation: true,
                        animationDuration: const Duration(seconds: 1),
                        linkColor: Theme.of(context).primaryColor,
                        style: TextStyle(
                          color: Provider.of<AppStateProvider>(context)
                                      .themeMode ==
                                  'LIGHT'
                              ? TEXT_LIGHT
                              : TEXT_DARK,
                        ),
                      ),
                    ),
                    details.openingThemes.length > 10
                        ? const Padding(
                            padding: EdgeInsets.only(left: 12.0),
                            child: CustomText('Ending Theme', 16),
                          )
                        : Container(),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 30.0,
                        right: 12.0,
                      ),
                      child: ExpandableText(
                        details.endingThemes,
                        expandText: 'Show More',
                        collapseText: 'Show Less',
                        maxLines: 7,
                        animation: true,
                        animationDuration: const Duration(seconds: 1),
                        linkColor: Theme.of(context).primaryColor,
                        style: TextStyle(
                          color: Provider.of<AppStateProvider>(context)
                                      .themeMode ==
                                  'LIGHT'
                              ? TEXT_LIGHT
                              : TEXT_DARK,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
