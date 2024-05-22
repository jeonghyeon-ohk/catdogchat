import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'hospital_info_page.dart';
import 'search_page.dart';

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<NaverMapController> mapControllerCompleter = Completer();
  Position? _currentPosition;
  late StreamSubscription<Position> _positionStreamSubscription;

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
    final controller = await mapControllerCompleter.future;
    controller.updateCamera(
      NCameraUpdate.withParams(
        target: NLatLng(position.latitude, position.longitude),
        zoom: 13,
      ),
    );
  }

  void _getCurrentLocation() async {
    try {
      _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {});
    } catch (e) {
      print('위치를 가져오는데 실패했습니다: $e');
    }
  }

  @override
  void dispose() {
    _positionStreamSubscription.cancel();
    super.dispose();
  }

  void _navigateToSearchPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('동물병원'),
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
                target: NLatLng(
                  _currentPosition!.latitude,
                  _currentPosition!.longitude,
                ),
                zoom: 13,
                bearing: 0,
                tilt: 0,
              ),
              indoorEnable: true,
              locationButtonEnable: true,
              consumeSymbolTapEvents: false,
            ),
            onMapReady: (NaverMapController controller) async {
              mapControllerCompleter.complete(controller);
              if (_currentPosition != null) {
                _updateCameraPosition(_currentPosition!);
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
                child: HospitalInfoPage(scrollController: scrollController),
              );
            },
          ),
        ],
      ),
    );
  }
}
