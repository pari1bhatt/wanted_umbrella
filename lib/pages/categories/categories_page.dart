import 'package:flutter/material.dart';
import 'package:wanted_umbrella/routes.dart';
import 'package:wanted_umbrella/utils/constants.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<String> categories = [
    'Find a mate',
    'Notifications',
    'Adopt a dog',
    'Maps',
    'Chatbot',
    'Gift your loved ones',
    'dog articles and shows',
    'Train your pup'
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
                              GetImages.dog2_3,
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
                              categories[index],
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
        Navigator.pushNamed(context, Routes.find_a_mate);
        break;
      case 3:
        Navigator.pushNamed(context, Routes.find_a_mate);
        break;
      case 4:
        Navigator.pushNamed(context, Routes.chat_bot);
        break;
      case 5:
        Navigator.pushNamed(context, Routes.find_a_mate);
        break;
      case 6:
        Navigator.pushNamed(context, Routes.find_a_mate);
        break;
      case 7:
        Navigator.pushNamed(context, Routes.find_a_mate);
        break;
    }
  }
}
