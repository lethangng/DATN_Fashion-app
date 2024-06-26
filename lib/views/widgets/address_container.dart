// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../app/routes.dart';
import '../../models/home_models/delivery_address.dart';
import '../../utils/color_app.dart';
import '../../view_models/tab_view_models/bag_tab_view_models/address_viewmodel.dart';

// enum AddressType {
//   pay,
//   address,
// }

class AddressContainer extends StatelessWidget {
  AddressContainer({
    super.key,
    required this.address,
    // required this.addressType,
  });

  final DeliveryAddress address;
  // final AddressType addressType;
  final AddressController _addressController = Get.find<AddressController>();

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (_) async =>
                await _addressController.handleLoadDeleteAddress(address),
            backgroundColor: ColorApp.primary,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Xóa',
          ),
        ],
      ),
      child: container(),
    );
  }

  Widget container() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 28,
        vertical: 18,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 25,
            offset: const Offset(0, 1),
            color: const Color(0xFF000000).withOpacity(0.08),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      address.fullname,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: ColorApp.black,
                      ),
                    ),
                    const Text(' | '),
                    Text(
                      address.phone_number,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: ColorApp.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/location.svg'),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        address.address,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: ColorApp.black,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: Checkbox(
                            value: address.is_select == 1,
                            activeColor: ColorApp.black,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onChanged: (value) {
                              _addressController.handleLoadUpdateAddredd(
                                address: address,
                                isSelect: value == true ? 1 : 0,
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 13),
                        const Text(
                          'Sử dụng làm địa chỉ mặc định',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: ColorApp.black,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => Get.toNamed(
              Routes.addAddress,
              arguments: {'address': address},
            ),
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              foregroundColor: ColorApp.primary,
            ),
            child: const Text(
              'Sửa',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
