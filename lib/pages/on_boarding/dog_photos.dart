import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanted_umbrella/pages/on_boarding/on_boarding_provider.dart';
import 'package:wanted_umbrella/routes.dart';
import 'package:wanted_umbrella/utils/constants.dart';

import '../../utils/utils.dart';

class DogPhotos extends StatefulWidget {
  const DogPhotos({Key? key}) : super(key: key);

  @override
  State<DogPhotos> createState() => _DogPhotosState();
}

class _DogPhotosState extends State<DogPhotos> {
  late OnBoardingProvider onBoardingProvider;

  @override
  void initState() {
    super.initState();
    onBoardingProvider = Provider.of<OnBoardingProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: GetColors.white,
        leading: IconButton(
            icon: const Icon(Icons.keyboard_backspace, color: GetColors.black),
            onPressed: () => Navigator.pop(context)),
        actions: [
          TextButton(
              onPressed: () {
                onBoardingProvider.reset();
                Navigator.popUntil(context, ModalRoute.withName(Routes.login));
              },
              child: const Text("cancel", style: TextStyle(color: GetColors.black)))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text("Upload your dog's photos",
                  style: TextStyle(fontSize: 22, color: GetColors.black, fontWeight: FontWeight.w600)),
              const SizedBox(height: 25),
              const Text(GetStrings.dogPhotosText, style: TextStyle(color: GetColors.black)),
              const SizedBox(height: 25),
              SizedBox(
                height: 320,
                child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10, mainAxisExtent: 100),
                    itemCount: onBoardingProvider.imageList.length + 1,
                    itemBuilder: (context, index) {
                      if (index != (onBoardingProvider.imageList.length)) {
                        return Container(
                          color: GetColors.grey.withOpacity(0.5),
                          child: Image.file(onBoardingProvider.imageList[index]!, fit: BoxFit.fill),
                        );
                      } else {
                        return GestureDetector(
                          onTap: onImagePick,
                          child: Container(
                            color: GetColors.grey.withOpacity(0.5),
                            child: const Center(child: Icon(Icons.add, color: GetColors.black)),
                          ),
                        );
                      }
                    }),
              ),
              const SizedBox(height: 50),
              Center(
                child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: GetColors.purple),
                  onPressed: onNext,
                  child: const Text('Next', style: TextStyle(fontSize: 20, color: GetColors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  onImagePick() async {
    onBoardingProvider.imageList.add(await Utils.pickImage());
    setState(() {});
  }

  onNext() {
    if(onBoardingProvider.imageList.isEmpty){
      Utils.showSnackBar(context, "Please upload at least one dog image");
    } else {
      print("path: ${onBoardingProvider.imageList[0]!.path.split('/').last}");
      Navigator.pushNamed(context, Routes.kci_certificate);
    }
  }
}
