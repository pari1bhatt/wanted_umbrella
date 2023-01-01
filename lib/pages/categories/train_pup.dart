import 'package:flutter/material.dart';

import '../../models/selection_model.dart';
import '../../utils/constants.dart';

class TrainPup extends StatelessWidget {
  TrainPup({Key? key}) : super(key: key);

  final List<SelectionModel> items = [
    SelectionModel(text: 'Holiday plants poisonous to dogs', image: GetImages.event1),
    SelectionModel(text: 'Average dog weight', image: GetImages.event2),
    SelectionModel(text: 'Car safety Tips', image: GetImages.event3),
    SelectionModel(text: 'How to adopt a dog', image: GetImages.event4),
    SelectionModel(text: 'Senior Dog Care', image: GetImages.event5),
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
              return listItem(index);
            }),
      ),
    );
  }
  listItem(index) {
    return Container(
      color: GetColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 12),
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 150,
            color: GetColors.grey.withOpacity(0.3),
            child: Image.asset(items[index].image ?? GetImages.event1,),
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
    );
  }


}
