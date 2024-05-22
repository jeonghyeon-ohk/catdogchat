import 'package:flutter/material.dart';
import 'hospital_info_page.dart';
import 'hospital_detail_page.dart';
import '../../const/hospital_data.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<Hospital> _searchResults = [];

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
            padding: EdgeInsets.all(screenHeight * 0.02), // 2%의 높이로 패딩 설정
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
            child: _searchController.text.isEmpty
                ? ListView.builder(
              itemCount: hospitals.length,
              itemBuilder: (context, index) {
                final hospital = hospitals[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            HospitalDetailPage(hospital: hospital),
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(hospital.imageUrl),
                  ),
                  title: Text(
                    hospital.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '운영시간: ${hospital.businessHours}\n주소: ${hospital.address}',
                      ),
                      Text('거리: ${hospital.distance}'),
                    ],
                  ),
                  trailing: Text(hospital.reservationAvailable
                      ? '예약 가능'
                      : '예약 불가'),
                );
              },
            )
                : _searchResults.isEmpty
                ? Center(child: Text('검색 결과 없음'))
                : ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final hospital = _searchResults[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HospitalDetailPage(
                          hospital: hospital,
                        ),
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(hospital.imageUrl),
                  ),
                  title: Text(
                    hospital.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '운영시간: ${hospital.businessHours}\n주소: ${hospital.address}',
                      ),
                      Text('거리: ${hospital.distance}'),
                    ],
                  ),
                  trailing: Text(hospital.reservationAvailable
                      ? '예약 가능'
                      : '예약 불가'),
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
      _searchResults = hospitals
          .where((hospital) =>
          hospital.name.toLowerCase().contains(query))
          .toList();
    });
  }
}
