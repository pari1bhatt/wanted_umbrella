import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wanted_umbrella/utils/constants.dart';

import '../../models/user_model.dart';
import '../../routes.dart';

class ExploreDetailsPage extends StatelessWidget {
  final UserModel? userModel;

  const ExploreDetailsPage({Key? key, this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("check data: ${userModel?.toJson()}");
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Card(
                    shadowColor: Colors.deepPurpleAccent,
                    elevation: 16,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image.network(
                          userModel?.dog_images?.first ?? GetImages.placeholderNetwork,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(24)), color: Colors.black12),
                  ),
                  SafeArea(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () =>
                            Navigator.popUntil(context, ModalRoute.withName(Routes.dashboard)),
                        child: Container(
                          width: 50,
                          height: 50,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              color: Colors.white24),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 72,
                            margin: const EdgeInsets.fromLTRB(8, 0, 8, 8.0),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(24.0),
                                bottomRight: Radius.circular(24.0),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(24.0),
                                bottomRight: Radius.circular(24.0),
                              ),
                              // Clip it cleanly.
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                  color: Colors.grey.withOpacity(0.1),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        margin: const EdgeInsets.all(24.0),
                                        child: const Text(
                                          'It can be a match !',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                      // Container(
                                      //   margin: const EdgeInsets.fromLTRB(0, 0, 24, 0),
                                      //   child: Padding(
                                      //     padding: const EdgeInsets.all(0.0),
                                      //     child: ElevatedButton.icon(
                                      //       onPressed: () {},
                                      //       icon: const Icon(
                                      //         Icons.mark_chat_read_rounded,
                                      //         color: Colors.white,
                                      //       ),
                                      //       label: const Text(
                                      //         "Say Hi",
                                      //         style: TextStyle(
                                      //           color: Colors.white,
                                      //           fontSize: 16.0,
                                      //           overflow: TextOverflow.ellipsis,
                                      //           fontWeight: FontWeight.bold,
                                      //         ),
                                      //       ),
                                      //       style: ElevatedButton.styleFrom(
                                      //         padding: const EdgeInsets.all(12.0),
                                      //         shape: RoundedRectangleBorder(
                                      //           borderRadius: BorderRadius.circular(16.0),
                                      //         ),
                                      //         elevation: 8.0,
                                      //         shadowColor: Colors.white,
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(0.0),
                          child: Text(
                            '${userModel?.dog_name}, ${userModel?.age}',
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(0),
                          child: Text(
                            '${userModel?.breed}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              overflow: TextOverflow.ellipsis,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              userModel?.personalities?.length ?? 0,
                              (i) => Row(
                                children: [
                                  Chip(
                                    padding: EdgeInsets.zero,
                                    label: Text(userModel?.personalities?[i] ?? ''),
                                  ),
                                  const SizedBox(width: 5)
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 15),
                  Container(
                    height: 36,
                    width: 48,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: 16),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(24.0)), color: Colors.black38),
                    child: Icon(
                      userModel?.gender == 'Male' ? Icons.male : Icons.female,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 4, 24, 0),
              child: Card(
                color: Colors.white,
                shadowColor: Colors.deepPurple[300],
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.all(16),
                      child: Text(userModel?.bio ?? '',
                          style: const TextStyle(
                              color: Colors.black54, fontSize: 14, fontWeight: FontWeight.normal),
                          textAlign: TextAlign.start,
                          maxLines: 4,
                          overflow: TextOverflow.fade),
                    ),
                    const Divider(height: 1, color: Colors.grey),
                    Container(
                      margin: const EdgeInsets.fromLTRB(24, 10, 0, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Icon(
                            Icons.email,
                            color: Colors.deepPurple,
                          ),
                          Text(
                            userModel?.email ?? '',
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 12.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: <Widget>[
                    //     Container(
                    //       margin: const EdgeInsets.fromLTRB(24, 12, 0, 12),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         children: <Widget>[
                    //           const Icon(
                    //             Icons.phone,
                    //             color: Colors.deepPurple,
                    //           ),
                    //           Text(
                    //             'widget.phone',
                    //             style: const TextStyle(
                    //               color: Colors.black54,
                    //               fontSize: 12.0,
                    //             ),
                    //             textAlign: TextAlign.center,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     Container(
                    //       margin: const EdgeInsets.fromLTRB(0, 12, 24, 12),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         children: <Widget>[
                    //           const Icon(Icons.email_rounded, color: Colors.deepPurple),
                    //           Text(
                    //             'widget.email',
                    //             style: const TextStyle(
                    //                 color: Colors.black54,
                    //                 overflow: TextOverflow.fade,
                    //                 fontSize: 12),
                    //             overflow: TextOverflow.fade,
                    //             textAlign: TextAlign.center,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       Container(
            //         decoration: const BoxDecoration(
            //           color: Colors.white,
            //           shape: BoxShape.circle,
            //           boxShadow: [
            //             BoxShadow(
            //                 blurRadius: 10,
            //                 color: Colors.black,
            //                 spreadRadius: 2)
            //           ],
            //         ),
            //         child: CircleAvatar(
            //           backgroundColor: Colors.white,
            //           child: IconButton(
            //             icon: const Icon(
            //               Icons.thumb_down_alt_rounded,
            //               color: Colors.red,
            //             ),
            //             onPressed: () {
            //               // _matchEngine!.currentItem?.nope();
            //             },
            //             // child: const Text("Nope"),
            //           ),
            //         ),
            //       ),
            //       Container(
            //         decoration: const BoxDecoration(
            //           color: Colors.white,
            //           shape: BoxShape.circle,
            //           boxShadow: [
            //             BoxShadow(
            //                 blurRadius: 10,
            //                 color: Colors.black,
            //                 spreadRadius: 2)
            //           ],
            //         ),
            //         child: CircleAvatar(
            //           radius: 36.0,
            //           backgroundColor: Colors.white,
            //           child: CircleAvatar(
            //             radius: 32.0,
            //             backgroundColor: Colors.deepPurple,
            //             child: Center(
            //               child: IconButton(
            //                 icon: const Icon(
            //                   Icons.favorite,
            //                   color: Colors.white,
            //                   size: 36.0,
            //                 ),
            //                 onPressed: () {
            //                   //  _matchEngine!.currentItem?.superLike();
            //                 },
            //                 //child: const Text("Superlike"),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //       Container(
            //         decoration: const BoxDecoration(
            //           color: Colors.white,
            //           shape: BoxShape.circle,
            //           boxShadow: [
            //             BoxShadow(
            //                 blurRadius: 10,
            //                 color: Colors.black,
            //                 spreadRadius: 2)
            //           ],
            //         ),
            //         child: CircleAvatar(
            //           backgroundColor: Colors.white,
            //           child: IconButton(
            //             icon: const Icon(
            //               Icons.thumb_up_alt_rounded,
            //               color: Colors.red,
            //             ),
            //             onPressed: () {
            //               //_matchEngine!.currentItem?.like();
            //             },
            //             //  child: const Text("Like"),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
