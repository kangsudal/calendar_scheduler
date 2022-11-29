import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String initialValue;

  // 시간 - true, 내용 - false
  final bool isTime;
  final FormFieldSetter<String> onSaved;
  const CustomTextField({
    required this.isTime,
    required this.label,
    required this.onSaved,
    required this.initialValue,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600),
        ),
        if (isTime) renderTextField(),
        if (isTime == false) Expanded(child: renderTextField()),
      ],
    );
  }

  Widget renderTextField() {
    return TextFormField(
      onSaved: onSaved, //상위 위젯 Form에서 save()가 불리면 실행된다.
      validator: (String? value) {
        //null이 return되면 에러가없다.
        //에러가 있으면 에러를 String값으로 리턴해준다.
        //String값이 return되면 그걸 에러메세지로 간주한다. 그래서 에러메세지를 화면에 보여줄 수 있다.
        if (value == null || value.isEmpty) {
          return '값을 입력해주세요.';
        }
        if (isTime) {
          //시간(시작,마감) TextFormField면
          int time = int.parse(value); //digitsOnly이니까 int 변경 가능하다

          if (time < 0) {
            return '0 이상의 숫자를 입력해주세요.';
          } else if (time > 24) {
            return '24 이하의 숫자를 입력해주세요.';
          }
        } else {
          //내용 TextFormField면

        }
        return null;
      },
      expands: isTime ? false : true, //내용 textfield가 expand되기위해
      maxLines: isTime ? 1 : null, //maxLines를 null로 해줘야 multilline이 작동한다.
      maxLength: 500, //글자 제한수 500
      cursorColor: Colors.grey,
      initialValue: initialValue, //외부에서 받아온다.
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.grey[300],
        suffixText: isTime ? '시' : null,
      ),
      keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
      inputFormatters: isTime
          ? [
              FilteringTextInputFormatter.digitsOnly,
            ]
          : [],
    );
  }
}
