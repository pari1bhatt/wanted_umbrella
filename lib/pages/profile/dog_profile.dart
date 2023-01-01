import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wanted_umbrella/models/user_model.dart';
import 'package:wanted_umbrella/pages/dashboard_provider.dart';
import 'package:wanted_umbrella/utils/constants.dart';

class DogProfile extends StatefulWidget {
  const DogProfile({Key? key}) : super(key: key);

  @override
  State<DogProfile> createState() => _DogProfileState();
}

class _DogProfileState extends State<DogProfile> {
  late Size size;
  late DashboardProvider provider;
  UserModel? tempModel;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<DashboardProvider>(context, listen: false);
    tempModel = provider.currentUserModel;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Edit Profile"),
        // actions: [
        //   TextButton(
        //       onPressed: () {}, child: Text('edit', style: TextStyle(color: GetColors.white)))
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  Container(
                    height: size.height * .12,
                    width: size.height * .14,
                    decoration: BoxDecoration(
                        color: GetColors.blue,
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              tempModel?.dog_images?.first ?? GetImages.placeholderNetwork),
                        )),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      "add new photo",
                      style: TextStyle(
                          color: GetColors.lightBlue,
                          decoration: TextDecoration.underline,
                          fontSize: 22),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            const Divider(thickness: 2, color: GetColors.black87, height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text("Dog details :",
                      style:
                      TextStyle(fontSize: 22, color: GetColors.black, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                          flex: 3, child: Text("Dog name", style: TextStyle(color: GetColors.black))),
                      Expanded(
                        flex: 7,
                        child: TextFormField(
                          initialValue: tempModel?.dog_name ?? '',
                          keyboardType: TextInputType.name,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))],
                          onChanged: (value) {
                            tempModel?.dog_name = value;
                          },
                          decoration: const InputDecoration(hintText: 'Dog name', isDense: true),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Expanded(
                          flex: 3,
                          child: Text("Enter breed", style: TextStyle(color: GetColors.black))),
                      Expanded(
                        flex: 7,
                        child: TextFormField(
                          initialValue: tempModel?.breed ?? '',
                          keyboardType: TextInputType.name,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))],
                          onChanged: (value) {
                            tempModel?.breed = value;
                          },
                          decoration: const InputDecoration(hintText: 'Breed name', isDense: true),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Expanded(
                          flex: 3,
                          child: Text("Choose gender", style: TextStyle(color: GetColors.black))),
                      Expanded(
                        flex: 7,
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: tempModel?.gender,
                          onChanged: (String? newValue) {
                            setState(() {
                              tempModel?.gender = newValue;
                            });
                          },
                          items:
                          <String>['Male', 'Female'].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Expanded(
                          flex: 3,
                          child: Text("Choose size", style: TextStyle(color: GetColors.black))),
                      Expanded(
                        flex: 7,
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: tempModel?.size,
                          onChanged: (String? newValue) {
                            setState(() {
                              tempModel?.size = newValue;
                            });
                          },
                          items: <String>['Small', 'Medium', 'Large', 'Very Large']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Expanded(
                          flex: 3, child: Text("Enter age", style: TextStyle(color: GetColors.black))),
                      Expanded(
                        flex: 7,
                        child: TextFormField(
                          initialValue: tempModel?.age ?? '',
                          keyboardType: TextInputType.name,
                          onChanged: (value) {
                            tempModel?.age = value;
                          },
                          decoration: const InputDecoration(hintText: 'Age in months', isDense: true),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Expanded(
                          flex: 3, child: Text("Bio", style: TextStyle(color: GetColors.black))),
                      Expanded(
                        flex: 7,
                        child: TextFormField(
                          initialValue: tempModel?.bio ?? '',
                          minLines: 3,
                          maxLines: 3,
                          keyboardType: TextInputType.name,
                          onChanged: (value) {
                            tempModel?.bio = value;
                          },
                          decoration: const InputDecoration(
                              hintText: 'Please enter bio',
                              isDense: true,
                              border: OutlineInputBorder()),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: GetColors.purple),
                onPressed: () {
                  provider.onUpdateProfile(tempModel!,context);
                },
                child: const Text('Save', style: TextStyle(fontSize: 20, color: GetColors.white)),
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
