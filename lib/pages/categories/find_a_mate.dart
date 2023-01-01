import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:wanted_umbrella/utils/constants.dart';

import '../../routes.dart';

class FindAMate extends StatefulWidget {
  const FindAMate({Key? key}) : super(key: key);

  @override
  State<FindAMate> createState() => _FindAMateState();
}

class _FindAMateState extends State<FindAMate> {
  late Size size;
  int page = 0;

  String? chooseDogGenderValue;

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
        return request();
    }
  }

  onNext() {
    setState(() {
      page++;
    });
  }

  SmireTest() {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(border: Border.all(width: 1)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(15),
              child: Text("Smire Test", style: TextStyle(fontSize: 20, color: GetColors.black)),
            ),
            const Divider(thickness: 1, color: GetColors.black, height: 0),
            const SizedBox(height: 10),
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
                  onPressed: onNext,
                  style: TextButton.styleFrom(backgroundColor: GetColors.purple),
                  child: Text("No", style: TextStyle(color: GetColors.white)),
                )
              ],
            ),
            TextButton(
              onPressed: onNext,
              style: TextButton.styleFrom(backgroundColor: GetColors.grey),
              child: Text("Not Required", style: TextStyle(color: GetColors.white)),
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
        margin: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(border: Border.all(width: 1)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(15),
              child: Text("Projection Test", style: TextStyle(fontSize: 20, color: GetColors.black)),
            ),
            const Divider(thickness: 1, color: GetColors.black, height: 0),
            const SizedBox(height: 10),
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
                  onPressed: onNext,
                  style: TextButton.styleFrom(backgroundColor: GetColors.purple),
                  child: Text("No", style: TextStyle(color: GetColors.white)),
                )
              ],
            ),
            TextButton(
              onPressed: onNext,
              style: TextButton.styleFrom(backgroundColor: GetColors.grey),
              child: Text("Not Required", style: TextStyle(color: GetColors.white)),
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
                Expanded(flex: 7, child: Text("Choose your dog breed")),
                Expanded(
                    flex: 3,
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      onChanged: (value) {
                        // onBoardingProvider.regName = value;
                      },
                      decoration: const InputDecoration(hintText: 'Breed', isDense: true),
                    ))
              ],
            ),
            Row(
              children: [
                Expanded(flex: 7, child: Text("Choose the gender preference")),
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
                      items: <String>['Male', 'Female'].map<DropdownMenuItem<String>>((String value) {
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
              child: Text("Continue", style: TextStyle(color: GetColors.white)),
            )
          ],
        ),
      ),
    );
  }

  request() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.6,
              child: Card(
                shadowColor: Colors.deepPurple,
                elevation: 12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      GetImages.dog2_1,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              // Image.network('https://placeimg.com/640/450/any'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: onRequest,
              style: TextButton.styleFrom(backgroundColor: GetColors.purple, padding: EdgeInsets.all(12)),
              child: Text("Request to book", style: TextStyle(color: GetColors.white)),
            ),
          ],
        ),
      ),
    );
  }

  onRequest(){
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.scale,
      dismissOnTouchOutside: false,
      title: 'Success',
      desc: 'Breeding request sent!',
      btnCancel: null,
      btnOkOnPress: () => Navigator.popUntil(context, ModalRoute.withName(Routes.dashboard)),
    ).show();
  }
}
