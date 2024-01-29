import 'package:catering_user_app/src/common/common_export.dart';
import 'package:catering_user_app/src/features/menu/domain/models/menu_model.dart';
import 'package:catering_user_app/src/features/menu/screens/widgets/input_chip_field.dart';
import 'package:catering_user_app/src/themes/export_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingScreen extends StatefulWidget {
  final int totalGuests;
  final Menus menuData;

  const BookingScreen(
      {super.key, required this.menuData, required this.totalGuests});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final dateController = TextEditingController();
  final priceController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  late List<String> starterMenu;
  late List<String> mainCourseMenu;
  late List<String> dessertMenu;

  @override
  void initState() {
    super.initState();
    starterMenu = List<String>.from(widget.menuData.starterMenu);
    mainCourseMenu = List<String>.from(widget.menuData.mainCourseMenu);
    dessertMenu = List<String>.from(widget.menuData.dessertMenu);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Booking Date',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColor.primaryRed,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              BuildTextField(
                controller: dateController,
                suffixIconButton: IconButton(
                  onPressed: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now().add(const Duration(days: 1)),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2025),
                      selectableDayPredicate: (DateTime day) {
                        return day.isAfter(DateTime.now()); // Allow dates from tomorrow onwards
                      },
                    );
                    if (pickedDate != null) {
                      dateController.text = pickedDate.toString().substring(0, 10);
                    }
                  },
                  icon: const Icon(Icons.calendar_month, color: AppColor.primaryRed,),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Booking Details',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColor.primaryRed,
                ),
              ),
              SizedBox(height: 10.h,),
              BuildTextField(
                controller: _nameController,
                labelText: 'Name',
              ),
              SizedBox(height: 16.h,),
              BuildTextField(
                controller: _phoneController,
                labelText: 'Phone Number',
              ),
              SizedBox(height: 50.h,),
              Text(
                'Food Items',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 10.h,),
              Text(
                'Starter Menu',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(
                height: 6.h,
              ),
              EditableChipField(
                initialValues: starterMenu,
                onChanged: (List<String> items) {
                  setState(() {
                    starterMenu = items;
                  });
                },
                maxLine: 5,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Main Course Items',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(
                height: 6.h,
              ),
              EditableChipField(
                initialValues: mainCourseMenu,
                onChanged: (List<String> items) {
                  setState(() {
                    mainCourseMenu = items;
                  });
                },
                maxLine: 5,
              ),
              SizedBox(
                height: 25.h,
              ),
              Text(
                'Dessert items',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(
                height: 6.h,
              ),
              EditableChipField(
                initialValues: dessertMenu,
                onChanged: (List<String> items) {
                  setState(() {
                    dessertMenu = items;
                  });
                },
                maxLine: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
