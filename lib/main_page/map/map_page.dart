import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<NaverMapController> mapControllerCompleter = Completer();

  @override
  initState() {
    super.initState();

    checkPermission();
  }

  checkPermission() async {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('동물병원'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // 검색 기능 추가
            },
          ),
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.of(context).pushNamed(
                '/hospital',
              );
            },
          ),
        ],
      ),
      body: NaverMap(
        options: const NaverMapViewOptions(
          initialCameraPosition: NCameraPosition(
              target: NLatLng(
                37.5214,
                126.9246,
              ),
              zoom: 13,
              bearing: 0,
              tilt: 0),
          indoorEnable: true,
          locationButtonEnable: true,
          consumeSymbolTapEvents: false,
        ),
        onMapReady: (controller) async {
          mapControllerCompleter.complete(controller);
          log("onMapReady", name: "onMapReady");

          final marker = NMarker(
              id: 'test',
              position:
              const NLatLng(37.506932467450326, 127.05578661133796));
          final marker1 = NMarker(
              id: 'test1',
              position:
              const NLatLng(37.606932467450326, 127.05578661133796));
          controller.addOverlayAll({marker, marker1});

          final onMarkerInfoWindow =
          NInfoWindow.onMarker(id: marker.info.id, text: "건물");
          marker.openInfoWindow(onMarkerInfoWindow);
        },
      ),
    );
  }
}
