import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import '../../const/hospital_data.dart';
import 'hospital_detail_page.dart';
import 'package:url_launcher/url_launcher.dart'; // 전화 기능을 위해 추가

class SearchPage extends StatefulWidget {
  final List<Hospital> hospitals;
  final NLatLng currentPosition;

  SearchPage({required this.hospitals, required this.currentPosition});

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
    _allHospitals = widget.hospitals; // 초기 상태에 MapPage에서 전달된 병원 데이터를 설정
    _searchResults = _allHospitals;
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $launchUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'asset/img/logo2.png',
              fit: BoxFit.contain,
              height: screenWidth * 0.07,
            ),
            SizedBox(width: screenWidth * 0.02),
            Text('병원 검색', style: TextStyle(fontSize: screenWidth * 0.05)),
          ],
        ),
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
                      Text('주소: ${hospital.address}'),
                      Text('거리: ${hospital.distance}'),
                      Text('전화번호: ${hospital.phoneNumber}'),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.phone),
                    onPressed: () => _makePhoneCall(hospital.phoneNumber),
                  ),
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
          .where((hospital) => hospital.name.toLowerCase().contains(query))
          .toList();
    });
  }
}
