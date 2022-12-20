import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wanted_umbrella/routes.dart';
import 'package:wanted_umbrella/utils/constants.dart';

import '../../utils/utils.dart';

class DogPhotos extends StatefulWidget {
  const DogPhotos({Key? key}) : super(key: key);

  @override
  State<DogPhotos> createState() => _DogPhotosState();
}

class _DogPhotosState extends State<DogPhotos> {
  List<File?> fileList = [];

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
              onPressed: () => Navigator.popUntil(context, ModalRoute.withName(Routes.login)),
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
                    itemCount: fileList.length + 1,
                    itemBuilder: (context, index) {
                      if (index != (fileList.length)) {
                        return Container(
                          color: GetColors.grey.withOpacity(0.5),
                          child: Image.file(fileList[index]!, fit: BoxFit.fill),
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
    fileList.add(await Utils.pickImage());
    setState(() {});
  }

  onNext() {
    if(fileList.isNotEmpty){
      Navigator.pushNamed(context, Routes.kci_certificate);
    } else {
      Utils.showSnackBar(context, "Please select any one image");
    }
  }
}
