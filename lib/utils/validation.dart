//& 이메일 포맷 검증
bool isValidEmailFormat(String value) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value);
}

//& 대쉬를 포함하는 010 휴대폰 번호 포맷 검증 (01012345678)
bool isValidPhoneNumberFormat(String valiue) {
  return RegExp(r'^010?([0-9]{4})?([0-9]{4})$').hasMatch(valiue);
}

//& 비밀번호 포맷검증 *(최소 6자, 최대 16자,  문자 >= 1, 숫자 >= 1, 특수문자 >= 1)
bool isValidPasswordFormat(String value) {
  return RegExp(
          r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&~])[A-Za-z\d@$!%*#?&~]{6,16}$")
      .hasMatch(value);
}
