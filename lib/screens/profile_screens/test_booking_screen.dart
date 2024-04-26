import 'package:flutter/material.dart';
import 'package:hvdc_user/utils/colors.dart';
import 'package:hvdc_user/utils/img_name.dart';
import 'package:hvdc_user/utils/style.dart';

class TestBookingScreen extends StatelessWidget {
  const TestBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.shopping_cart_outlined,
              size: 30,
            ),
          )
        ],
        leadingWidth: 20,
        title: Text(
          "Test Booking",
          style: kTextStyle.copyWith(
            fontSize: 25,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 225, 224, 224)
                        .withOpacity(0.5), // Shadow color
                    spreadRadius: 1, // Spread radius
                    blurRadius: 2, // Blur radius
                    offset: const Offset(0, 2), // Offset in x and y directions
                  ),
                ], color: kWhite, borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 100,
                          width: 100,
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            child: Image(
                              image: NetworkImage(
                                'https://media.them.us/photos/5ca391a6b9aba0ee4c0bc2d6/1:1/w_1279,h_1279,c_limit/RUSSELL.jpg',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Covid RT PCR - SWAB",
                              style: kTextStyle.copyWith(
                                fontSize: 22,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "1 Tests",
                              style: kTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text.rich(
                              TextSpan(
                                text: '\$20 ',
                                style: kTextStyle.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '\$32.73',
                                    style: kTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'About Test',
                      textAlign: TextAlign.start,
                      style: kTextStyle.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Our Coronavirus COVID-19 RT-PCR Test utilizes the highly accurate Reverse Transcription-Polymerase Chain Reaction (RT-PCR) technique for the swift and precise detection of the virus. If you’re experiencing COVID-19 symptoms, have travelled to high prevelence areas, or come in contact with a positive case.',
                      textAlign: TextAlign.start,
                      style: kTextStyle.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Image(image: AssetImage(addCircle)),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Add More Text',
                            style: kTextStyle.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: kGreen),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              textImageWidget('Sample Pickup', locationIcon),
              const SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 225, 224, 224)
                        .withOpacity(0.5), // Shadow color
                    spreadRadius: 1, // Spread radius
                    blurRadius: 2, // Blur radius
                    offset: const Offset(0, 2), // Offset in x and y directions
                  ),
                ], color: kWhite, borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        '140 Haryana Estate Drive, Gurgaon, Delhi, India',
                        style: kTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const Image(image: AssetImage(locatorIcon)),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              textImageWidget('Promo Code', promoCode),
              const SizedBox(
                height: 15,
              ),
              Container(
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
                      offset:
                          const Offset(0, 2), // Offset in x and y directions
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
                            fontSize: 18,
                            color: kGreen,
                          ),
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
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kGreen,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 20), // Button padding
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Button border radius
                    ),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Add to Cart",
                        style: kTextStyle.copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                            color: kWhite),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: kLightButtonGreen, // Background color
                          borderRadius: BorderRadius.circular(
                              8.0), // Optional: Add border radius for rounded corners
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4.0), // Padding for the container
                        child: Text(
                          '\$87.89',
                          style: kTextStyle.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: kWhite,
                          ),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

Row textImageWidget(String heading, String headImage) {
  return Row(
    children: [
      Image(image: AssetImage(headImage)),
      const SizedBox(
        width: 10,
      ),
      Text(
        heading,
        style: kTextStyle.copyWith(
            fontSize: 16, color: kText, fontWeight: FontWeight.w500),
      )
    ],
  );
}
