import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../../../services/response/api_status.dart';
import '../../../../utils/color_app.dart';
import '../../../../view_models/tab_view_models/shop_tab_view_models/list_product_viewmodel.dart';
import '../../../widgets/list_empty.dart';
import '../../../widgets/loadmore.dart';
import '../../../widgets/product_container.dart';
import '../../../widgets/show_dialog_error.dart';

class ListProductScreen extends StatelessWidget {
  ListProductScreen({super.key});

  final ListProductViewmodel _listProductViewmodel =
      Get.put(ListProductViewmodel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          _listProductViewmodel.title,
          style: const TextStyle(
            fontSize: 18,
            color: Color(0xFF222222),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (_listProductViewmodel.productRes.value.status == Status.error) {
          showDialogError(
              error: _listProductViewmodel.productRes.value.message!);
        }

        if (_listProductViewmodel.productRes.value.status == Status.completed) {
          return Loadmore(
            refreshController: _listProductViewmodel.refreshController,
            onLoading: _listProductViewmodel.onLoading,
            onRefresh: _listProductViewmodel.onRefresh,
            widget: _listProductViewmodel.listProduct.isEmpty
                ? const ListEmpty()
                : MasonryGridView.count(
                    padding: const EdgeInsets.all(16),
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 16,
                    itemCount: _listProductViewmodel.listProduct.length,
                    itemBuilder: (context, index) {
                      return ProductContainer(
                        product: _listProductViewmodel.listProduct[index],
                        productType: ProductType.product,
                      );
                    },
                  ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            color: ColorApp.primary,
          ),
        );
      }),
    );
  }
}
