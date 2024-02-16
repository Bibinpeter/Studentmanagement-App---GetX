import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:getxproject/model/students.dart';
import 'package:getxproject/screens/add_student.dart';
import 'package:getxproject/screens/edit_screen.dart';
import 'package:getxproject/screens/student_search.dart';
import 'package:getxproject/screens/widgets/app_bar.dart';
import 'package:getxproject/screens/widgets/floating_action-btn.dart';
import 'package:getxproject/screens/widgets/student_list.dart';
import 'package:getxproject/services/functions.dart';
import 'package:getxproject/utils/constants.dart';
import 'package:getxproject/viewmodel/student_controller.dart';
import 'package:google_fonts/google_fonts.dart';
 

class StudentListScreen extends StatelessWidget {
  const StudentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StudentController studentsController = Get.put(StudentController());
    studentsController.loadStudents();
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 90),
        child: AppBarWidget(
          onTapRight: () {
            Get.to(const SearchStudentScreen());
          },
          righticon: Icons.search,
          title: 'STUDENTS LIST',
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Obx(
            () {
              if (studentsController.students.isEmpty) {
                return const Text('No Student Found');
              } else {
                return ListView.separated(
                  physics:const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) => Constants().kheight10,
                  itemCount: studentsController.students.length,
                  itemBuilder: (context, index) {
                    var student = studentsController.students[index];
                    return InkWell(
                      onTap: () => showStudentDetailsDialog(context, student),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 10),
                        child: StudentCardWidget(student: student),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton:
          const FloatingActionButtonWidget(page: AddStudentScreen()),
    );
  }
}

class StudentCardWidget extends StatelessWidget {
  const StudentCardWidget({
    super.key,
    required this.student,
  });

  final StudentModel student;

  @override
  Widget build(BuildContext context) {
    return Slidable(
  endActionPane: ActionPane(
    motion: const ScrollMotion(),
    children: [
      SlidableAction(
        onPressed: (context) {
          showDeleteConfirmationDialog(context, student);
        },
        icon: Icons.delete,
        backgroundColor: Colors.red,
      ),
      SlidableAction(
        onPressed: (context) {
          Get.to(EditScreen(student: student));
        },
        icon: Icons.edit,
        backgroundColor: Colors.green,
      ),
    ],
  ),
  child: Container(
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 0, 0, 0),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 130, 128, 128).withOpacity(0.5),
          spreadRadius:3 ,
          blurRadius: 3,
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Constants().kWidth10,
            StudentImageContainerWidget(
              student: student,
              height: 135,
              width: 135,
            ),
            Constants().kWidth10,
            Expanded(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student.name.toUpperCase(),
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    Constants().kheight10,
                    Text(
                      'Age: ${student.age}',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: const Color.fromARGB(255, 141, 139, 139),
                      ),
                    ),
                    Text(
                      'Department: ${student.department.toUpperCase()}',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: const Color.fromARGB(255, 137, 135, 135),
                      ),
                    ),
                    Text(
                      'Phone No: ${student.phoneNumber}',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: const Color.fromARGB(255, 119, 118, 118),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ),
);



  }
}