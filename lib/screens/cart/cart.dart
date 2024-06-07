import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

import 'package:hvdc_user/controllers/address_controller.dart';
import 'package:hvdc_user/controllers/cart_controller.dart';
import 'package:hvdc_user/controllers/order_controller.dart';
import 'package:hvdc_user/models/address.dart';
import 'package:hvdc_user/models/cart.dart';
import 'package:hvdc_user/models/packages.dart';
import 'package:hvdc_user/models/patient.dart';
import 'package:hvdc_user/models/test.dart';
import 'package:hvdc_user/screens/home/web_home.dart';
import 'package:hvdc_user/utils/appBar.dart';
import 'package:hvdc_user/utils/img_name.dart';
import 'package:hvdc_user/utils/kTextField.dart';
import 'package:hvdc_user/utils/padding.dart';
import 'package:hvdc_user/utils/responsive.dart';
import 'package:hvdc_user/utils/toast.dart';
import 'package:lottie/lottie.dart';
import '../../controllers/patient_controller.dart';
import '../../utils/card.dart';
import '../../utils/colors.dart';
import '../../utils/loading.dart';
import '../../utils/routing.dart';
import '../../utils/style.dart';
import 'dart:math' as math;

import '../home/header.dart';
import '../home/mobile_home.dart';
import '../profile_screens/test_booking_screen.dart';

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
        appBar: kWeb
            ? null
            : KAppBar(
                "Cart",
                actions: [
                  TextButton(
                    onPressed: () {
                      cartController.clearCart();
                    },
                    child: Text(
                      "clear",
                      style: kTextStyle.copyWith(color: kRed),
                    ),
                  )
                ],
              ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: kWebPadding,
              child: Obx(() {
                if (cartController.isLoadingCart.value) {
                  return const Center(
                    child: KLoading(),
                  );
                }
                if (cartController.cart == null) {
                  return Padding(
                      padding: kWeb
                          ? EdgeInsets.only(top: kHeight(0))
                          : EdgeInsets.only(top: kHeight(20)),
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
                              onPressed: () => {Get.offAllNamed("/home")},
                              child: SizedBox(
                                height: 40,
                                width: double.maxFinite,
                                child: Center(
                                  child: Text(
                                    "Go To Home",
                                    style: kTextStyle.copyWith(color: kWhite),
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

                    Items(cart: cart),
                    const SizedBox(height: 20),
                    listView(cart),
                    listViewPackage(cart),
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
                    const SizedBox(height: 15),
                    textImageWidget('Payment Method', promoCode),
                    const SizedBox(height: 10),
                    payment(),
                  ],
                );
              }),
            ),
          ],
        )),
        bottomNavigationBar: Obx(
          () => cartController.isLoadingCart.value ||
                  (cartController.cart == null)
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
                        Get.toNamed("/appointment_booking");
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

  Container payment() {
    return kContainer(
        child: Column(
      children: [
        ListTile(
          leading: Radio(
            value: "cod",
            groupValue: "cod",
            onChanged: (value) {},
          ),
          title: const Text("Pay On Pickup"),
        ),
        ListTile(
          leading: Radio(
            value: "online",
            groupValue: "cod",
            onChanged: (value) {},
            activeColor: kGrey.withOpacity(0.3),
          ),
          title: Text(
            "Online Payments",
            style: kTextStyle.copyWith(
              color: kGrey.withOpacity(0.3),
            ),
          ),
        ),
      ],
    ));
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
        borderRadius: BorderRadius.circular(8.0),
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
              onPressed: () {
                cartController.promocodeApply();
              },
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
          hintText: ' Enter your promo',
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

  ListView listViewPackage(CartModel cart) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: cart.cart.packages.length,
      itemBuilder: (BuildContext context, int index) {
        Packages test = cart.cart.packages[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: cartTilePackages(test),
        );
      },
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
                  SizedBox(
                    width: kWidth(60),
                    child: Text(
                      test.name,
                      maxLines: 1,
                      style: kTextStyle.copyWith(
                        overflow: TextOverflow.fade,
                        fontSize: 16,
                        color: kText,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
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

  Container cartTilePackages(Packages test) {
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
                    "",
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
                          hintText: ' Enter Name'),
                      const SizedBox(height: 15),
                      KTextField(
                          controller: patientController.phone,
                          hintText: ' Enter Mobile'),
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
                        child: SizedBox(
                          height: 40,
                          width: double.maxFinite,
                          child: Center(
                            child: Text(
                              "Add Patient",
                              style: kTextStyle.copyWith(color: kWhite),
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
                        hintText: ' Enter Address',
                      ),
                      const SizedBox(height: 15),
                      KTextField(
                        controller: addressController.pincode,
                        hintText: ' Enter Pincode',
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
                        child: SizedBox(
                          height: 40,
                          width: double.maxFinite,
                          child: Center(
                            child: Text(
                              "Add Address",
                              style: kTextStyle.copyWith(color: kWhite),
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
              "${cart.cart.tests.length + cart.cart.packages.length} Items in Total",
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
