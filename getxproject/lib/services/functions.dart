import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxproject/model/students.dart';
import 'package:getxproject/screens/add_student.dart';
import 'package:getxproject/screens/widgets/student_list.dart';
import 'package:getxproject/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';

void snackBarFunction({
  required String title,
  required String subtitle,
  Duration? animationDuration,
  SnackPosition? snackPosition,
  Color? backgroundColor,
  DismissDirection? dismissDirection,
}) {
  Get.snackbar(title, subtitle,
      animationDuration: animationDuration,
      isDismissible: true,
      snackPosition: snackPosition,
      backgroundColor: backgroundColor,
      dismissDirection: dismissDirection);
}

void showDeleteConfirmationDialog(BuildContext context, StudentModel student) {
  Get.defaultDialog(
      backgroundColor: Colors.white.withOpacity(0.8),
      title: 'CONFIRM DELETION',
      content: Text(
        'Sure To Remove ${student.name}?',
        selectionColor: Colors.white,
      ),
      cancel: ElevatedButton(
        style: const ButtonStyle(
            backgroundColor:
                MaterialStatePropertyAll(Color.fromARGB(255, 84, 183, 82))),
        onPressed: () {
          Get.back();
        },
        child: const Text('Cancel'),
      ),
      confirm: ElevatedButton(
        style: const ButtonStyle(
            backgroundColor:
                MaterialStatePropertyAll(Color.fromARGB(255, 190, 67, 67))),
        onPressed: () {
          studentsController.deleteStudent(int.parse(student.id.toString()));
          Get.back();

          showDeleteConfirmationSnackBar(context, student);
        },
        child: const Text('OK'),
      ));
}

void showStudentDetailsDialog(BuildContext context, StudentModel student) {
  Get.dialog(
    Stack(
      children: [
        Positioned(
          top: 50,
          bottom: 50,
          left: 20,
          right: 20,
          child: StudentImageContainerWidget(
            student: student,
            height: 70,
            width: double.infinity,
          ),
        ),
        Dialog(
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: 550,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Constants().kheight20,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: StudentImageContainerWidget(
                        student: student,
                        height: 300,
                        width: 300,
                      ),
                    ),
                    Constants().kheight20,
                    Text(
                      student.name.toUpperCase(),
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Constants().kheight20,
                    Text(
                      'Age: ${student.age}',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Department: ${student.department.toUpperCase()}',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Place: ${student.place}',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Guardian Name: ${student.guardianName}',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Phone No: ${student.phoneNumber}',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

void showDeleteConfirmationSnackBar(
    BuildContext context, StudentModel student) {
  Get.snackbar(
    "Delete ConfirmED",
    "You  Deleted ${student.name}?",
    duration: const Duration(seconds: 5),
    snackPosition: SnackPosition.BOTTOM,
    colorText: Colors.white,
    mainButton: TextButton(
      onPressed: () {},
      child: const Text(
        "DELETED",
        style: TextStyle(color: Color.fromARGB(255, 255, 2, 2)),
      ),
    ),
  );
}
