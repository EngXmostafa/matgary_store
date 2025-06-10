

import 'package:flutter/material.dart';

import '../../../../../../core/theme/_index.dart';

class BrandTile extends StatelessWidget {
  const BrandTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      decoration: BoxDecoration(

        color: AppColors.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Text('Brand',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      ),
    );
  }
}
