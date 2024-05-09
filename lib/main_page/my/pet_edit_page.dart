import 'package:flutter/material.dart';

class PetEditPage extends StatefulWidget {
  @override
  _PetEditPageState createState() => _PetEditPageState();
}

class _PetEditPageState extends State<PetEditPage> {
  String? _selectedPetType;
  String? _selectedGender;
  String? _selectedNeutered;
  String? _selectedBreed;

  void _selectPetType(String type) {
    setState(() {
      if (_selectedPetType == type) {
        _selectedPetType = null; // 반대쪽을 선택하면 선택 취소
      } else {
        _selectedPetType = type;
      }
    });
  }

  void _selectGender(String gender) {
    setState(() {
      if (_selectedGender == gender) {
        _selectedGender = null; // 반대쪽을 선택하면 선택 취소
      } else {
        _selectedGender = gender;
      }
    });
  }

  void _selectNeutered(String neutered) {
    setState(() {
      if (_selectedNeutered == neutered) {
        _selectedNeutered = null; // 반대쪽을 선택하면 선택 취소
      } else {
        _selectedNeutered = neutered;
      }
    });
  }

  void _selectBreed(String breed) {
    setState(() {
      _selectedBreed = breed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('반려동물 수정'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              // 저장 기능 추가
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PetPhotoSection(),
            SizedBox(height: 20),
            PetNameSection(),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: PetTypeSection(
                    selectedType: _selectedPetType,
                    onTap: _selectPetType,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: PetGenderSection(
                    selectedGender: _selectedGender,
                    onTap: _selectGender,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            PetBreedSection(
              selectedBreed: _selectedBreed,
              onTap: _selectBreed,
            ),
            SizedBox(height: 20),
            PetBirthSection(),
            SizedBox(height: 20),
            PetNeuteredSection(
              selectedNeutered: _selectedNeutered,
              onTap: _selectNeutered,
            ),
          ],
        ),
      ),
    );
  }
}

class PetPhotoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 사진 첨부 기능 추가
      },
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Icon(
            Icons.add_a_photo,
            size: 50,
          ),
        ),
      ),
    );
  }
}

class PetNameSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '반려동물 이름',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextField(
          decoration: InputDecoration(
            hintText: '이름을 입력하세요',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}

class PetBirthSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '생일',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            hintText: '생일을 입력하세요',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}

class PetNeuteredSection extends StatelessWidget {
  final String? selectedNeutered;
  final void Function(String) onTap;

  const PetNeuteredSection({
    required this.selectedNeutered,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '중성화여부',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: PetLabel(
                text: '중성화 완료',
                isSelected: selectedNeutered == '중성화 완료',
                onTap: onTap,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: PetLabel(
                text: '중성화 전',
                isSelected: selectedNeutered == '중성화 전',
                onTap: onTap,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PetTypeSection extends StatelessWidget {
  final String? selectedType;
  final void Function(String) onTap;

  const PetTypeSection({
    required this.selectedType,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '반려동물 종류',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: PetLabel(
                text: '강아지',
                isSelected: selectedType == '강아지',
                onTap: onTap,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: PetLabel(
                text: '고양이',
                isSelected: selectedType == '고양이',
                onTap: onTap,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PetGenderSection extends StatelessWidget {
  final String? selectedGender;
  final void Function(String) onTap;

  const PetGenderSection({
    required this.selectedGender,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '성별',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: PetLabel(
                text: '남아',
                isSelected: selectedGender == '남아',
                onTap: onTap,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: PetLabel(
                text: '여아',
                isSelected: selectedGender == '여아',
                onTap: onTap,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PetBreedSection extends StatelessWidget {
  final String? selectedBreed;
  final void Function(String) onTap;

  const PetBreedSection({
    required this.selectedBreed,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '품종',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            // 팝업창 띄우기 기능 추가
          },
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedBreed ?? '품종을 선택하세요',
                  style: TextStyle(color: Colors.black),
                ),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PetLabel extends StatelessWidget {
  final String text;
  final bool isSelected;
  final void Function(String) onTap;

  const PetLabel({
    required this.text,
    required this.isSelected,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(text),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
