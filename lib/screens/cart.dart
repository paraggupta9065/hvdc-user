import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:hvdc_user/controllers/address_controller.dart';
import 'package:hvdc_user/controllers/cart_controller.dart';
import 'package:hvdc_user/controllers/order_controller.dart';
import 'package:hvdc_user/models/address.dart';
import 'package:hvdc_user/models/cart.dart';
import 'package:hvdc_user/models/patient.dart';
import 'package:hvdc_user/models/test.dart';
import 'package:hvdc_user/utils/img_name.dart';
import 'package:hvdc_user/utils/kTextField.dart';
import 'package:hvdc_user/utils/responsive.dart';
import 'package:hvdc_user/utils/toast.dart';
import 'package:lottie/lottie.dart';
import '../controllers/patient_controller.dart';
import '../utils/card.dart';
import '../utils/colors.dart';
import '../utils/loading.dart';
import '../utils/style.dart';
import 'dart:math' as math;

import 'profile_screens/test_booking_screen.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  CartController cartController = Get.put(CartController());
  PatientController patientController = Get.put(PatientController());
  AddressController addressController = Get.put(AddressController());
  OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(() {
              if (cartController.isLoadingCart.value) {
                return const Center(
                  child: KLoading(),
                );
              }
              if (cartController.isEmpty.value) {
                return Padding(
                    padding: EdgeInsets.only(top: kHeight(30)),
                    child: Column(
                      children: [
                        Lottie.asset(
                          'assets/animation/empty.json',
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Cart Empty",
                          style: kTextStyle.copyWith(
                              fontSize: 20,
                              color: kText,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(kGreen),
                              shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12)))),
                            ),
                            onPressed: () => {context.pop()},
                            child: const SizedBox(
                              height: 40,
                              width: double.maxFinite,
                              child: Center(
                                child: Text(
                                  "Go To Home",
                                  style: TextStyle(
                                    color: kWhite,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ));
              }

              CartModel cart = cartController.cart!;

              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      InkWell(
                        child: const Icon(
                          Icons.arrow_back,
                        ),
                        onTap: () {
                          context.pop();
                        },
                      ),
                      const SizedBox(width: 20),
                      Text(
                        "Cart",
                        style: kTextStyle.copyWith(
                            fontSize: 16,
                            color: kText,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  Items(cart: cart),
                  const SizedBox(height: 20),
                  listView(cart),
                  const SizedBox(height: 15),
                  //
                  textImageWidget('Sample Pickup', locationIcon),
                  const SizedBox(height: 10),
                  samplePickup(),
                  const SizedBox(height: 15),
                  //
                  textImageWidget('Patient Details', testBook),
                  const SizedBox(height: 10),
                  patientDetails(),
                  const SizedBox(height: 15),
                  //
                  textImageWidget('Promo Code', promoCode),
                  const SizedBox(height: 10),
                  promoCodeApply(),
                  const SizedBox(height: 15),
                ],
              );
            }),
          ),
        ),
        bottomNavigationBar: Obx(
          () => cartController.isLoadingCart.value ||
                  cartController.isEmpty.value
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(kGreen),
                      shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)))),
                    ),
                    onPressed: () {
                      if (addressController.selectedAddress.value == 0) {
                        kShowSnackbar(
                            title: "Opps!", message: "Please select address !");
                      } else if (patientController.selectedPatient.value == 0) {
                        kShowSnackbar(
                            title: "Opps!", message: "Please select patient!");
                      } else {
                        context.push("/appointment_booking");
                      }
                    },
                    child: const SizedBox(
                      height: 40,
                      width: double.maxFinite,
                      child: Center(
                        child: Text(
                          "Select Slot",
                          style: TextStyle(
                            color: kWhite,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Container patientDetails() {
    List<DropdownMenuItem> addresses = [];
    for (Patient patient in patientController.patient) {
      addresses.add(
        DropdownMenuItem(
          value: patient.id,
          child: SizedBox(
            width: kWidth(75),
            child: Text(
              patient.name,
              maxLines: 1,
              overflow: TextOverflow.clip,
              style: kTextStyle.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      );
    }

    addresses.add(
      DropdownMenuItem(
        onTap: () {
          modelSheetPatient();
        },
        value: 0,
        child: SizedBox(
          width: kWidth(75),
          child: Text(
            'Add patient',
            maxLines: 1,
            overflow: TextOverflow.clip,
            style: kTextStyle.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
    return kContainer(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: kWidth(82),
              child: DropdownButton(
                value: patientController.selectedPatient.value == 0
                    ? null
                    : patientController.selectedPatient.value,
                underline: const SizedBox(),
                isExpanded: true,
                hint: const Text("Select"),
                items: addresses,
                onChanged: (v) {
                  patientController.selectedPatient.value = v;
                },
              ),
            ),
            // const Image(image: AssetImage(locatorIcon)),
          ],
        ),
      ),
    );
  }

  Container promoCodeApply() {
    return Container(
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(
            8.0), // Optional: Add border radius for rounded corners

        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 225, 224, 224)
                .withOpacity(0.5), // Shadow color
            spreadRadius: 1, // Spread radius
            blurRadius: 2, // Blur radius
            offset: const Offset(0, 2), // Offset in x and y directions
          ),
        ],
      ),
      child: TextField(
        style: kTextStyle.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Apply',
                style: kTextStyle.copyWith(
                    fontSize: 16, fontWeight: FontWeight.w400, color: kGreen),
              ),
            ),
          ),
          suffixIconConstraints: const BoxConstraints(
            minWidth: 24, // Minimum width of the suffix icon
            minHeight: 24, // Minimum height of the suffix icon
          ),
          // contentPadding:
          hintText: 'Enter your coupon',
          hintStyle: kTextStyle.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }

  Container samplePickup() {
    List<DropdownMenuItem> addresses = [];
    for (Address address in addressController.address) {
      addresses.add(
        DropdownMenuItem(
          value: address.id,
          child: SizedBox(
            width: kWidth(75),
            child: Text(
              address.street,
              maxLines: 1,
              overflow: TextOverflow.clip,
              style: kTextStyle.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      );
    }

    addresses.add(
      DropdownMenuItem(
        onTap: () {
          modelSheetAddress();
        },
        value: 0,
        child: SizedBox(
          width: kWidth(75),
          child: Text(
            'Add Address',
            maxLines: 1,
            overflow: TextOverflow.clip,
            style: kTextStyle.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
    return kContainer(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: kWidth(82),
              child: DropdownButton(
                underline: const SizedBox(),
                value: addressController.selectedAddress.value == 0
                    ? null
                    : addressController.selectedAddress.value,
                isExpanded: true,
                items: addresses,
                hint: const Text("Select"),
                onChanged: (v) {
                  addressController.selectedAddress.value = v;
                },
              ),
            ),
            // const Image(image: AssetImage(locatorIcon)),
          ],
        ),
      ),
    );
  }

  ListView listView(CartModel cart) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: cart.cart.tests.length,
      itemBuilder: (BuildContext context, int index) {
        Test test = cart.cart.tests[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: cartTile(test),
        );
      },
    );
  }

  Container cartTile(Test test) {
    return kContainer(
      child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    test.name,
                    style: kTextStyle.copyWith(
                        fontSize: 16,
                        color: kText,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "Essentials",
                    style: kTextStyle.copyWith(
                        fontSize: 14,
                        color: kText,
                        fontWeight: FontWeight.w400),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "₹ ${test.price}",
                        style: kTextStyle.copyWith(
                            fontSize: 16,
                            color: kGreen,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "₹ ${test.regularPrice}",
                        style: kTextStyle.copyWith(
                          fontSize: 12,
                          color: kGrey.withOpacity(0.7),
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: kGrey.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  cartController.removeFromCart(test.id);
                },
                child: const Icon(
                  CupertinoIcons.delete,
                  size: 17,
                ),
              ),
            ],
          )),
      height: 100,
      width: double.infinity,
    );
  }

  void modelSheetPatient() {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        height: kHeight(35),
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Obx(() {
            int selected = patientController.selectedGender.value;

            return patientController.isLoadingPatient.value
                ? const KLoadingCircular()
                : Column(
                    children: [
                      KTextField(
                          controller: patientController.name,
                          hintText: 'Enter Name'),
                      const SizedBox(height: 15),
                      KTextField(
                          controller: patientController.phone,
                          hintText: 'Enter Mobile'),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () =>
                                patientController.selectedGender.value = 0,
                            child: kContainer(
                              color: selected == 0 ? kGreen : kWhite,
                              child: Center(
                                child: Text(
                                  "Male",
                                  style: kTextStyle.copyWith(
                                    color: selected == 0 ? kWhite : kText,
                                  ),
                                ),
                              ),
                              height: 40,
                              width: kWidth(25),
                            ),
                          ),
                          InkWell(
                            onTap: () =>
                                patientController.selectedGender.value = 1,
                            child: kContainer(
                                color: selected == 1 ? kGreen : kWhite,
                                child: Center(
                                  child: Text(
                                    "Female",
                                    style: kTextStyle.copyWith(
                                      color: selected == 1 ? kWhite : kText,
                                    ),
                                  ),
                                ),
                                height: 40,
                                width: kWidth(25)),
                          ),
                          InkWell(
                            onTap: () =>
                                patientController.selectedGender.value = 2,
                            child: kContainer(
                                color: selected == 2 ? kGreen : kWhite,
                                child: Center(
                                  child: Text(
                                    "Others",
                                    style: kTextStyle.copyWith(
                                      color: selected == 2 ? kWhite : kText,
                                    ),
                                  ),
                                ),
                                height: 40,
                                width: kWidth(25)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(kGreen),
                          shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)))),
                        ),
                        onPressed: () async {
                          await patientController.addPatientCart();
                          setState(() {});
                        },
                        child: const SizedBox(
                          height: 40,
                          width: double.maxFinite,
                          child: Center(
                            child: Text(
                              "Add Patient",
                              style: TextStyle(
                                color: kWhite,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
          }),
        ),
      ),
    );
  }

  void modelSheetAddress() {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        height: kHeight(30),
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Obx(
            () => addressController.isLoadingAddress.value
                ? const KLoadingCircular()
                : Column(
                    children: [
                      KTextField(
                        controller: addressController.street,
                        hintText: 'Enter Address',
                      ),
                      const SizedBox(height: 15),
                      KTextField(
                        controller: addressController.pincode,
                        hintText: 'Enter Pincode',
                      ),
                      const SizedBox(height: 15),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(kGreen),
                          shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)))),
                        ),
                        onPressed: () async {
                          await addressController.addAddressCart();
                          setState(() {});
                        },
                        child: const SizedBox(
                          height: 40,
                          width: double.maxFinite,
                          child: Center(
                            child: Text(
                              "Add Address",
                              style: TextStyle(
                                color: kWhite,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
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

class Items extends StatelessWidget {
  const Items({
    super.key,
    required this.cart,
  });

  final CartModel cart;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFF1F1F1),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(200),
                color: kGreenOpacity,
              ),
              height: 45,
              width: 45,
              child: const Icon(
                FontAwesomeIcons.basketShopping,
                color: kGreen,
                size: 24,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              "${cart.cart.tests.length} Items in Total",
              style: kTextStyle.copyWith(
                  fontSize: 16, color: kText, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Text(
          "₹ ${cart.cartTotal}",
          style: kTextStyle.copyWith(
              fontSize: 16, color: kGreen, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
