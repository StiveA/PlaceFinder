import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static List<Permission> permissions = <Permission>[
    Permission.location,
  ];

  static bool getPermanentlyDeniedFromResponse(
      Map<Permission, PermissionStatus> statuses, Permission element) {
    return statuses[element] != null
        ? statuses[element]!.isPermanentlyDenied
        : false;
  }

  static bool getStatusFromResponse(
      Map<Permission, PermissionStatus> statuses, Permission element) {
    return statuses[element] != null ? statuses[element]!.isGranted : false;
  }

  static Future<bool> getPermanentlyDenied(Permission element) {
    return element.status.isPermanentlyDenied;
  }

  static Future<bool> getStatus(Permission element) {
    return element.status.isGranted;
  }

  static Future<Map<Permission, PermissionStatus>> getPermission(
      List<Permission> permissions, BuildContext context) async {
    debugPrint("entered getpermission");

    Map<Permission, PermissionStatus> statuses = await permissions.request();
    debugPrint("made request");
    for (var element in permissions) {
      bool isPermanentlyDenied =
          getPermanentlyDeniedFromResponse(statuses, element);
      bool isGranted = getStatusFromResponse(statuses, element);

      debugPrint(element.toString() + " is granted? :" + isGranted.toString());

      if (isPermanentlyDenied) {
        await openAppSettings().then(
          (value) async {
            if (value) {
              if (await getPermanentlyDenied(element) == true &&
                  await getStatus(element) == false) {
                openAppSettings();
                // permissionServiceCall(); /* opens app settings until permission is granted */
              }
            }
          },
        );
      }
    }
    return statuses;
  }

  static Future<Map<Permission, PermissionStatus>> enforceRequiredPermissions(
      BuildContext context) {
    /*Map<Permission, bool> permissions = <Permission, bool>{};
    permissions.addAll({Permission.camera: true, Permission.storage: true});*/

    Future<Map<Permission, PermissionStatus>> result =
        PermissionHelper.getPermission(permissions, context);
    result.then((valueR) {
      bool allTrue = checkAllGranted(valueR);
      while (!allTrue) {
        result = PermissionHelper.getPermission(permissions, context);
        result.then((valueR) {
          allTrue = checkAllGranted(valueR);
        });
      }
    });
    return result;
  }

  static bool checkAllGranted(Map<Permission, PermissionStatus> statuses) {
    bool allTrue = true;
    statuses.forEach((key, value) {
      if (value.isDenied) allTrue = false;
    });
    return allTrue;
  }

  static Future<bool> checkRequiredPermissions(BuildContext context) async {
    Map<Permission, PermissionStatus> result =
        await PermissionHelper.getPermission(permissions, context);
    return checkAllGranted(result);
  }
}
