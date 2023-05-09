import 'dart:math';
import 'dart:typed_data';

import 'package:fake_call/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactPickerView extends StatefulWidget {
  const ContactPickerView({super.key});

  @override
  State<ContactPickerView> createState() => _ContactPickerViewState();
}

class _ContactPickerViewState extends State<ContactPickerView> {
  ///검색어
  late TextEditingController _searchController;
  late FocusNode _searchFocusNode;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: Text(
            '연락처 가져오기',
            style: TextStylePath.title20w800,
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
            ),
            onPressed: () {
              context.pop({'name': '', 'number': ''});
            },
          ),
        ),
        body: _body(),
      ),
    );
  }

  /// body
  Widget _body() {
    return Column(
      children: [
        _searchBar(),
        _contactList(),
      ],
    );
  }

  /// 검색 바 위젯
  Widget _searchBar() {
    return Container(
      margin: EdgeInsets.only(right: 12.w, left: 12.w),
      height: 36.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: TextFormField(
        controller: _searchController,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            vertical: 10.w,
            horizontal: 10.w,
          ),
          hintText: '검색',
          hintStyle: TextStylePath.base16w400,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
            size: 20.sp,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              _searchController.clear();
            },
            icon: Icon(
              Icons.cancel,
              size: 20.sp,
            ),
          ),
        ),
        onChanged: (_) {
          setState(() {});
        },
      ),
    );
  }

  /// 결과 리스트 위젯
  Widget _contactList() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
          left: 12.w,
          right: 12.w,
        ),
        child: FutureBuilder(
          future: getFilteredContacts(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: SizedBox(
                  height: 50.h,
                  width: 50.w,
                  child: const CircularProgressIndicator(),
                ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                Contact contact = snapshot.data[index];

                String initial =
                    getWordInitials(contact.name.last + contact.name.first);

                //index == 0 일 때는 비교할 데이터 없음.
                if (index == 0) {
                  return _contactTileWithLabel(contact, initial);
                }

                String preInitial = getWordInitials(
                    snapshot.data[index - 1].name.last +
                        snapshot.data[index - 1].name.first);

                // 알파벳 labels와 매치되는지 체크
                if (initial != preInitial) {
                  // 알파벳 라벨과 연락처타일 보여주기
                  return _contactTileWithLabel(contact, initial);
                } else {
                  // 알파벳 라벨없는 연락처타일 보여주기
                  return _contactTile(contact);
                }
              },
            );
          },
        ),
      ),
    );
  }

  ///초성 라벨과 연락처 타일
  Widget _contactTileWithLabel(Contact contact, String initial) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        Text(
          initial,
          style: TextStylePath.base16w600,
        ),
        SizedBox(height: 8.h),
        _contactTile(contact),
      ],
    );
  }

  ///연락처 타일
  Widget _contactTile(Contact contact) {
    Uint8List? image = contact.photo;
    return InkWell(
      onTap: () {
        ///연락처 리턴
        context.pop({
          'name': (contact.name.last + contact.name.first).isNotEmpty
              ? '${contact.name.last} ${contact.name.first}'
              : 'contact.phones.first.number',
          'number': contact.phones.first.number,
        });
      },
      child: Container(
        margin: EdgeInsets.only(top: 4.h, bottom: 4.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: ListTile(
          /// 프로필 사진
          leading: CircleAvatar(
            radius: 20,
            child: image != null
                ? CircleAvatar(
                    backgroundImage: MemoryImage(image),
                  )
                : const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
          ),

          /// 이름
          title: Text(
            '${contact.name.last} ${contact.name.first}',
            style: TextStylePath.base16w400,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 전화번호
              Text(
                contact.phones.first.number,
                style: TextStylePath.base16w400,
              ),
            ],
          ),
        ),
      ),
    );
  }

// Override ▼ ==========================================
  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();

    super.dispose();
  }

// Function ▼ ==========================================

  /// 연락처를 가져온다.
  Future<List<Contact>> getContacts() async {
    bool isGranted = await Permission.contacts.status.isGranted;

    if (isGranted) {
      return await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);
    } else {
      isGranted = await Permission.contacts.request().isGranted;
      return [];
    }
  }

  /// 필터링된 연락처를 가져온다.
  Future<List<Contact>> getFilteredContacts() async {
    try {
      List<Contact> list = await getContacts();

      return list
          .where((contact) => (contact.name.last + contact.name.first)
              .contains(_searchController.text))
          .toList();
    } catch (e) {
      Logger().d(e);
    }
    return [];
  }

  ///가장 앞 글자의 초성을 가져온다.
  String getWordInitials(String word) {
    final initials = StringBuffer();
    for (int i = 0; i < word.length; i++) {
      final charCode = word.codeUnitAt(i);
      if (charCode >= 0xAC00 && charCode <= 0xD7A3) {
        // 한글 범위 체크
        final engCode = charCode - 0xAC00;
        final firstCode = (engCode / 28 / 21).toInt(); // 초성 계산
        initials.write(String.fromCharCode(firstCode + 0x1100));
      } else {
        initials.write(word[i]); // 한글이 아닌 경우 그대로 저장
      }
    }
    return initials.toString().isNotEmpty ? initials.toString()[0] : '';
  }
}
