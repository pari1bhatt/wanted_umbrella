import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:wanted_umbrella/utils/utils.dart';

import '../../models/selection_model.dart';
import '../../routes.dart';
import '../../utils/constants.dart';

class TrainPup extends StatelessWidget {
  TrainPup({Key? key}) : super(key: key);

  final List<SelectionModel> items = [
    SelectionModel(text: 'Guide Dogs', text2: 'https://youtu.be/SgKKZXuiTac', image: GetImages.guide_dogs),
    SelectionModel(text: 'How to Train your Puppy 6 Tricks', text2: 'https://youtu.be/PS8sTLqKfA8', image: GetImages.train_tricks),
    SelectionModel(text: 'How to Teach your Puppy to Sit and Stay', text2: 'https://youtu.be/DPNz6reMVXY', image: GetImages.sit_stay),
    SelectionModel(text: 'How to Potty Train your Puppy EASILY', text2: 'https://youtu.be/7vOXWCewEYM', image: GetImages.potty_train),
    SelectionModel(text: 'The 5 Most Common Potty Training Mistakes', text2: 'https://youtu.be/FQpsakJonsU', image: GetImages.potty_mistakes),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Train your pup"),
      ),
      body: Container(
        color: GetColors.black,
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return listItem(index,context);
            }),
      ),
    );
  }
  listItem(index,context) {
    return GestureDetector(
      onTap: () => onVideoPress(context,items[index].text2),
      child: Container(
        color: GetColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 12),
        margin: const EdgeInsets.only(bottom: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 150,
              // color: GetColors.grey.withOpacity(0.3),
              child: Image.asset(items[index].image ?? GetImages.event1),
            ),
            const SizedBox(height: 5),
            Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: GetColors.purple.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  items[index].text ?? '',
                  style: const TextStyle(color: GetColors.white),
                )),
            // const Divider(thickness: 2,color: GetColors.black),
          ],
        ),
      ),
    );
  }

  onVideoPress (context,String? url){
    AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.scale,
      dismissOnTouchOutside: false,
      title: 'Please confirm',
      desc: 'Are you sure you want to watch video? If yes, then you will be redirect to Youtube',
      btnCancelOnPress: () => Navigator.popUntil(context, ModalRoute.withName(Routes.train_pup)),
      btnOkOnPress: () => Utils.openUrl(url),
    ).show();
  }
}
