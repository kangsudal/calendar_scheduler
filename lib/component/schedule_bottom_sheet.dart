import 'package:calendar_scheduler/const/colors.dart';
import 'package:calendar_scheduler/database/drift_database.dart';
import 'package:drift/drift.dart' show Value;//Value라는 클래스만 사용하겠다
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'custom_text_field.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final DateTime selectedDay;

  const ScheduleBottomSheet({required this.selectedDay, Key? key})
      : super(key: key);

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();
  int? startTime;
  int? endTime;
  String? content;
  int? selectedColorId;

  @override
  Widget build(BuildContext context) {
    //시스템적인 ui때문에 가려진 화면 사이즈
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode()); //빈 여백을 누르면 키보드가 닫힘
      },
      child: SafeArea(
        child: Container(
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
            child: Form(
              //일괄 관리하려는 TextFormField들의 상위 위젯에 wrap해주면된다
              key: formKey,
              // autovalidateMode:
              //     AutovalidateMode.always, //저장 버튼을 누르지않아도 계속 validation이 된다
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Time(
                    endOnSaved: (String? newValue) {
                      endTime = int.parse(
                          newValue!); //validate를 했기때문에 onSave가 눌리는 시점엔 null값일 수 없기에 !를 붙일 수 있다
                    },
                    startOnSaved: (String? newValue) {
                      startTime = int.parse(newValue!);
                    },
                  ),
                  SizedBox(height: 16),
                  _Content(
                    onSaved: (String? newValue) {
                      content = newValue;
                    },
                  ),
                  SizedBox(height: 16),
                  FutureBuilder<List<CategoryColor>>(
                    future: GetIt.I<LocalDatabase>()
                        .getCategoryColors(), //database 변수를 통해 select쿼리를 실행한다
                    builder: (context, snapshot) {
                      //select 쿼리를 통해 받아온 데이터를 화면에 보여줄 수 있게 바꾼다
                      // print(snapshot.data); : [CategoryColor(idColor: 1, hexCode: A175F6), ...]
                      if (snapshot.hasData && //데이터가 있고
                          selectedColorId ==
                              null && //selectedColorId가 아직 한번도 세팅이 안된 상태이고
                          snapshot.data!.isNotEmpty) {
                        //데이터가 최소한 하나이상 있을때
                        selectedColorId =
                            snapshot.data![0].id; //데이터에 있는 첫번째 값으로 세팅을 한다.
                      }

                      return _ColorPicker(
                        colors: snapshot.hasData ? snapshot.data! : [],
                        selectedColorId:
                            selectedColorId,
                        colorIdSetter: (id) {
                          setState(() {
                            selectedColorId = id;
                          });
                        },
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  _SaveButton(
                    onPressed: onSavePressed,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onSavePressed() async {
    if (formKey.currentState == null) {
      //formKey는 생성했는데 Form Widget과 결합을 안했을때
      return;
    }

    if (formKey.currentState!.validate()) {
      //currentState!인 이유는 바로 위에 null이 아님을 확인했으니까
      //.validate()를 하면 모든 TextFormField의 validator:(String val?){}가 실행된다.
      //하위 TextFormField에서 모두 null이 return되면 true = 모두 에러가 없으면
      formKey.currentState!.save(); //모든 하위 TextFormField의 onSave:함수가 실행된다.
      print('startTime:$startTime');
      print('endTime:$endTime');
      print('content:$content');

      //Future<int> createSchedule이므로 Future를 붙여준다
      final key = await GetIt.I<LocalDatabase>().createSchedule(
        SchedulesCompanion(content: Value(content!),date: Value(widget.selectedDay),startTime: Value(startTime!),endTime: Value(endTime!),colorId: Value(selectedColorId!),),
      );//매개변수로 SchedulesCompanion data를 넘겨주면 테이블에 그 값을 넣어준다.

      print('save 완료: $key');
      Navigator.of(context).pop();
    } else {
      //모든 TextFormField 중에서 하나라도 String값이 리턴되서 에러가 있다고 인식되면 false가 된다.
    }
  }
}

class _Time extends StatelessWidget {
  final FormFieldSetter<String> startOnSaved;
  final FormFieldSetter<String> endOnSaved;
  const _Time({
    Key? key,
    required this.startOnSaved,
    required this.endOnSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: CustomTextField(
          isTime: true,
          label: '시작 시간',
          onSaved: startOnSaved,
        )),
        SizedBox(width: 16),
        Expanded(
            child: CustomTextField(
          isTime: true,
          label: '마감 시간',
          onSaved: endOnSaved,
        )),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  const _Content({required this.onSaved, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        label: '내용',
        isTime: false,
        onSaved: onSaved,
      ),
    );
  }
}

typedef ColorIdSetter = void Function(int id);

class _ColorPicker extends StatelessWidget {
  final List<CategoryColor> colors;
  final int? selectedColorId;
  final ColorIdSetter colorIdSetter;
  const _ColorPicker(
      {required this.colorIdSetter,
      required this.selectedColorId,
      required this.colors,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      //자동으로 줄바꿈
      spacing: 8, //가로 사이간격
      runSpacing: 10, //세로 사이간격
      children: colors
          .map((color) => GestureDetector(
                onTap: () {
                  colorIdSetter(color.id);
                },
                child: renderColor(
                  color,
                  selectedColorId == color.id,
                ),
              ))
          .toList(),
    );
  }

  Widget renderColor(CategoryColor categoryColor, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        color: Color(int.parse('FF${categoryColor.hexCode}', radix: 16)),
        shape: BoxShape.circle,
        border: isSelected ? Border.all(color: Colors.black, width: 4) : null,
      ),
      width: 32,
      height: 32,
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _SaveButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          //Row로 감싼뒤 Expanded하면 전체를 차지하게 해준다.
          child: ElevatedButton(
            onPressed: onPressed,
            child: Text('저장'),
            style: ElevatedButton.styleFrom(primary: primaryColor),
          ),
        ),
      ],
    );
  }
}
