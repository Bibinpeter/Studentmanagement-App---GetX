import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxproject/screens/student_list.dart';
import 'package:getxproject/screens/widgets/app_bar.dart';
import 'package:getxproject/screens/widgets/text_form.dart';
import 'package:getxproject/services/functions.dart';
import 'package:getxproject/utils/constants.dart';
import 'package:getxproject/viewmodel/student_controller.dart';
 
class SearchStudentScreen extends StatelessWidget {
  const SearchStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StudentController studentControllerGetx =
        Get.put(StudentController());
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 90),
        child: AppBarWidget(title: 'Search Students',),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(() {
            final filteredStudents = studentControllerGetx.filteredStudents;
            return Column(
              children: [
                TextFormFieldWidget(
                  
                  onChanged: (p0) {
                    print('filtering query changed: $p0');
                    studentControllerGetx.filterStudents(p0);
                  },
                  controller: searchController,
                  hintText: 'Type the name of the student',
                  inputType: TextInputType.name,
                  prefixicon: Icons.search,
                ),
                Constants().kheight20,
                  
                Expanded(
                  child: filteredStudents.isEmpty
                      ? const Center(
                          child: Text('No Student Found.'),
                        )
                      : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final student = filteredStudents[index];
                            return InkWell(
                              onTap: () =>
                                  showStudentDetailsDialog(context, student),
                                  
                              child: StudentCardWidget(student: student),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              Constants().kheight20,
                              
                          itemCount: filteredStudents.length,
                        ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}