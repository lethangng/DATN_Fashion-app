// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/home_models/cart.dart';
import '../../utils/color_app.dart';
import '../../utils/text_themes.dart';
import 'image_container.dart';

class ProductDetailHistory extends StatelessWidget {
  const ProductDetailHistory({
    super.key,
    required this.bagModel,
  });
  final Cart bagModel;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageContainer(
              image: bagModel.image_url,
              width: Get.width * 0.3,
              replaceImage: '',
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(11),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          bagModel.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: ColorApp.black,
                          ),
                        ),
                        // const SizedBox(height: 2),
                        Text(
                          bagModel.brand,
                          style: TextThemes.textGray_11_400,
                        ),
                        const SizedBox(height: 7),
                        Row(
                          children: [
                            rowInfo(
                              title: 'Màu sắc: ',
                              value: bagModel.color.name,
                            ),
                            const SizedBox(width: 22),
                            rowInfo(
                              title: 'Kích thước: ',
                              value: bagModel.color.name,
                            ),
                          ],
                        ),
                        const SizedBox(height: 11),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            rowInfo(
                                title: 'Số lượng: ',
                                value: '${bagModel.quantity}'),
                            Text(
                              '${bagModel.quantity}\$',
                              style: TextThemes.text_14_500,
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget rowInfo({
    required String title,
    required String value,
  }) {
    return RichText(
      text: TextSpan(
        text: title,
        style: TextThemes.textGray_11_400,
        children: [
          TextSpan(
            text: value,
            style: TextThemes.textGray_11_400.copyWith(color: ColorApp.black),
          )
        ],
      ),
    );
  }
}
