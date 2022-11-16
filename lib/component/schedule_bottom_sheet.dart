import 'package:flutter/material.dart';

class ScheduleBottomSheet extends StatelessWidget {
  const ScheduleBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //시스템적인 ui때문에 가려진 화면 사이즈
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      color: Colors.white,
      //키보드가 나왔을때 위로 올라가도록 +bottomInset을 해줘야한다.(1)
      height: MediaQuery.of(context).size.height/2+bottomInset,
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomInset),//키보드 위로 올라가도록(2)
        child: Column(
          children: [
            TextField(),
          ],
        ),
      ),
    );
  }
}
