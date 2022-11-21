import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  // 시간 - true, 내용 - false
  final bool isTime;
  const CustomTextField({required this.isTime, required this.label, Key? key})
      : super(key: key);

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
    return TextField(
      expands: isTime? false: true,//내용 textfield가 expand되기위해
      maxLines: isTime ? 1 : null, //maxLines를 null로 해줘야 multilline이 작동한다.
      cursorColor: Colors.grey,
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.grey[300],
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
