import 'package:catering_user_app/src/common/common_export.dart';
import 'package:catering_user_app/src/features/menu/domain/models/menu_model.dart';
import 'package:catering_user_app/src/features/menu/screens/widgets/common_function.dart';
import 'package:catering_user_app/src/features/menu/screens/widgets/input_chip_field.dart';
import 'package:catering_user_app/src/features/order/domain/pre_order_model.dart';
import 'package:catering_user_app/src/features/order/screens/order_summary_screen.dart';
import 'package:catering_user_app/src/shared/data/user_provider.dart';
import 'package:catering_user_app/src/themes/export_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  final _formKey = GlobalKey<FormState>();
  final dateController = TextEditingController();
  final priceController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _dietaryController = TextEditingController();
  final _guestController = TextEditingController();
  final _staffController = TextEditingController();
  final _totalController = TextEditingController();

  late List<String> starterMenu;
  late List<String> mainCourseMenu;
  late List<String> dessertMenu;

  int staffNo = 2;
  late int guestNumber;
  late double totalPrice;

  @override
  void initState() {
    super.initState();
    starterMenu = List<String>.from(widget.menuData.starterMenu);
    mainCourseMenu = List<String>.from(widget.menuData.mainCourseMenu);
    dessertMenu = List<String>.from(widget.menuData.dessertMenu);
    _guestController.text = widget.totalGuests.toString();
    guestNumber = widget.totalGuests;
    _staffController.text = staffNo.toString();
    totalPrice = widget.menuData.price * widget.totalGuests;
    _totalController.text = "Rs. ${formatTotalPrice(totalPrice)}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final userData = ref.watch(singleUserProvider);
          return userData.when(
            data: (data) {
              _nameController.text = data.firstName!;
              _phoneController.text = data.metadata!['phone'];
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
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
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Select date';
                                }
                                return null;
                              },
                              suffixIconWidget: IconButton(
                                onPressed: () async {
                                  final DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate:
                                    DateTime.now().add(const Duration(days: 1)),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2025),
                                    selectableDayPredicate: (DateTime day) {
                                      return day.isAfter(DateTime
                                          .now()); // Allow dates from tomorrow onwards
                                    },
                                  );
                                  if (pickedDate != null) {
                                    dateController.text =
                                        pickedDate.toString().substring(0, 10);
                                  }
                                },
                                icon: const Icon(
                                  Icons.calendar_month,
                                  color: AppColor.primaryRed,
                                ),
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
                            SizedBox(
                              height: 10.h,
                            ),
                            BuildTextField(
                              controller: _nameController,
                              labelText: 'Name',
                              suffixIconWidget: IconButton(
                                  onPressed: (){
                                    _nameController.clear();
                                  },
                                  icon: const Icon(Icons.close, size: 16, weight: 4,)
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            BuildTextField(
                              controller: _phoneController,
                              labelText: 'Phone Number',
                              suffixIconWidget: IconButton(
                                  onPressed: (){
                                    _phoneController.clear();
                                  },
                                  icon: const Icon(Icons.close, size: 16, weight: 4,)
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter phone';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            BuildTextField(
                              controller: _addressController,
                              labelText: 'Address',
                              suffixIconWidget: IconButton(
                                  onPressed: (){
                                    _addressController.clear();
                                  },
                                  icon: const Icon(Icons.close, size: 16, weight: 4,)
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Your address is required';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            BuildTextField(
                              maxLine: 3,
                              controller: _dietaryController,
                              labelText: 'Dietary Requirements',
                              hintText: 'Example: No Pork, No Beef, No Seafood',
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Container(
                              padding: EdgeInsets.all(8.w),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(color: AppColor.greyColor)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Guests',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(color: Colors.grey.shade600),
                                      ),
                                      buildInputField(_guestController, guestNumber),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Staff',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(color: Colors.grey.shade600),
                                      ),
                                      buildInputField(_staffController, staffNo)
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'Total',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(color: Colors.grey.shade600),
                                      ),
                                      SizedBox(
                                        width: 80.w,
                                        child: TextField(
                                          onSubmitted: (value) {
                                            setState(() {
                                              totalPrice = double.parse(value);
                                            });
                                          },
                                          controller: _totalController,
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.zero,
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              'Food Items',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: AppColor.primaryRed,
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
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
                            SizedBox(
                              height: 100.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    left: 0,
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
                      height: 74.h,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        boxShadow: [
                          BoxShadow(
                              color:
                              Theme.of(context).primaryColorLight.withOpacity(0.25),
                              blurRadius: 12,
                              spreadRadius: 5,
                              offset: const Offset(0, -1),
                          )
                        ],
                      ),
                      child: BuildButton(
                        onPressed: () {
                          PreOrderModel preOrderModel = PreOrderModel(
                            customerId: data.id,
                            date: dateController.text.trim(),
                            name: _nameController.text.trim(),
                            address: _addressController.text.trim(),
                            phone: _phoneController.text.trim(),
                            dietaryPref: _dietaryController.text.trim(),
                            helpers: _staffController.text.trim(),
                            totalGuests: _guestController.text.trim(),
                            menu: widget.menuData,
                          );
                          if(_formKey.currentState!.validate()){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => OrderSummaryScreen(
                                  preOrderModel: preOrderModel,
                                ),
                              ),
                            );
                          }
                        },
                        buttonWidget: const Text('Place Order'),
                      ),
                    ),
                  )
                ],
              );
            },
            error: (error, stackTrace) => Center(child: Text('$error'),),
            loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        },
      ),
    );
  }

  SizedBox buildInputField(TextEditingController controller, int? peopleCount) {
    return SizedBox(
      width: 50.w,
      height: 50.h,
      child: TextField(
        onSubmitted: (value) {
          setState(() {
            peopleCount = int.parse(value);
          });
        },
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.people_alt_rounded,
            size: 18,
            color: Colors.grey.shade600,
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 0,
          ),
          contentPadding: EdgeInsets.zero,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
