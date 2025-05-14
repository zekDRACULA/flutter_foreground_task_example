import 'package:flutter/material.dart';
import 'package:geofencing_api/geofencing_api.dart';

import '../../models/geofence_state.dart';
import '../../service/geofencing_service.dart';
import '../utils/error_handler_mixin.dart';
import 'base_controller.dart';

class MainPageController extends BaseController with ErrorHandlerMixin {
  final ValueNotifier<GeofenceState?> geofenceStateListenable =
      ValueNotifier(null);

  void _startGeofencingService() async {
    try {
      // already started
      if (await GeofencingService.instance.isRunningService) {
        return;
      }

      // dummy regions
      final Set<GeofenceRegion> regions = {
        //Office region
        GeofenceRegion.polygon(
          id: 'office',
          data: {
            'name': 'Prakhar office',
          },
          polygon: [
            const LatLng(28.607623802948144, 77.43675076015441),
            const LatLng(28.607275563978593, 77.43641401431108),
            const LatLng(28.607091820213373, 77.43574040538616),
            const LatLng(28.60701220228866, 77.4353137555746),
            const LatLng(28.60687811739804, 77.4347897377039),
            const LatLng(28.60725285807073, 77.43467040365817),
            const LatLng(28.60776056910787, 77.4345327105285),
            const LatLng(28.607780716320633, 77.43453730029948),
            const LatLng(28.608034570870366, 77.43535886930654),
            const LatLng(28.608244101147726, 77.43633649052724),
          ],
        ),

        //Home region
        GeofenceRegion.polygon(id: 'home', 
        data: {
          'name': 'Prakhar home',
        }, polygon: [
          const LatLng(28.43196, 77.50288),
          const LatLng(28.43173, 77.50234),
          const LatLng(28.43206, 77.5021),
          const LatLng(28.43235, 77.50261),
          const LatLng(28.43255, 77.50304),
          const LatLng(28.43215, 77.50332),
        ])
      };

      GeofencingService.instance.start(regions: regions);
    } catch (e, s) {
      handleError(e, s);
    }
  }

  void _onGeofenceStateChanged(GeofenceState state) {
    geofenceStateListenable.value = state;
  }

  @override
  void attach(State state) {
    super.attach(state);
    GeofencingService.instance
        .addGeofenceStateChangedCallback(_onGeofenceStateChanged);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startGeofencingService();
    });
  }

  @override
  void dispose() {
    GeofencingService.instance
        .removeGeofenceStateChangedCallback(_onGeofenceStateChanged);
    geofenceStateListenable.dispose();
    super.dispose();
  }
}
