import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wanted_umbrella/models/articles_model.dart';
import 'package:wanted_umbrella/utils/utils.dart';

import '../../models/selection_model.dart';
import '../../routes.dart';
import '../../utils/constants.dart';

class ArticlesShows extends StatefulWidget {
  ArticlesShows({Key? key}) : super(key: key);

  @override
  State<ArticlesShows> createState() => _ArticlesShowsState();
}

class _ArticlesShowsState extends State<ArticlesShows> {
  final List<SelectionModel> items = [
    SelectionModel(text: 'All Breed Championship', image: GetImages.event1),
    SelectionModel(text: 'Paw & Order', image: GetImages.event2),
    SelectionModel(text: 'Show Dogs', image: GetImages.event3),
    SelectionModel(text: 'The Flying Dog Show', image: GetImages.event4),
    SelectionModel(text: 'YOYO\'s Dog Boarding', image: GetImages.event5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Dog articles and shows"),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("articles").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              return Container(
                color: GetColors.black,
                child: ListView.builder(
                    itemCount: snapshot.data?.docs.length ?? 0,
                    itemBuilder: (context, index) {
                      ArticlesModel articlesModel =
                          ArticlesModel.fromJson(snapshot.data?.docs[index].data() as Map);
                      return listItem(articlesModel);
                    }),
              );
            }
            return const Center(child: Text("there's no Notes"));
          }),
    );
  }

  listItem(ArticlesModel articlesModel) {
    return GestureDetector(
      onTap: () => onItemTap(context, articlesModel.imageUrl),
      child: Container(
        color: GetColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        margin: const EdgeInsets.only(bottom: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 150,
              // color: GetColors.grey.withOpacity(0.3),
              child: Image.network(
                articlesModel.imageUrl ?? GetImages.placeholderNetwork,
                errorBuilder: (_, __, ___) {
                  return const Icon(Icons.file_copy, size: 30);
                },
              ),
            ),
            const SizedBox(height: 5),
            Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: GetColors.purple.withOpacity(0.8), borderRadius: BorderRadius.circular(8)),
                child: Text(
                  articlesModel.title ?? '',
                  style: const TextStyle(color: GetColors.white),
                )),
            // const Divider(thickness: 2,color: GetColors.black),
          ],
        ),
      ),
    );
  }

  onItemTap (context,String? url){
    AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.scale,
      dismissOnTouchOutside: false,
      title: 'Please confirm',
      desc: 'Are you sure you want to Download? If yes, then you will be redirect to Youtube',
      btnCancelOnPress: () => Navigator.popUntil(context, ModalRoute.withName(Routes.articles_shows)),
      btnOkOnPress: () => Utils.openUrl(url),
    ).show();
  }
}
