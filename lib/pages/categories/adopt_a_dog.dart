import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:wanted_umbrella/routes.dart';
import 'package:wanted_umbrella/utils/constants.dart';

import '../../models/selection_model.dart';

class AdoptADog extends StatefulWidget {
  const AdoptADog({Key? key}) : super(key: key);

  @override
  State<AdoptADog> createState() => _AdoptADogState();
}

class _AdoptADogState extends State<AdoptADog> {
  List<SelectionModel> items = [
    SelectionModel(text: 'Bunty - Bulldog', text2: '12, Male', image: GetImages.dog4),
    SelectionModel(text: 'Joker - Husky', text2: '5, Female', image: GetImages.dog2_2),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Adopt a dog"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(colors: [
            Colors.grey[800]!,
            Colors.black,
          ], radius: 0.85, focal: Alignment.center),
        ),
        child: GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 0),
          itemCount: items.length + 8,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 1, mainAxisSpacing: 1),
          itemBuilder: (context, index) {
            if (index < items.length) {
              return gridItem(context, index);
            } else {
              return Container(color: GetColors.white);
            }
          },
        ),
      ),
    );
  }

  gridItem(context, index) {
    return Container(
      color: GetColors.white,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Container(
                  color: GetColors.grey.withOpacity(0.2), child: Image.asset(items[index].image!))),
          const SizedBox(height: 5),
          Text(items[index].text ?? '', style: TextStyle(fontSize: 12)),
          Text(items[index].text2 ?? '', style: TextStyle(fontSize: 12)),
          const SizedBox(height: 5),
          Center(
            child: InkWell(
              onTap: () => successDialog(context, index),
              child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: GetColors.purple.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    "book",
                    style: const TextStyle(color: GetColors.white),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  successDialog(context, index) {
    if (!items[index].isSelected) {

      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.scale,
        title: 'Thank you',
        desc: 'Dog adopted successfully!!',
        btnCancel: null,
        btnOkOnPress: () => Navigator.popUntil(context, ModalRoute.withName(Routes.adopt_a_dog)),
      ).show();
      setState(() {
        items.removeAt(index);
      });
    }
  }
}
