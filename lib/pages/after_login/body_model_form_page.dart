import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BodyModelFormPage extends StatefulWidget {
  const BodyModelFormPage({super.key});

  @override
  State<BodyModelFormPage> createState() => _BodyModelFormPageState();
}

class _BodyModelFormPageState extends State<BodyModelFormPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _controllerWeight = TextEditingController();
  final TextEditingController _controllerHeight = TextEditingController();
  final TextEditingController _controllerBodyfat = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: backButton(context),
        body: Padding(
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
              refreshButton()
            ],
          ),
        ));
  }

  AppBar backButton(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
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

  Center refreshButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // todo save to firebase with user id
          Navigator.of(context).pop();
        },
        child: const Text('Click to save your progress'),
      ),
    );
  }
}
