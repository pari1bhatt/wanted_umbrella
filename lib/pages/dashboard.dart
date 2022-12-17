import 'package:flutter/material.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:wanted_umbrella/utils/constants.dart';

class Content {
  final String? text;
  final Color? color;

  Content({this.text, this.color});
}

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<IconData> listOfIcons = [
    Icons.handshake,
    Icons.message,
    Icons.category,
    Icons.person,
  ];
  int currentIndex = 0;
  late Size size;


  List<SwipeItem> _swipeItems = [];
  late MatchEngine _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<String> _names = ["Red", "Blue", "Green", "Yellow", "Orange"];
  List<Color> _colors = [Colors.red, Colors.blue, Colors.green, Colors.yellow, Colors.orange];

  @override
  void initState() {
    for (int i = 0; i < _names.length; i++) {
      _swipeItems.add(SwipeItem(
          content: Content(text: _names[i], color: _colors[i]),
          likeAction: () {
            _scaffoldKey.currentState?.showSnackBar(SnackBar(
              content: Text("Liked ${_names[i]}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          nopeAction: () {
            _scaffoldKey.currentState?.showSnackBar(SnackBar(
              content: Text("Nope ${_names[i]}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          superlikeAction: () {
            _scaffoldKey.currentState?.showSnackBar(SnackBar(
              content: Text("Superliked ${_names[i]}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          onSlideUpdate: (SlideRegion? region) async {
            print("Region $region");
          }));
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.blue,
          gradient: LinearGradient(
              colors: [Color(0xFF1647BF), Color(0xFFCC3DE5), Color(0xFF933DC8)],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(0.5, 2)),
        ),
        child: getBody(),
      ),
      bottomNavigationBar: Container(
        height: size.width * .155,
        decoration: BoxDecoration(
          color: GetColors.white,
          boxShadow: [
            BoxShadow(color: GetColors.black.withOpacity(.15), blurRadius: 30, offset: const Offset(0, 10)),
          ],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(36)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
              4,
              (index) => InkWell(
                    onTap: () {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    splashColor: GetColors.transparent,
                    highlightColor: GetColors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 1500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          margin: EdgeInsets.only(
                            bottom: index == currentIndex ? 0 : size.width * .029,
                            right: size.width * .0422,
                            left: size.width * .0422,
                          ),
                          width: size.width * .128,
                          height: index == currentIndex ? size.width * .014 : 0,
                          decoration: const BoxDecoration(
                            color: GetColors.purple,
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(10),
                            ),
                          ),
                        ),
                        Icon(
                          listOfIcons[index],
                          size: size.width * .076,
                          color: index == currentIndex ? GetColors.purple : GetColors.grey,
                        ),
                        SizedBox(height: size.width * .03),
                      ],
                    ),
                  )),
        ),
      ),
    );
  }

  getBody() {
    double calculateHeight = size.height - (size.width * .4) - MediaQuery.of(context).padding.top;
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
                      height: calculateHeight,
                      child: SwipeCards(
                        matchEngine: _matchEngine,
                        itemBuilder: (BuildContext context, int index) {
                          return Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              Card(
                                margin: const EdgeInsets.all(16.0),
                                shadowColor: Colors.deepPurple,
                                elevation: 12.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(24.0),
                                    child: Image.asset(
                                      GetImages.done,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(20.0),
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(24.0)), color: Colors.black26),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  // alignment: Alignment.bottomCenter,
                                  height: 72.0,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(24.0),
                                        bottomRight: Radius.circular(24.0),
                                      ),
                                      color: Colors.white24),
                                  margin: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 24.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: const <Widget>[
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.all(4.0),
                                              child: Text(
                                                "something",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                softWrap: false,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 26,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.all(4.0),
                                              child: Text(
                                                "location",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                softWrap: false,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
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
                                              fontSize: 14.0,
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(30.0),
                                            ),
                                            elevation: 8.0,
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
                          _scaffoldKey.currentState!.showSnackBar(const SnackBar(
                            content: Text("Stack Finished"),
                            duration: Duration(milliseconds: 500),
                          ));
                        },
                        itemChanged: (SwipeItem item, int index) {
                          print("item: ${item.content.text}, index: $index");
                        },
                        upSwipeAllowed: true,
                        fillSpace: true,
                      ),
                    ),
                  ),
                  Row(
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
                              Icons.thumb_down_alt_rounded,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              _matchEngine.currentItem?.nope();
                            },
                            // child: const Text("Nope"),
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black, spreadRadius: 2)],
                        ),
                        child: CircleAvatar(
                          radius: 36.0,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 32.0,
                            backgroundColor: Colors.deepPurple,
                            child: Center(
                              child: IconButton(
                                icon: const Icon(
                                  Icons.info_outline,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: () {
                                  _matchEngine.currentItem?.superLike();
                                },
                                //child: const Text("Superlike"),
                              ),
                            ),
                          ),
                        ),
                      ),
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
                              Icons.thumb_up_alt_rounded,
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
                  ),
                ],
              ),
          ),
    );
  }
}
