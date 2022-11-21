import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/material.dart';

import 'custom_text_field.dart';

class ScheduleBottomSheet extends StatelessWidget {
  const ScheduleBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //시스템적인 ui때문에 가려진 화면 사이즈
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      color: Colors.white,
      //키보드가 나왔을때 위로 올라가도록 +bottomInset을 해줘야한다.(1)
      height: MediaQuery.of(context).size.height / 2 + bottomInset,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: bottomInset,
          left: 8,
          right: 8,
          top: 16,
        ), //bottom: 키보드 위로 올라가도록(2)
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Time(),
            SizedBox(height: 16),
            _Content(),
            SizedBox(height: 16),
            _ColorPicker(),
            SizedBox(height: 16),
            _SaveButton(),
          ],
        ),
      ),
    );
  }
}

class _Time extends StatelessWidget {
  const _Time({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: CustomTextField(label: '시작 시간')),
        SizedBox(width: 16),
        Expanded(child: CustomTextField(label: '마감 시간')),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: '내용',
    );
  }
}

class _ColorPicker extends StatelessWidget {
  const _ColorPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      //자동으로 줄바꿈
      spacing: 8, //가로 사이간격
      runSpacing: 10, //세로 사이간격
      children: [
        renderColor(
          Color(0xFFA175F6),
        ),
        renderColor(
          Color(0xFF46169E),
        ),
        renderColor(
          Color(0xFF5DA0D9),
        ),
        renderColor(
          Color(0xFF234DA1),
        ),
        renderColor(
          Color(0xFF8CC9A6),
        ),
        renderColor(
          Color(0xFF145742),
        ),
        renderColor(
          Color(0xFFE3D267),
        ),
        renderColor(
          Color(0xFF667619),
        ),
        renderColor(
          Color(0xFFC98CA8),
        ),
        renderColor(
          Color(0xFF821974),
        ),
      ],
    );
  }

  Widget renderColor(Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      width: 32,
      height: 32,
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          //Row로 감싼뒤 Expanded하면 전체를 차지하게 해준다.
          child: ElevatedButton(
            onPressed: () {},
            child: Text('저장'),
            style: ElevatedButton.styleFrom(primary: primaryColor),
          ),
        ),
      ],
    );
  }
}
