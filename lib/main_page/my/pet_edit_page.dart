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
      _selectedPetType = (_selectedPetType == type) ? null : type;
    });
  }

  void _selectGender(String gender) {
    setState(() {
      _selectedGender = (_selectedGender == gender) ? null : gender;
    });
  }

  void _selectNeutered(String neutered) {
    setState(() {
      _selectedNeutered = (_selectedNeutered == neutered) ? null : neutered;
    });
  }

  void _selectBreed(String breed) {
    setState(() {
      _selectedBreed = breed;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('반려동물 수정', style: TextStyle(fontSize: screenWidth * 0.05)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.save, size: screenWidth * 0.07),
            onPressed: () {
              // 저장 기능 구현
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PetPhotoSection(),
            SizedBox(height: screenWidth * 0.05),
            PetNameSection(),
            SizedBox(height: screenWidth * 0.05),
            Row(
              children: [
                Expanded(
                  child: PetTypeSection(
                    selectedType: _selectedPetType,
                    onTap: _selectPetType,
                  ),
                ),
                SizedBox(width: screenWidth * 0.04),
                Expanded(
                  child: PetGenderSection(
                    selectedGender: _selectedGender,
                    onTap: _selectGender,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenWidth * 0.05),
            PetBreedSection(
              selectedBreed: _selectedBreed,
              onTap: _selectBreed,
            ),
            SizedBox(height: screenWidth * 0.05),
            PetBirthSection(),
            SizedBox(height: screenWidth * 0.05),
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

// 각 섹션의 위젯 구현 예제
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
        Text('반려동물 이름', style: TextStyle(fontWeight: FontWeight.bold)),
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

class PetTypeSection extends StatelessWidget {
  final String? selectedType;
  final Function(String) onTap;

  PetTypeSection({this.selectedType, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('반려동물 종류', style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => onTap('강아지'),
                child: Container(
                  decoration: BoxDecoration(
                    color: selectedType == '강아지' ? Colors.blue : Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Center(child: Text('강아지', style: TextStyle(color: selectedType == '강아지' ? Colors.white : Colors.black))),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: GestureDetector(
                onTap: () => onTap('고양이'),
                child: Container(
                  decoration: BoxDecoration(
                    color: selectedType == '고양이' ? Colors.blue : Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Center(child: Text('고양이', style: TextStyle(color: selectedType == '고양이' ? Colors.white : Colors.black))),
                ),
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
  final Function(String) onTap;

  PetGenderSection({this.selectedGender, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('성별', style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => onTap('Male'),
                child: Container(
                  decoration: BoxDecoration(
                    color: selectedGender == 'Male' ? Colors.blue : Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text('남아', style: TextStyle(color: selectedGender == 'Male' ? Colors.white : Colors.black)),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: GestureDetector(
                onTap: () => onTap('Female'),
                child: Container(
                  decoration: BoxDecoration(
                    color: selectedGender == 'Female' ? Colors.blue : Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text('여아', style: TextStyle(color: selectedGender == 'Female' ? Colors.white : Colors.black)),
                ),
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
  final Function(String) onTap;

  PetBreedSection({this.selectedBreed, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('품종', style: TextStyle(fontWeight: FontWeight.bold)),
        GestureDetector(
          onTap: () => onTap('품종 선택'),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(selectedBreed ?? '품종을 선택하세요', style: TextStyle(color: Colors.black)),
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
        Text('생일', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000), // 조정 가능
              lastDate: DateTime.now(),
            );
            if (pickedDate != null) {
              // 선택된 날짜 처리
            }
          },
          child: AbsorbPointer(
            child: TextField(
              decoration: InputDecoration(
                hintText: '생일을 입력하세요',
                suffixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PetNeuteredSection extends StatelessWidget {
  final String? selectedNeutered;
  final Function(String) onTap;

  PetNeuteredSection({this.selectedNeutered, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('중성화 여부', style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => onTap('Neutered'),
                child: Container(
                  decoration: BoxDecoration(
                    color: selectedNeutered == 'Neutered' ? Colors.blue : Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text('중성화 완료', style: TextStyle(color: selectedNeutered == 'Neutered' ? Colors.white : Colors.black)),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: GestureDetector(
                onTap: () => onTap('Not Neutered'),
                child: Container(
                  decoration: BoxDecoration(
                    color: selectedNeutered == 'Not Neutered' ? Colors.blue : Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text('중성화 전', style: TextStyle(color: selectedNeutered == 'Not Neutered' ? Colors.white : Colors.black)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}