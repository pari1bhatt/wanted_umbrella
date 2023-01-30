import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:wanted_umbrella/utils/constants.dart';
import 'package:wanted_umbrella/utils/utils.dart';

import '../../models/user_model.dart';
import '../../routes.dart';
import '../../utils/prefs.dart';
import '../dashboard_provider.dart';

class FindAMate extends StatefulWidget {
  const FindAMate({Key? key}) : super(key: key);

  @override
  State<FindAMate> createState() => _FindAMateState();
}

class _FindAMateState extends State<FindAMate> {
  late Size size;
  late DashboardProvider provider;
  int page = 0;

  // String? selectedBreed = 'pug';
  // String? chooseDogGenderValue = 'Female';
  String? selectedBreed;
  String? chooseDogGenderValue;
  List<SwipeItem> swipeItems = [];
  MatchEngine? matchEngine;
  UserModel? visibleUserModel;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<DashboardProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Breeding"),
      ),
      body: getBody(),
    );
  }

  getBody() {
    switch (page) {
      case 0:
        return SmireTest();
      case 1:
        return ProjectionTest();
      case 2:
        return chooseDog();
      case 3:
        return requestWidget();
    }
  }

  onNext() async {
    if (page == 2) {
      if (selectedBreed?.isEmpty ?? true) {
        Utils.showSnackBar(context, 'Enter breed');
      } else if (chooseDogGenderValue?.isEmpty ?? true) {
        Utils.showSnackBar(context, 'Select gender');
      } else {
        onFilter();
      }
    } else {
      setState(() => page++);
    }
  }

  SmireTest() {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(border: Border.all(width: 1)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(15),
              child: Text("Smear Test", style: TextStyle(fontSize: 20, color: GetColors.black)),
            ),
            const Divider(thickness: 1, color: GetColors.black, height: 0),
            const SizedBox(height: 20),
            const Text("Has your dog gone through smear test?",
                style: TextStyle(fontSize: 16, color: GetColors.black)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: onNext,
                  style: TextButton.styleFrom(backgroundColor: GetColors.purple),
                  child: const Text("Yes", style: TextStyle(color: GetColors.white)),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.popUntil(context, ModalRoute.withName(Routes.dashboard)),
                  style: TextButton.styleFrom(backgroundColor: GetColors.purple),
                  child: const Text("No", style: TextStyle(color: GetColors.white)),
                )
              ],
            ),
            TextButton(
              onPressed: onNext,
              style: TextButton.styleFrom(backgroundColor: GetColors.grey),
              child: const Text("Not Required", style: TextStyle(color: GetColors.white)),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  ProjectionTest() {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(border: Border.all(width: 1)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(15),
              child:
                  Text("Projection Test", style: TextStyle(fontSize: 20, color: GetColors.black)),
            ),
            const Divider(thickness: 1, color: GetColors.black, height: 0),
            const SizedBox(height: 20),
            const Text("Has your dog gone through projection test?",
                style: TextStyle(fontSize: 16, color: GetColors.black)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: onNext,
                  style: TextButton.styleFrom(backgroundColor: GetColors.purple),
                  child: const Text("Yes", style: TextStyle(color: GetColors.white)),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.popUntil(context, ModalRoute.withName(Routes.dashboard)),
                  style: TextButton.styleFrom(backgroundColor: GetColors.purple),
                  child: const Text("No", style: TextStyle(color: GetColors.white)),
                )
              ],
            ),
            TextButton(
              onPressed: onNext,
              style: TextButton.styleFrom(backgroundColor: GetColors.grey),
              child: const Text("Not Required", style: const TextStyle(color: GetColors.white)),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  chooseDog() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Expanded(flex: 7, child: Text("Choose your dog breed")),
                Expanded(
                    flex: 3,
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      onChanged: (value) {
                        selectedBreed = value;
                      },
                      decoration: const InputDecoration(hintText: 'Breed', isDense: true),
                    ))
              ],
            ),
            Row(
              children: [
                const Expanded(flex: 7, child: const Text("Choose the gender preference")),
                Expanded(
                    flex: 3,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: chooseDogGenderValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          chooseDogGenderValue = newValue;
                        });
                      },
                      items:
                          <String>['Male', 'Female'].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ))
              ],
            ),
            TextButton(
              onPressed: onNext,
              style: TextButton.styleFrom(backgroundColor: GetColors.purple),
              child: const Text("Continue", style: const TextStyle(color: GetColors.white)),
            )
          ],
        ),
      ),
    );
  }

  requestWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.65,
              child: SwipeCards(
                matchEngine: matchEngine!,
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
                              swipeItems[index].content.dog_images.first ?? 'empty',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                            color: Colors.black26),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        swipeItems[index].content.dog_name + ' ',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        softWrap: false,
                                        style: const TextStyle(
                                            color: GetColors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        swipeItems[index].content.breed,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        softWrap: false,
                                        style: const TextStyle(
                                            color: GetColors.white, fontSize: 15),
                                      ),
                                      Spacer(),
                                      Icon(
                                        swipeItems[index].content.gender == 'Male' ? Icons.male : Icons.female,
                                        color: Colors.white,
                                        size: 26,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Row(
                                  children: List.generate(
                                      swipeItems[index].content.personalities?.length ?? 0,
                                      (i) => Row(
                                            children: [
                                              Chip(
                                                padding: EdgeInsets.zero,
                                                label: Text(swipeItems[index]
                                                    .content
                                                    .personalities![i]),
                                              ),
                                              const SizedBox(width: 5)
                                            ],
                                          )),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
                onStackFinished: () {
                  Utils.showSnackBar(context, "Stack Finished");
                },
                itemChanged: (SwipeItem item, int index) {
                  visibleUserModel = item.content;
                  // print("item: ${item.content.dog_name}, index: $index");
                },
                // upSwipeAllowed: true,
                fillSpace: true,
              ),
              // Image.network('https://placeimg.com/640/450/any'),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                const Text("Rs. 3000/-"),
                TextButton(
                  onPressed: onRequest,
                  style: TextButton.styleFrom(
                      backgroundColor: GetColors.purple, padding: const EdgeInsets.all(12)),
                  child: const Text("Request to book", style: TextStyle(color: GetColors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  onRequest(){
    if(visibleUserModel?.gender == 'Female'){
      provider.sendBreedingRequest(visibleUserModel,context);
    } else
    Navigator.pushNamed(context, Routes.gift_payment, arguments: visibleUserModel);
  }

  onFilter() async {
    var value = await FirebaseFirestore.instance
        .collection("users")
        .where('breed', isEqualTo: selectedBreed)
        .where('gender', isEqualTo: chooseDogGenderValue)
        .where('email', isNotEqualTo: Prefs.getUserEmail())
        .get();
    if (value.docs.isNotEmpty) {
      List<UserModel> userModel = [];
      swipeItems = [];
      for (var document in value.docs) {
        var users = UserModel.fromJson(document.data());
        users.id = document.id;
        userModel.add(users);
        swipeItems.add(SwipeItem(content: users));
      }
      visibleUserModel = swipeItems[0].content;
      matchEngine = MatchEngine(swipeItems: swipeItems);
      setState(() => page++);
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.scale,
        title: 'Error',
        desc: 'No matching dog found please go back to Find a mate.',
        btnCancel: null,
        btnOkOnPress: () => Navigator.popUntil(context, ModalRoute.withName(Routes.find_a_mate)),
      ).show();
    }
  }
}
