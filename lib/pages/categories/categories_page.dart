import 'package:flutter/material.dart';
import 'package:wanted_umbrella/routes.dart';
import 'package:wanted_umbrella/utils/constants.dart';

import '../../models/selection_model.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final List<SelectionModel> categories = [
    SelectionModel(text: 'Find a mate',image: GetImages.find_a_mate),
    SelectionModel(text: 'Notifications',image: GetImages.notifications),
    SelectionModel(text: 'Adopt a dog',image: GetImages.adopt_a_dog),
    SelectionModel(text: 'Maps',image: GetImages.maps),
    SelectionModel(text: 'Chatbot',image: GetImages.chatbot),
    SelectionModel(text: 'Gift your loved ones',image: GetImages.gift_your_loved_ones),
    SelectionModel(text: 'dog articles and shows',image: GetImages.dog_articles_and_events),
    SelectionModel(text: 'Train your pup',image: GetImages.train_your_pup),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text("Categories", style: TextStyle(fontSize: 20, color: GetColors.white)),
        ),
        Expanded(
          child: GridView.builder(
              itemCount: categories.length,
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.3, crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 12),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => onTapCategories(index),
                  child: Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.bottomCenter,
                    children: [
                      Card(
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
                              categories[index].image ?? GetImages.dog1,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 15,
                        child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(color: GetColors.purple.withOpacity(0.8),borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              categories[index].text ?? '',
                              style: const TextStyle(color: GetColors.white),
                            )),
                      ),
                    ],
                  ),
                );
              }),
        )
      ],
    );
  }

  void onTapCategories(index){
    switch(index){
      case 0:
        Navigator.pushNamed(context, Routes.find_a_mate);
        break;
      case 1:
        Navigator.pushNamed(context, Routes.notification);
        break;
      case 2:
        Navigator.pushNamed(context, Routes.adopt_a_dog);
        break;
      case 3:
        Navigator.pushNamed(context, Routes.maps);
        break;
      case 4:
        Navigator.pushNamed(context, Routes.chat_bot);
        break;
      case 5:
        Navigator.pushNamed(context, Routes.gift);
        break;
      case 6:
        Navigator.pushNamed(context, Routes.articles_shows);
        break;
      case 7:
        Navigator.pushNamed(context, Routes.train_pup);
        break;
    }
  }
}
