import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'hospital_info_page.dart';
import 'search_page.dart';
import '../../const/hospital_data.dart'; // 병원 데이터 모델을 사용하기 위한 임포트
import 'load_hospital_data.dart'; // 병원 데이터 로드 함수를 사용하기 위한 임포트
import 'hospital_detail_page.dart'; // 병원 상세 페이지로 이동하기 위한 임포트

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<NaverMapController> mapControllerCompleter = Completer();
  NaverMapController? _mapController;
  Position? _currentPosition;
  late StreamSubscription<Position> _positionStreamSubscription;
  List<Hospital> allHospitals = []; // 전체 병원 데이터를 저장할 리스트
  List<Hospital> hospitals = []; // 현재 보이는 지도 영역의 병원 데이터를 저장할 리스트

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  void checkPermission() async {
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      throw Exception('위치 기능을 활성화 해주세요.');
    }

    LocationPermission checkedPermission = await Geolocator.checkPermission();
    if (checkedPermission == LocationPermission.denied) {
      checkedPermission = await Geolocator.requestPermission();
    }
    if (checkedPermission != LocationPermission.always &&
        checkedPermission != LocationPermission.whileInUse) {
      throw Exception('위치 권한을 허가 해주세요.');
    }

    _getCurrentLocation();
    _startListeningLocationChanges();
  }

  void _startListeningLocationChanges() {
    final locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );

    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen((Position position) {
      setState(() {
        _currentPosition = position;
      });
      _updateCameraPosition(position);
    });
  }

  void _updateCameraPosition(Position position) async {
    if (_mapController != null) {
      _mapController!.updateCamera(
        NCameraUpdate.withParams(
          target: NLatLng(position.latitude, position.longitude),
          zoom: 13,
        ),
      );
    }
  }

  void _getCurrentLocation() async {
    try {
      _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        if (_currentPosition != null) {
          final currentLatLng = NLatLng(_currentPosition!.latitude, _currentPosition!.longitude);
          loadHospitals(currentLatLng);
        }
      });
    } catch (e) {
      print('위치를 가져오는데 실패했습니다: $e');
    }
  }

  void loadHospitals(NLatLng currentPosition) async {
    try {
      allHospitals = await loadCsvData(currentPosition);
      setState(() {});
      _filterHospitalsInView(); // 지도를 로드할 때도 화면에 보이는 병원만 필터링
    } catch (e) {
      print('병원 데이터를 로드하는데 실패했습니다: $e');
    }
  }

  void _filterHospitalsInView() async {
    if (_mapController == null) return;
    final bounds = await _mapController!.getContentBounds();

    final filteredHospitals = allHospitals.where((hospital) {
      return hospital.xCoordinate >= bounds.southWest.latitude &&
          hospital.xCoordinate <= bounds.northEast.latitude &&
          hospital.yCoordinate >= bounds.southWest.longitude &&
          hospital.yCoordinate <= bounds.northEast.longitude;
    }).toList();

    setState(() {
      hospitals = filteredHospitals;
    });
    _addMarkers();
  }

  void _addMarkers() async {
    if (_mapController == null) return;
    _mapController!.clearOverlays();
    for (var hospital in hospitals) {
      final marker = NMarker(
        id: hospital.name,
        position: NLatLng(hospital.xCoordinate, hospital.yCoordinate),
        icon: NOverlayImage.fromAssetImage('asset/img/logo2.png'), // 마커 이미지 설정
        size: Size(20, 20),
        caption: NOverlayCaption(
          text: hospital.name,
          textSize: 11.0,
          color: Colors.black,
          minZoom: 13,
          maxZoom: 21,
          //requestWidth: 0,
        ),
      );
      _mapController!.addOverlay(marker);

      marker.setOnTapListener((NMarker marker) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HospitalDetailPage(hospital: hospital),
          ),
        );
      });
    }
  }

  void _searchInCurrentView() async {
    _filterHospitalsInView();
  }

  @override
  void dispose() {
    _positionStreamSubscription.cancel();
    super.dispose();
  }

  void _navigateToSearchPage(BuildContext context) {
    if (_currentPosition != null) {
      final currentLatLng = NLatLng(_currentPosition!.latitude, _currentPosition!.longitude);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SearchPage(currentPosition: currentLatLng)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

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
            Text('동물병원', style: TextStyle(fontSize: screenWidth * 0.05)),
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => _navigateToSearchPage(context),
          ),
        ],
      ),
      body: Stack(
        children: [
          _currentPosition == null
              ? Center(child: Text('위치 정보를 확인하는 중입니다...'))
              : NaverMap(
            options: NaverMapViewOptions(
              initialCameraPosition: NCameraPosition(
                target: _currentPosition != null
                    ? NLatLng(_currentPosition!.latitude, _currentPosition!.longitude)
                    : NLatLng(37.5665, 126.9780), // 기본 위치를 서울 시청으로 설정
                zoom: 13,
                bearing: 0,
                tilt: 0,
              ),
              indoorEnable: true,
              locationButtonEnable: true,
              consumeSymbolTapEvents: false,
            ),
            onMapReady: (NaverMapController controller) async {
              _mapController = controller;
              mapControllerCompleter.complete(controller);
              if (_currentPosition != null) {
                _updateCameraPosition(_currentPosition!);
                final currentLatLng = NLatLng(_currentPosition!.latitude, _currentPosition!.longitude);
                loadHospitals(currentLatLng);
              }
            },
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.1,
            minChildSize: 0.1,
            maxChildSize: 0.8,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                height: screenHeight * 0.8, // 높이를 화면의 80%로 설정
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, -2),
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                child: HospitalInfoPage(
                  scrollController: scrollController,
                  hospitals: hospitals, // 필터링된 병원 데이터를 전달
                ),
              );
            },
          ),
          Positioned(
            top: 10,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: _searchInCurrentView,
                child: Text('현 지도에서 검색'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  textStyle: TextStyle(fontSize: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
