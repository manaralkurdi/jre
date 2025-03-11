
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jre_app/base/component/app_custom_text.dart';

import '../../../theme/bloc/theme_bloc/theme_bloc.dart' show StatelessWidget;
import '../../../utils/fontfamily_model.dart';

class CategoryAndSeeAllWidget extends StatelessWidget {
  final String name;
  final String buttonName;

  const CategoryAndSeeAllWidget({
    Key? key,
    required this.name,
    required this.buttonName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 15),
        AppCustomText(titleText:
          name,
          style: TextStyle(
            fontSize: 17,
            fontFamily: FontFamily.gilroyBold,
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
        TextButton(
          onPressed: () {
            if (name == "Featured".tr) {
            //  Get.toNamed(Routes.featuredScreen);
            }
            if (name == "Our Recommendation".tr) {
              // homePageController
              //     .getCatWiseData(cId: "0", countryId: getData.read("countryId"))
              //     .then((value) {
              //   Get.toNamed(Routes.ourRecommendationScreen);
              // });
            }
          },
          child: Text(
            buttonName,
            style: const TextStyle(
              color: Color(0xff3D5BF6),
              fontFamily: FontFamily.gilroyBold,
            ),
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
