import 'package:calendar_scheduler/component/custom_text_field.dart';
import 'package:calendar_scheduler/const/colors.dart';
import 'package:calendar_scheduler/database/drift_database.dart';
import 'package:calendar_scheduler/model/category_color.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';


class ScheduleBottomSheet extends StatefulWidget {
  const ScheduleBottomSheet({Key? key}) : super(key: key);

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();

  int? startTime;   //저장 07   저장할 변수 만들기
  int? endTime;
  String? content;
  int? selectedColorId;      //동그라미 칼라값을 담기위한 변수

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;  //이거는 키보드 올라올때 모달창이 안가려 지도록 하기 위한 변수
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());    //GestureDetector 부분을 클릭했을때 텍스트필드의 포커스가 빠진다.
      },
      child: SafeArea(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height/2 + bottomInset,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomInset),  //이거는 키보드 올라올때 모달창이 안가려 지도록 하기 위한 패딩
            child: Padding(
              padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
              child: Form(               //입력 03 _Time과 _Content에 입력폼이 있으니 위에서 form으로 묶어준다.
                key: formKey,                  //입력 04 form의 컨트롤러
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Time(
                      onStartSaved: (String? val){    //저장 07-1  onStartSaved 입력폼으로 받은값 val로 받기
                        startTime = int.parse(val!);  //저장 08 val값을 int로 파싱하여 startTime에 값넣기
                                                      // ...validator에서 무조건 값을 받게 했으므로 val!으로 할수있다.
                      },
                      onEndSaved: (String? val){
                        endTime = int.parse(val!);
                      },
                    ),
                    SizedBox(height: 16.0,),
                    _Content(
                      onContentSaved: (String? val){
                        content = val;           //String이므로 파싱할 필요없음
                      },
                    ),
                    SizedBox(height: 16.0,),
                    FutureBuilder<List<CategoryColor>>(   //디비값 받기 05 _ColorPicker를 FutureBuilder로 감싸기
                      future: GetIt.I<LocalDatabase>().getCategoryColors(),    //디비값 받기 06   GetIT(세션값같은거) 해주기위해 main.dart로 이동 선언후, GetIt사용가능
                        //<LocalDatabase>이거는 import 'package:calendar_scheduler/database/drift_database.dart'; 해야 사용가능
                      builder: (context, snapshot) {
                        if(snapshot.hasData && selectedColorId == null && snapshot.data!.isNotEmpty){
                          selectedColorId = snapshot.data![0].id;         //처음에는 첫번째칼라 아이디값을 셀렉트해준다.
                        }
                        print(snapshot.data);     //디비값 받기 07 snapshot으로 값이 들어와 출력해 본다.
                        return _ColorPicker(  //디비값 받기 04  colors: []를 넣을 수 있게 해준다.
                          colors: snapshot.hasData       //디비값 받기 08  snapshot.hasData true면 값을 map에 넣어준다.
                              ? snapshot.data! : [],
                          selectedColorId: selectedColorId!,
                        );
                      }
                    ),
                    SizedBox(height: 8.0,),
                    _SaveButton(
                      onPressed: onSavePressed,     //입력 05 저장 버튼 눌렸을대 onSavePressed함수에서 formKey 컨트롤러를 사용한다.
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void onSavePressed(){
    if(formKey.currentState == null){     //입력 06 formKey를 생성했는데 Form위젯과 결합을 안했을때 null값이 있을 수 있다.
      return;
    }
    if(formKey.currentState!.validate()){  //입력 07 custom_text_field에 validator(이동)에서 얘기한 null이면 true 아니면, validator에 있는 String반환
      print('에러가 없습니다.');
      formKey.currentState!.save();   //저장 09  넣은값 저장하기

      print('----저장할 값------');
      print('startTime : $startTime');   //저장 10  넣은값 출력하기
      print('endTime : $endTime');
      print('content : $content');
    }else{
      print('에러가 있습니다.');
    }
  }
}

class _Time extends StatelessWidget {
  final FormFieldSetter<String> onStartSaved;  //저장 05 입력폼에서 받은값 넣기
  final FormFieldSetter<String> onEndSaved;
  const _Time({
    required this.onStartSaved,     //저장 06
    required this.onEndSaved,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: CustomTextField(
              isTime: true,
              label: '시작시간',
              onSaved: onStartSaved, //저장 04 입력폼에서 값 받기
            )
        ),
        SizedBox(width: 16.0,),
        Expanded(
            child: CustomTextField(
              isTime: true,
              label: '마감시간',
              onSaved: onEndSaved,
            )
        ),
      ],
    );
  }
}
class _Content extends StatelessWidget {
  final FormFieldSetter<String> onContentSaved;
  const _Content({
    required this.onContentSaved,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        isTime: false,
        label: '내용',
        onSaved: onContentSaved,
      ),
    );
  }
}
class _ColorPicker extends StatelessWidget {
  final List<CategoryColor> colors;     //디비값 받기 01
  final int selectedColorId;

  const _ColorPicker({
    required this.colors,       //디비값 받기 02
    required this.selectedColorId,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 10.0,
      children: colors.map(
              (e) => renderColor(
                e,
                selectedColorId == e.id,   //이값이 같으면 선택이 된거
              )
      ).toList(),  //디비값 받기 03
    );
  }
  Widget renderColor(CategoryColor color, bool isSelected){    //selectedColorId == e.id 같으면 isSelected가 true
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(
            int.parse('FF${color.hexCode}',   //값넣기
              radix: 16,                  //16진수로 변환
            )
        ),
        border: isSelected
          ? Border.all(
            color: Colors.black,
            width: 4.0,
          )
            : null,
      ),
      width: 32.0,
      height: 32.0,
    );
  }
}
class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _SaveButton({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
              onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              primary: PRIMARY_COLOR,
            ),
              child: Text(
                '저장',
              ),
          ),
        ),
      ],
    );
  }
}


