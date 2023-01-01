import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/selection_model.dart';
import '../../routes.dart';
import '../../utils/constants.dart';
import '../dashboard_provider.dart';

class Gift extends StatefulWidget {
  const Gift({Key? key}) : super(key: key);

  @override
  State<Gift> createState() => _GiftState();
}

class _GiftState extends State<Gift> {
   final List<SelectionModel> items = [
    SelectionModel(text: 'Find a mate', text2: "Rs. 500/-", image: GetImages.flowers_gift),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Gift your loved ones"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart))],
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(items[index].text ?? ''),
              Text(items[index].text2 ?? ''),
            ],
          ),
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
                    items[index].isSelected ? "Added to cart" : "Add to cart",
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
        title: 'Success',
        desc: 'Item added to cart',
        btnCancel: null,
        btnOkOnPress: () => Navigator.popUntil(context, ModalRoute.withName(Routes.gift)),
      ).show();
      setState(() {
        items[index].isSelected = true;
      });
    }
  }
}
