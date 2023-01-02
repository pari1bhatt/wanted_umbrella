import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanted_umbrella/pages/dashboard_provider.dart';

import '../../models/selection_model.dart';
import '../../routes.dart';
import '../../utils/constants.dart';

class Gift extends StatefulWidget {
  const Gift({Key? key}) : super(key: key);

  @override
  State<Gift> createState() => _GiftState();
}

class _GiftState extends State<Gift> {
  late DashboardProvider provider;
  final List<SelectionModel> items = [
    SelectionModel(text: 'Find a mate', text2: "Rs. 500/-", image: GetImages.flowers_gift),
  ];

  @override
  void initState() {
    super.initState();
    provider = Provider.of<DashboardProvider>(context, listen: false);
    provider.cartItems = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Gift your loved ones"),
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, Routes.gift_cart),
              icon: const Icon(Icons.shopping_cart))
        ],
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
        provider.cartItems.add(items[index]);
        items[index].isSelected = true;
      });
    }
  }
}



class GiftCart extends StatelessWidget {
  const GiftCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, bloc, _) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("shopping cart"),
          actions: [
            IconButton(
                onPressed: () => Navigator.popUntil(context, ModalRoute.withName(Routes.gift)),
                icon: const Icon(Icons.add_shopping_cart_rounded, color: GetColors.red))
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: bloc.cartItems.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [itemList(bloc.cartItems[index]), const Divider(thickness: 1, color: GetColors.black)],
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: GetColors.purple),
                onPressed: bloc.cartItems.isEmpty ? null : () => onBuy(context),
                child: const Text('Buy', style: TextStyle(fontSize: 20, color: GetColors.white)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('Total', style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 20),
                  Text(bloc.cartItems.isEmpty ? 'Rs. 0/-' : 'Rs. 500/- ',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            const SizedBox(height: 20)
          ],
        ),
      );
    });
  }

  itemList(SelectionModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: [
          Container(height: 150, child: Image.asset(model.image ?? GetImages.flowers_gift)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [Text(model.text!), Text(model.text2!)],
          )
        ],
      ),
    );
  }

  onBuy(context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.scale,
      dismissOnTouchOutside: false,
      title: 'Thank you for shopping',
      desc: 'Your item priced Rs. 500/- will be delivered in 4 working days.',
      btnCancel: null,
      btnOkOnPress: () => Navigator.popUntil(context, ModalRoute.withName(Routes.dashboard)),
    ).show();
  }
}
