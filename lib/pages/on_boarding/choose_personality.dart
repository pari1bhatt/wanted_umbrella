import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanted_umbrella/pages/on_boarding/on_boarding_provider.dart';
import 'package:wanted_umbrella/routes.dart';
import 'package:wanted_umbrella/utils/constants.dart';

class ChoosePersonality extends StatefulWidget {
  const ChoosePersonality({Key? key}) : super(key: key);

  @override
  State<ChoosePersonality> createState() => _ChoosePersonalityState();
}

class _ChoosePersonalityState extends State<ChoosePersonality> {
  late OnBoardingProvider onBoardingProvider;

  List<String> personalities = [
    'Active',
    'Affectionate',
    'Barker',
    'Calm',
    'Clever',
    'Energetic',
    'Foodie',
    'Friendly',
    'Gentle',
    'Happy',
    'Lazy',
    'Playful',
    'Protective',
    'Relaxed',
    'Runner',
    'Shy',
    'Silly',
    'Smart',
    'Wrestler'
  ];

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
              onPressed: () => Navigator.popUntil(context, ModalRoute.withName(Routes.login)),
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
                children: List.generate(personalities.length, (index) => MultiSelectChip(personalities[index])),
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
    onBoardingProvider.onRegister(context);
  }
}

class MultiSelectChip extends StatefulWidget {
  String text;

  MultiSelectChip(this.text);

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(widget.text),
      selectedColor: GetColors.purple.withOpacity(0.4),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          isSelected = selected;
        });
      },
    );
  }
}
