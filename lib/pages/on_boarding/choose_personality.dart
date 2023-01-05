import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanted_umbrella/models/selection_model.dart';
import 'package:wanted_umbrella/pages/on_boarding/on_boarding_provider.dart';
import 'package:wanted_umbrella/routes.dart';
import 'package:wanted_umbrella/utils/constants.dart';
import 'package:wanted_umbrella/utils/utils.dart';

class ChoosePersonality extends StatefulWidget {
  const ChoosePersonality({Key? key}) : super(key: key);

  @override
  State<ChoosePersonality> createState() => _ChoosePersonalityState();
}

class _ChoosePersonalityState extends State<ChoosePersonality> {
  late OnBoardingProvider onBoardingProvider;

  @override
  void initState() {
    onBoardingProvider = Provider.of<OnBoardingProvider>(context, listen: false);
    super.initState();
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
              const Text("Choose Personality",
                  style: TextStyle(fontSize: 22, color: GetColors.black, fontWeight: FontWeight.w600)),
              const SizedBox(height: 25),
              const Text(GetStrings.chooseTraits, style: TextStyle(color: GetColors.black)),
              const SizedBox(height: 25),
              Wrap(
                spacing: 20,
                children: List.generate(
                    onBoardingProvider.personalities.length, (index) => MultiSelectChip(index, onBoardingProvider)),
              ),
              const SizedBox(height: 50),
              Center(
                child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: GetColors.purple),
                  onPressed: onRegister,
                  child: const Text('Register', style: TextStyle(fontSize: 20, color: GetColors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  onRegister() {
    if(onBoardingProvider.selectedPersonalities() > 0){
      onBoardingProvider.addPersonalities();
      onBoardingProvider.onRegister(context);
    } else {
      Utils.showSnackBar(context, "Choose at least one personality");
    }
  }
}

class MultiSelectChip extends StatefulWidget {
  int index;
  OnBoardingProvider onBoardingProvider;

  MultiSelectChip(this.index, this.onBoardingProvider);

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(widget.onBoardingProvider.personalities[widget.index].text!),
      selectedColor: GetColors.purple.withOpacity(0.4),
      selected: widget.onBoardingProvider.personalities[widget.index].isSelected,
      onSelected: (selected) {
        if(!selected || widget.onBoardingProvider.selectedPersonalities() < 5){
          setState(() {
            widget.onBoardingProvider.personalities[widget.index].isSelected = selected;
          });
        }
      },
    );
  }

  bool checkSelectable (){
    int i = 0;
    for(var a in widget.onBoardingProvider.personalities){
      if(a.isSelected){
        i++;
      }
    }
    return i < 5;
  }
}
