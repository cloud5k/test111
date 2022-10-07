import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isTime;    //true면 시간 false면 내용
  final FormFieldSetter<String> onSaved;  //저장 02
  const CustomTextField({
    required this.label,
    required this.isTime,
    required this.onSaved,     //저장 03  schedule_bottom_sheet로 이동
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: PRIMARY_COLOR,
            fontWeight: FontWeight.w600,
          ),
        ),
        if(isTime) renderTextField(),
        if(!isTime) Expanded(child: renderTextField()),
      ],
    );
  }
  Widget renderTextField(){
    return TextFormField(             //입력 01 TextFormField사용
      onSaved: onSaved,        //저장 01 저장버튼클릭시 외부에서 값을 가져올 거임.
      //null이 return되면 에러가 없다. 에러가 있으면 String값으로 리턴해준다.
      validator: (String? val){       //입력 02 schedule_bottom_sheet(이동) 에서 모든 input들을 Form으로 묶어준다.
        if(val == null || val.isEmpty){    //입력 08끝 입력폼에 입력하지 않았을때 '값을 입력해주세요.' String값을 리턴해준다. 아니면 true
          return '값을 입력해주세요.';
        }
        if(isTime){                   //isTime에 값이 있으면
          int time = int.parse(val);  //val값을 int로 파싱한다.
          if(time < 0){
            return '0 이상의 숫자를 입력하세요.';
          }
          if(time > 24){
            return '24 이하의 숫자를 입력하세요.';
          }
        }else{
          if(val.length > 500){
            return '500자 이하릐 글을 입력해주세요';
          }
        }
        return null;
      },
      cursorColor: Colors.grey,
      maxLength: 500,  //500자 이하 출력
      expands: isTime ? false : true,   //expands 값이 true면 TextField를 최대한 넓게 해준다.
      maxLines: isTime ? 1 : null,   //줄바꿈 옵션.. null이면 계속 줄바꿈됨. 1이면 줄바꿈 안됨.ㄴ
      keyboardType: isTime ? TextInputType.number : TextInputType.multiline, //true면 숫자 키보드 false면 내용키보드가 나옴
      inputFormatters: isTime ? [
        FilteringTextInputFormatter.digitsOnly,    //digitsOnly 숫자만 써짐. 다른건 안써짐
      ] : [],  //false면 옵션이 없음.
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,             //배경색을 넣을수 있다.
        fillColor: Colors.grey[200],
      ),
    );
  }
}
