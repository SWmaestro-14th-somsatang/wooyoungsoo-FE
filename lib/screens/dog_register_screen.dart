import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wooyoungsoo/services/auth_service/auth_service.dart';
import 'package:wooyoungsoo/utils/constants.dart';
import 'package:wooyoungsoo/widgets/common/go_back_button_widget.dart';
import 'package:wooyoungsoo/widgets/dog_register_screen/dog_gender_select_field_widget.dart';
import 'package:wooyoungsoo/widgets/dog_register_screen/dog_weight_input_field_widget.dart';
import 'package:wooyoungsoo/widgets/common/register_button_widget.dart';
import 'package:wooyoungsoo/widgets/dog_register_screen/dog_type_select_field_widget.dart';
import 'package:wooyoungsoo/widgets/common/text_input_field_widget.dart';
import 'package:wooyoungsoo/widgets/dog_register_screen/dog_birth_input_field_widget.dart';

import '../widgets/common/image_picker_button_widget.dart';

/// 강아지 등록 화면
class DogRegisterScreen extends StatefulWidget {
  const DogRegisterScreen({Key? key}) : super(key: key);

  @override
  State<DogRegisterScreen> createState() => _DogRegisterScreenState();
}

/// 강아지 등록 화면의 state
///
/// [_dogTypes] 강아지 종류로 선택가능한 목록
/// [_genderTypes] 강아지 성별로 선택가능한 목록
/// [_neuteredTypes] 강아지 중성화 여부로 선택가능한 목록
/// [_dogName], [_dogType], [_dogGender], [_isNeutered], [_dogBirth] 유저가 입력하는 값
/// [_isReady] 모든 필드가 입력되었는지 여부
class _DogRegisterScreenState extends State<DogRegisterScreen> {
  AuthService authService = AuthService();

  // TODO(Cho-SangHyun): 추후 DB에서 강아지 종류를 받아와야 함
  final List<String> _dogTypes = [
    '프렌치 불독',
    '푸들',
    '시바견',
    '말티즈',
    '치와와',
    '포메라니안',
    '요크셔테리어'
  ];
  final List<String> _genderTypes = ['수컷', '암컷'];

  XFile? _dogImage;
  String? _dogName, _dogType, _dogGender, _dogBirth;
  double? _dogWeight;
  bool _isNeutered = false;
  bool _isReady = false;

  void setImage(XFile pickedFile) {
    setState(() {
      _dogImage = XFile(pickedFile.path);
    });
  }

  void setGenderToMale() {
    setState(() {
      _dogGender = _genderTypes[0];
      checkReady();
    });
  }

  void setGenderToFemale() {
    setState(() {
      _dogGender = _genderTypes[1];
      checkReady();
    });
  }

  void setisNeutered() {
    setState(() {
      _isNeutered = !_isNeutered;
      checkReady();
    });
  }

  /// 모든 필드가 입력됐는지 체크하는 메서드
  bool areAllFieldFilled() {
    return _dogName != null &&
        _dogType != null &&
        _dogGender != null &&
        _dogBirth != null;
  }

  void checkReady() {
    if (areAllFieldFilled()) {
      _isReady = true;
      return;
    }
    _isReady = false;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: screenBackgroundColor,
      appBar: AppBar(
        leading: const GoBackButton(),
        backgroundColor: screenBackgroundColor,
        shadowColor: transparentColor,
        centerTitle: true,
        title: const Text(
          "새 반려견 등록",
          style: TextStyle(
            color: blackColor,
            fontSize: 16,
            fontWeight: fontWeightBold,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.025,
                ),
                ImagePickerButton(
                  setImage: setImage,
                  image: _dogImage,
                ),
                SizedBox(
                  height: screenHeight * 0.025,
                ),
                TextInputField(
                  label: '이름이 무엇인가요?',
                  hintText: '이름 입력',
                  onChanged: (value) {
                    setState(() {
                      _dogName = value.isEmpty ? null : value;
                      if (areAllFieldFilled()) {
                        _isReady = true;
                        return;
                      }
                      _isReady = false;
                    });
                  },
                ),
                DogBirthInputField(
                  label: "생일이 언제인가요?",
                  hintText: "생일 선택",
                  onChanged: (value) {
                    setState(() {
                      _dogBirth = value.isEmpty ? null : value;
                      if (areAllFieldFilled()) {
                        _isReady = true;
                        return;
                      }
                      _isReady = false;
                    });
                  },
                ),
                DogGenderSelectField(
                  screenWidth: screenWidth,
                  dogGender: _dogGender,
                  isNeutered: _isNeutered,
                  setGenderToMale: setGenderToMale,
                  setGenderToFemale: setGenderToFemale,
                  setIsNeutered: setisNeutered,
                ),
                DogWeightInputField(
                  onChanged: (value) {
                    setState(() {
                      _dogWeight = double.tryParse(value);
                      checkReady();
                    });
                  },
                ),
                DogTypeSelectField(
                  items: _dogTypes,
                  onChanged: (value) {
                    setState(() {
                      _dogType = value;
                      if (areAllFieldFilled()) {
                        _isReady = true;
                        return;
                      }
                      _isReady = false;
                    });
                  },
                  width: screenWidth * 0.9,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 60,
                  ),
                  child: RegisterButton(
                    buttonText: "등록하기",
                    isReady: _isReady,
                    onPressed: () async {
                      Map<String, dynamic> data = {
                        "dog_name": _dogName,
                        "dog_type": _dogType,
                        "dog_gender": _dogGender,
                        "is_neutered": _isNeutered,
                        "dog_birth": _dogBirth,
                      };

                      debugPrint("clicked!");
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
