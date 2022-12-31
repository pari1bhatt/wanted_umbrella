import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:wanted_umbrella/pages/dashboard_provider.dart';
import 'package:wanted_umbrella/utils/constants.dart';

import '../../models/dog_data.dart';
import '../../utils/utils.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  late DashboardProvider provider;

  bool isStackFinished = false;

  late Size size;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    provider = Provider.of<DashboardProvider>(context);
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        decoration: const BoxDecoration(
          color: Colors.blue,
          gradient: LinearGradient(
              colors: [Color(0xFFCC3DE5), Color(0xFF933DC8), Color(0xFF1647BF)],
              begin: FractionalOffset(0, 0),
              end: FractionalOffset(0.5, 1.2)),
        ),
        child: provider.isExploreLoading
            ? const Center(child: CircularProgressIndicator(color: GetColors.white))
            : isStackFinished || provider.matchEngine?.currentItem == null
                ? const Center(child: Text("No data found"))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Center(
                        child: SizedBox(
                            height: size.height -
                                (size.width * .32 + MediaQuery.of(context).padding.top),
                            child: swipeCards(provider)),
                      ),
                      likeDislikeButtons()
                    ],
                  ),
      ),
    );
  }

  swipeCards(DashboardProvider bloc) {
    return SwipeCards(
      matchEngine: bloc.matchEngine!,
      itemBuilder: (BuildContext context, int index) {
        return Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Card(
              margin: const EdgeInsets.all(15),
              shadowColor: Colors.deepPurple,
              elevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    bloc.exploreData[index].dog_images?.first ??
                        'https://dummyimage.com/300x300/fff/aaa',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(24)), color: Colors.black26),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 80,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    color: Colors.white24),
                margin: const EdgeInsets.fromLTRB(24, 40, 24, 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${bloc.exploreData[index].name}  ',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: const TextStyle(
                                      color: GetColors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${bloc.exploreData[index].breed}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: const TextStyle(color: GetColors.white, fontSize: 15),
                                )
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          child: Row(
                            children: List.generate(
                                bloc.exploreData[index].personalities?.length ?? 0,
                                (i) => Row(
                                      children: [
                                        Chip(
                                          padding: EdgeInsets.zero,
                                          label: Text(bloc.exploreData[index].personalities![i]),
                                        ),
                                        const SizedBox(width: 5)
                                      ],
                                    )),
                          ),
                        ),
                      ],
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8),
                    //   child: ElevatedButton.icon(
                    //     onPressed: () {},
                    //     icon: const Icon(
                    //       Icons.directions_sharp,
                    //       color: Colors.white,
                    //     ),
                    //     label: const Text(
                    //       "Profile",
                    //       style: TextStyle(
                    //         color: Colors.white,
                    //         fontSize: 14,
                    //         overflow: TextOverflow.ellipsis,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //     style: ElevatedButton.styleFrom(
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(30),
                    //       ),
                    //       elevation: 8,
                    //       shadowColor: Colors.deepPurple,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
      onStackFinished: () {
        Utils.showSnackBar(context, "Stack Finished");
        setState(() {
          isStackFinished = true;
        });
      },
      itemChanged: (SwipeItem item, int index) {
        print("item: ${item.content.text}, index: $index");
      },
      // upSwipeAllowed: true,
      fillSpace: true,
    );
  }

  likeDislikeButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black, spreadRadius: 2)],
          ),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.red,
              ),
              onPressed: () {
                provider.matchEngine?.currentItem?.nope();
              },
              // child: const Text("Nope"),
            ),
          ),
        ),
        // Container(
        //   decoration: const BoxDecoration(
        //     color: Colors.white,
        //     shape: BoxShape.circle,
        //     boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black, spreadRadius: 2)],
        //   ),
        //   child: CircleAvatar(
        //     radius: 30,
        //     backgroundColor: Colors.white,
        //     child: CircleAvatar(
        //       radius: 28,
        //       backgroundColor: Colors.deepPurple,
        //       child: Center(
        //         child: IconButton(
        //           icon: const Icon(
        //             Icons.info_outline,
        //             color: Colors.white,
        //             size: 30,
        //           ),
        //           onPressed: () {
        //             _matchEngine.currentItem?.superLike();
        //           },
        //           //child: const Text("Superlike"),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black, spreadRadius: 2)],
          ),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              onPressed: () {
                provider.matchEngine?.currentItem?.like();
              },
              //  child: const Text("Like"),
            ),
          ),
        )
      ],
    );
  }
}
