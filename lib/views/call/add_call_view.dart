import 'dart:io';

import 'package:fake_call/routes/app_page.dart';
import 'package:fake_call/services/permission_service.dart';
import 'package:fake_call/utils/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

///TODO:
///UI 예쁘게 다듬고
///검색기능
///정렬기능

class AddCallView extends StatefulWidget {
  const AddCallView({super.key});

  @override
  State<AddCallView> createState() => _AddCallViewState();
}

class _AddCallViewState extends State<AddCallView> {
  /// time picker로 가져온 시간
  DateTime _dateTime = DateTime.now();

  /// 이름 입력
  late final TextEditingController _nameController;
  late final FocusNode _nameFocusNode;

  /// 전화번호 입력
  late final TextEditingController _numberController;
  late final FocusNode _numberFocusNode;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(
          children: [
            _setTime(),
            _setCallSetting(),
          ],
        ),
        bottomNavigationBar: _bottomButton(),
      ),
    );
  }

  /// 시간 설정 위젯
  Widget _setTime() {
    return Center(
      child: Container(
        height: 200.h,
        margin: EdgeInsets.only(
          top: 40.h,
          bottom: 10.h,
        ),
        child: CupertinoDatePicker(
          initialDateTime: _dateTime,
          mode: CupertinoDatePickerMode.time,
          minuteInterval: 10,
          onDateTimeChanged: (DateTime value) {},
        ),
      ),
    );
  }

  /// 전화 설정 위젯
  Widget _setCallSetting() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 12.w, right: 12.w),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              _whoIsThis(),
              SizedBox(
                height: 12.h,
              ),
              _setCallEtc(),
            ],
          ),
        ),
      ),
    );
  }

  /// 누구에게 걸어온건지(이름, 전화번호, 프로필 사진)
  Widget _whoIsThis() {
    return Container(
      padding: EdgeInsets.only(
        top: 12.h,
        bottom: 12.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// 이름
          TextFormField(
            focusNode: _nameFocusNode,
            controller: _nameController,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                vertical: 10.w,
                horizontal: 10.w,
              ),
              hintText: '이름',
              hintStyle: TextStylePath.base16w400,
              suffixIcon: IconButton(
                onPressed: () async {
                  if (await PermissionService().handlePermissionContacts()) {
                    final result =
                        await context.pushNamed(APP_PAGE.addCantact.toName);

                    final Map<String, dynamic> resultMap =
                        result as Map<String, dynamic>;

                    _nameController.text = resultMap['name'];
                    _numberController.text = resultMap['number'];
                  } else {
                    await PermissionService().handlePermissionReRequest();
                  }
                },
                icon: Icon(
                  Icons.person_search_rounded,
                  color: Colors.grey,
                  size: 20.sp,
                ),
              ),
            ),
          ),
          const Divider(),

          /// 전화번호
          TextFormField(
            focusNode: _numberFocusNode,
            controller: _numberController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                vertical: 10.w,
                horizontal: 10.w,
              ),
              hintText: '전화 번호',
              hintStyle: TextStylePath.base16w400,
            ),
          ),
        ],
      ),
    );
  }

  /// 기타 설정(음성녹음, 전화 화면 테마)
  Widget _setCallEtc() {
    return Container(
      height: 60.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Row(
        children: [
          /// 음성 추가
          Expanded(
            child: InkWell(
              onTap: () {},
              child: ListTile(
                title: Text(
                  '음성 추가',
                  style: TextStylePath.base16w400,
                ),
                leading: const Icon(Icons.speaker_notes_rounded),
              ),
            ),
          ),
          const VerticalDivider(),

          /// 테마 선택
          Expanded(
            child: InkWell(
              onTap: () {},
              child: ListTile(
                title: Text(
                  '테마 선택',
                  style: TextStylePath.base16w400,
                ),
                leading: const Icon(Icons.mobile_friendly_rounded),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 하단 버튼 위젯
  Widget _bottomButton() {
    return SizedBox(
      height: 60.h,
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                }
              },
              child: Text(
                '취소',
                style: TextStylePath.title18w600,
              ),
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {},
              child: Text(
                '저장',
                style: TextStylePath.title18w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Override ▼ ========================================
  @override
  void initState() {
    super.initState();

    _dateTime = getDateTime();

    _nameController = TextEditingController();
    _nameFocusNode = FocusNode();

    _numberController = TextEditingController();
    _numberFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameFocusNode.dispose();

    _numberController.dispose();
    _numberFocusNode.dispose();

    super.dispose();
  }

  // Function ▼ ==========================================
  /// 10분 단위로 시간을 가져옴. 현재시간 기준.
  DateTime getDateTime() {
    final now = DateTime.now();

    return DateTime(now.year, now.month, now.day, now.hour, 0);
  }
}
