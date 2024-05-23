import 'package:flutter/material.dart';
import '../../const/hospital_data.dart';
import 'hospital_detail_page.dart';
import 'load_hospital_data.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<Hospital> _searchResults = [];
  List<Hospital> _allHospitals = []; // 모든 병원 데이터를 저장할 리스트

  @override
  void initState() {
    super.initState();
    loadHospitalData(); // 데이터 로딩
  }

  // 병원 데이터 로딩 함수
  void loadHospitalData() async {
    _allHospitals = await loadCsvData();
    setState(() {
      _searchResults = _allHospitals; // 초기 상태에 모든 병원을 표시
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('병원 검색'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(screenHeight * 0.02),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: '병원 이름 검색',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _performSearch,
                ),
              ),
              onChanged: (value) {
                _performSearch();
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final hospital = _searchResults[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HospitalDetailPage(hospital: hospital),
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(hospital.imageUrl),
                  ),
                  title: Text(hospital.name, style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('운영시간: ${hospital.businessHours}\n주소: ${hospital.address}'),
                      Text('거리: ${hospital.distance}'),
                    ],
                  ),
                  trailing: Text(hospital.reservationAvailable ? '예약 가능' : '예약 불가'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _performSearch() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _searchResults = _allHospitals
          .where((hospital) => hospital.name.toLowerCase().contains(query)).toList();
    });
  }
}