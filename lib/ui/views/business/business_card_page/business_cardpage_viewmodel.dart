import 'dart:io';
import 'dart:typed_data';

import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/models/hive/business_card/business_card_model.dart';
import 'package:mycustomers/core/services/business_card_service.dart';
import 'package:mycustomers/core/services/permission_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class BusinessCardPageViewModel extends BaseViewModel {
  /// Fields
  final BusinessCardService _businessCardService =
      locator<IBusinessCardService>();
  final NavigationService _navigationService = locator<NavigationService>();

  final PermissionService _permissionService = locator<IPermissionService>();
  BusinessCard _businessCard = BusinessCard.empty();
  File imageFile;
  bool rollSlideShow = true;

  /// Getters
  BusinessCard get businessCard => _businessCard;

  /// Setters

  /// Methods
  void updateBusinessCard({
    String storeName,
    String personalName,
    String phoneNumber,
    String emailAddress,
    String address,
    String position,
    String tagLine,
    String cardDesign,
  }) {
    _businessCard = _businessCard.copyWith(
      storeName: storeName ?? _businessCard.storeName,
      personalName: personalName ?? _businessCard.personalName,
      phoneNumber: phoneNumber ?? _businessCard.phoneNumber,
      emailAddress: emailAddress ?? _businessCard.emailAddress,
      address: address ?? _businessCard.address,
      position: position ?? _businessCard.position,
      tagLine: tagLine ?? _businessCard.tagLine,
      cardDesign: cardDesign ?? _businessCard.cardDesign,
    );
    notifyListeners();
  }

  Future<void> saveBusinessCard() async {
    await _businessCardService.saveBusinessCard(businessCard);
    notifyListeners();
  }

  Future<void> shareImageAndText() async {
    try {
      if (await _permissionService.getStoragePermission()) {
        final Uint8List bytes = await imageFile.readAsBytes();

        final String internalStorage = '/storage/emulated/0/myCustomer';

        final String fileName =
            '${businessCard.storeName}-businesscard${businessCard.cardDesign}.png';

        bool isDirExist = await Directory(internalStorage).exists();
        if (!isDirExist) Directory(internalStorage).create();
        String tempPath = '$internalStorage/$fileName';
//        File image = await File(tempPath).create();
        File(tempPath).writeAsBytes(bytes);

        await WcFlutterShare.share(
          sharePopupTitle: 'Share Your Business Card',
          subject: businessCard.storeName,
          text: 'My Business Card',
          fileName: fileName,
          mimeType: 'image/png',
          bytesOfFile: bytes.buffer.asUint8List(),
        );
      }
    } catch (e) {
      throw Exception("Unable to save image");
    }
  }

  Future<void> init() async {
    _businessCard = await _businessCardService.getBusinessCard();
    notifyListeners();
  }

  Future navigateToBusinessCardPage() async {
    await _navigationService.navigateTo(Routes.businessCardRoute);
  }
}
