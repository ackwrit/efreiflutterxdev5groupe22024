import "package:permission_handler/permission_handler.dart";

class MyPermissionImage{
  init() async{
    PermissionStatus permissionStatus = await Permission.photos.status;
    checkPermission(permissionStatus);
  }

  checkPermission(PermissionStatus statut){
    switch(statut){
      case PermissionStatus.permanentlyDenied : return Future.error("Vous ne souhaitez pas qu'on accède à vos photos");
      case PermissionStatus.denied: return Permission.photos.request();
      case PermissionStatus.restricted:return Permission.photos.request();
      case PermissionStatus.limited: return Permission.photos.request();
      case PermissionStatus.provisional: return Permission.photos.request();
      case PermissionStatus.granted: return Permission.photos.request();

    }
  }

}