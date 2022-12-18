import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_pro/models/body_model.dart';
import 'package:gym_pro/pages/after_login/bottom_navbar_host.dart';

import '../../firebase_helper.dart';

class BodyModelFormPage extends StatefulWidget {
  const BodyModelFormPage({super.key});

  @override
  State<BodyModelFormPage> createState() => _BodyModelFormPageState();
}

class _BodyModelFormPageState extends State<BodyModelFormPage> {
  late final FirebaseHelper firebaseHelper;
  final formKey = GlobalKey<FormState>();
  final TextEditingController _controllerWeight = TextEditingController();
  final TextEditingController _controllerHeight = TextEditingController();
  final TextEditingController _controllerBodyfat = TextEditingController();

  @override
  void initState() {
    firebaseHelper = FirebaseHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backButton(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                "Enter your new body informations to keep track of it.",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey.shade500,
                ),
              ),
              const SizedBox(height: 20),
              weightInput(),
              const SizedBox(height: 20),
              heightInput(),
              const SizedBox(height: 20),
              bodyfatInput(),
              const SizedBox(height: 20),
              addButton()
            ],
          ),
        ),
      ),
    );
  }

  AppBar backButton(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BottomNavBarHost()),
        ),
      ),
      elevation: 0,
      title: const Text("Personal Progress"),
    );
  }

  TextField weightInput() {
    return TextField(
      controller: _controllerWeight,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0.0),
        labelText: 'Weight',
        hintText: 'Enter your weight',
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
        ),
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14.0,
        ),
        prefixIcon: const Icon(
          Icons.monitor_weight_outlined,
          color: Colors.black,
          size: 32,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
          borderRadius: BorderRadius.circular(10.0),
        ),
        floatingLabelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  TextField heightInput() {
    return TextField(
      controller: _controllerHeight,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0.0),
        labelText: 'Height',
        hintText: 'Enter your height',
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
        ),
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14.0,
        ),
        prefixIcon: const Icon(
          Icons.height,
          color: Colors.black,
          size: 32,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
          borderRadius: BorderRadius.circular(10.0),
        ),
        floatingLabelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  TextField bodyfatInput() {
    return TextField(
      controller: _controllerBodyfat,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0.0),
        labelText: 'Bodyfat',
        hintText: 'Enter your bodyfat',
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
        ),
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14.0,
        ),
        prefixIcon: const Icon(
          CupertinoIcons.circle_grid_3x3_fill,
          color: Colors.black,
          size: 32,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
          borderRadius: BorderRadius.circular(10.0),
        ),
        floatingLabelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  // todo add form validation
  Center addButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          var bodyModel = BodyModel(
            weight: _controllerWeight.text.toString(),
            height: _controllerHeight.text.toString(),
            fatRate: _controllerBodyfat.text.toString(),
          );

          firebaseHelper
              .addUserBodyModel(firebaseHelper.currentUser!.uid, bodyModel)
              .then(
                (value) => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BottomNavBarHost()),
                ),
              );
        },
        child: const Text('Click to save your progress'),
      ),
    );
  }
}
