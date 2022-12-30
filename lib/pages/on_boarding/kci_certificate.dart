import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanted_umbrella/pages/on_boarding/on_boarding_provider.dart';
import 'package:wanted_umbrella/routes.dart';
import 'package:wanted_umbrella/utils/constants.dart';
import 'package:wanted_umbrella/utils/utils.dart';

class KciCertificate extends StatefulWidget {
  const KciCertificate({Key? key}) : super(key: key);

  @override
  State<KciCertificate> createState() => _KciCertificateState();
}

class _KciCertificateState extends State<KciCertificate> {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Upload KCI certificate",
                  style: TextStyle(fontSize: 22, color: GetColors.black, fontWeight: FontWeight.w600)),
              const SizedBox(height: 25),
              GestureDetector(
                onTap: onFilePick,
                child: Container(
                  height: 100,
                  width: 100,
                  color: GetColors.grey.withOpacity(0.5),
                  child: Center(
                      child: Icon(onBoardingProvider.selectedFile == null ? Icons.add : Icons.file_copy,
                          color: onBoardingProvider.selectedFile == null ? GetColors.black : GetColors.purple,
                          size: onBoardingProvider.selectedFile == null ? 20 : 40)),
                ),
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

  onFilePick() async {
    var file = await Utils.pickFile();
    if (file != null) {
      setState(() {
        onBoardingProvider.selectedFile = file;
      });
    }
  }

  onNext() async {
    if (onBoardingProvider.selectedFile == null) {
      Utils.showSnackBar(context, "Please select a document");
    } else {
      Navigator.pushNamed(context, Routes.choose_personality);
    }
  }
}
