import 'package:bmi_calculator/core/colors.dart';
import 'package:bmi_calculator/page/result_screen.dart';
import 'package:bmi_calculator/widgets/gender_card.dart';
import 'package:bmi_calculator/widgets/main_button.dart';
import 'package:bmi_calculator/widgets/weight_age_card.dart';
import 'package:flutter/material.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  int weight = 60;
  int age = 24;
  int height = 170;
  bool isMale = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        title: const Text(
          "BMI Calculator",
          style: TextStyle(color: AppColors.whiteColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            MaleAndFemale(),
            const SizedBox(height: 10),
            HeightUi(),
            const SizedBox(height: 10),
            weightAndAge(),
            const SizedBox(height: 10),
            MainButton(
              onTap: () {
                double result = weight / (height * height * 0.0001);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultScreen(result: result),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Expanded HeightUi() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Text(
              "Height",
              style: TextStyle(color: AppColors.whiteColor, fontSize: 18),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  height.toString(),
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("cm", style: TextStyle(color: AppColors.whiteColor)),
              ],
            ),
            Slider(
              value: height.toDouble(),
              min: 80,
              max: 220,
              onChanged: (value) {
                setState(() {
                  height = value.toInt();
                });
              },
              activeColor: AppColors.primaryColor,
              inactiveColor: AppColors.greyColor,
            ),
          ],
        ),
      ),
    );
  }

  Expanded MaleAndFemale() {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: GenderCard(
              title: "Male",
              icon: Icons.male,
              color: isMale ? AppColors.primaryColor : AppColors.secondaryColor,
              onTap: () {
                setState(() {
                  isMale = true;
                });
              },
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: GenderCard(
              title: "Female",
              icon: Icons.female,
              color: !isMale
                  ? AppColors.primaryColor
                  : AppColors.secondaryColor,
              onTap: () {
                setState(() {
                  isMale = false;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Expanded weightAndAge() {
    return Expanded(
      child: Row(
        spacing: 10,
        children: [
          WeightAgeCard(
            title: "weight",
            value: weight,
            onAdd: () {
              setState(() {
                weight++;
              });
            },
            onRemove: () {
              if (weight > 30) {
                setState(() {
                  weight--;
                });
              }
            },
          ),
          WeightAgeCard(
            title: "age",
            value: age,
            onAdd: () {
              setState(() {
                age++;
              });
            },
            onRemove: () {
              if (age > 1) {
                setState(() {
                  age--;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
