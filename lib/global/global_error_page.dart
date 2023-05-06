import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/color.dart';
import '../utils/locale_util.dart';
import '../utils/text.dart';
import 'global_appbar.dart';

class GlobalErrorPage extends StatelessWidget {
  const GlobalErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(
        translation(context).error_occur,
        isBack: true,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .1,
            ),
            Container(
              alignment: Alignment.center,
              child: Icon(
                Icons.info_outline_rounded,
                size: 100,
                color: ColorPath.textDisableColor1,
              ),
            ),
            SizedBox(height: 20.w),
            Text(translation(context).error_404,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorPath.textDisableColor1,
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * .05,
            ),
            Text(
              translation(context).error_page_msg,
              textAlign: TextAlign.center,
              style: TextStylePath.base16w600.copyWith(
                color: ColorPath.textDisableColor1,
                height: 2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
