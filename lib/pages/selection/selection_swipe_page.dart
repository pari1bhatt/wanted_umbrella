import 'package:flutter/material.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:wanted_umbrella/utils/constants.dart';

import '../../models/dog_data.dart';
import '../../utils/utils.dart';

class SelectionSwipePage extends StatefulWidget {
  const SelectionSwipePage({Key? key}) : super(key: key);

  @override
  State<SelectionSwipePage> createState() => _SelectionSwipePageState();
}

class _SelectionSwipePageState extends State<SelectionSwipePage> {
  late MatchEngine _matchEngine;
  List<DogData> dogData = [
    DogData(text: "Doggo", image: GetImages.dog1, breed: 'Corgi', age: '2', personalities: ['Calm', 'Happy']),
    DogData(text: "Bunty", image: GetImages.done2_1, breed: 'Husky', age: '5', personalities: ['Energetic', 'Happy']),
    DogData(text: "Rocky", image: GetImages.done2_2, breed: 'Husky', age: '2', personalities: ['Calm', 'Happy']),
    DogData(text: "Puppy", image: GetImages.done2_3, breed: 'Husky', age: '11', personalities: ['Calm']),
    DogData(text: "Boy", image: GetImages.done3, breed: 'Corgi', age: '8', personalities: ['Happy'])
  ];
  List<SwipeItem> swipeItems = [];
  bool isStackFinished = false;

  late Size size;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    swipeItems = [];
    for (int i = 0; i < dogData.length; i++) {
      swipeItems.add(SwipeItem(
          content: DogData(text: dogData[i].text),
          likeAction: () {
            Utils.showSnackBar(context, "Liked ${dogData[i].text}");
          },
          nopeAction: () {
            Utils.showSnackBar(context, "Nope ${dogData[i].text}");
          },
          superlikeAction: () {
            Utils.showSnackBar(context, "Superliked ${dogData[i].text}");
          },
          onSlideUpdate: (SlideRegion? region) async {
            print("Region $region");
          }));
    }
    _matchEngine = MatchEngine(swipeItems: swipeItems);
    isStackFinished = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Center(
      child: false
          ? const CircularProgressIndicator(color: GetColors.white)
          : Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Center(
                    child: SizedBox(
                        height: size.height - (size.width * .32 + MediaQuery.of(context).padding.top),
                        child: isStackFinished
                            ? Center(
                                child: TextButton(
                                    onPressed: loadData,
                                    child: const Text(
                                      "Reload",
                                      style: TextStyle(color: GetColors.white),
                                    )))
                            : swipeCards()),
                  ),
                  likeDislikeButtons()
                ],
              ),
            ),
    );
  }

  swipeCards() {
    return SwipeCards(
      matchEngine: _matchEngine,
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
                  child: Image.asset(
                    dogData[index].image ?? GetImages.done,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              decoration:
                  const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(24)), color: Colors.black26),
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
                                  '${dogData[index].text}  ',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: const TextStyle(
                                      color: GetColors.white, fontSize: 25, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${dogData[index].breed}',
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
                                dogData[index].personalities?.length ?? 0,
                                (i) => Row(
                                  children: [
                                    Chip(
                                          padding: EdgeInsets.zero,
                                          label: Text(dogData[index].personalities![i]),
                                        ),
                                    const SizedBox(width: 5)
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.directions_sharp,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "Profile",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 8,
                          shadowColor: Colors.deepPurple,
                        ),
                      ),
                    ),
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
                _matchEngine.currentItem?.nope();
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
                _matchEngine.currentItem?.like();
              },
              //  child: const Text("Like"),
            ),
          ),
        )
      ],
    );
  }
}
