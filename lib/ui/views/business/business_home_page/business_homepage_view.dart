import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import '../../../widgets/business/business_card_page/business_card_widget.dart';
import 'package:mycustomers/ui/widgets/shared/custom_share_button.dart';

import 'package:stacked/stacked.dart';

import 'business_homepage_viewmodel.dart';

class BusinessHomePageView extends StatelessWidget {
  final String profile = 'assets/icons/svg/profile.svg';
  final String settings = 'assets/icons/svg/settings.svg';
  final String support = 'assets/icons/svg/support.svg';
  final String businessCard = 'assets/icons/svg/business_card.svg';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusinessHomePageViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              children: <Widget>[
                // TODO ADD HEADER -- SHOULD BE SYNCED WITH HOMEPAGE
                Container(
                  height: SizeConfig.yMargin(context, 11),
                  decoration: BoxDecoration(
                    color: ThemeColors.background,
                  ),
                  child: ListTile(
                    subtitle: Text(
                      model.profileCardSubtitle,
                      style: TextStyle(
                        fontSize: SizeConfig.textSize(context, 3.4),
                      ),
                    ),
                    title: Text(
                      model.profileCardTitle,
                      style: TextStyle(
                        fontSize: SizeConfig.textSize(context, 5),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: CircleAvatar(
                      backgroundColor: BrandColors.primary,
                      minRadius: SizeConfig.xMargin(context, 7),
                      maxRadius: SizeConfig.xMargin(context, 8),
                      child: Text(
                        'C',
                        style: TextStyle(
                          color: ThemeColors.background,
                          fontSize: SizeConfig.textSize(context, 9),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    trailing: FlatButton(
                      color: const Color(0xFFE8FFF5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      onPressed: model.navigateToProfilePage,
                      child: Text(
                        'Edit',
                        style: TextStyle(
                          color: const Color(0xFF21D184),
                          fontSize: SizeConfig.textSize(context, 3.5),
                        ),
                      ),
                    ),
                  ),
                ),
                optionButton(
                  context: context,
                  icon: businessCard,
                  label: 'Business Card',
                  onTap: (context,model){
                    // _displayBusinessCardModal(context, model);
                  },
                ),
                optionButton(
                  context: context,
                  icon: settings,
                  label: 'Settings',
                  onTap: model.navigateToSettingsPage,
                ),
                optionButton(
                  context: context,
                  icon: support,
                  label: 'Support',
                  onTap: model.navigateToSupportPage,
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => BusinessHomePageViewModel(),
    );
  }

  Container optionButton(
      {BuildContext context, String label, Function onTap, String icon}) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeColors.background,
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(label),
        leading: CircleAvatar(
          backgroundColor: ThemeColors.background,
          minRadius: SizeConfig.xMargin(context, 4),
          maxRadius: SizeConfig.xMargin(context, 6),
          child: SvgPicture.asset(
            icon,
            semanticsLabel: label,
            color: BrandColors.primary,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: ThemeColors.black,
        ),
      ),
    );
  }
}


void _displayBusinessCardModal(context, model){
   showModalBottomSheet(
    shape: RoundedRectangleBorder(
     borderRadius: BorderRadius.circular(30.0),
  ),
    context: context, 
    builder: (BuildContext context){
      return Padding(
        padding:  EdgeInsets.symmetric(horizontal:SizeConfig.xMargin(context, 4)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children:<Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Business card'),
            FlatButton(
              color: Color(0xFFE8FFF5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
              ),
              onPressed: model.navigateToBusinessCardPage, 
              child: Text(
                'Edit',
                style: TextStyle(
                  fontSize: SizeConfig.textSize(context, 3.5),
                  color: BrandColors.primary
                ),
                ))
          ],),
          BusinessCard(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
            CustomShareRaisedButton(
              label: 'Share', 
              onPressed: (){
                model.shareImageAndText();
              } ),
              FlatButton(
                color: BrandColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius:BorderRadius.circular(32)
                ),
                onPressed: null, 
                child: Text(
                  'Download',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: BrandColors.primary,
                    fontSize: SizeConfig.textSize(context, 4.4)
                    ),
                  )
                )
            ],)
     ]
    ),
    );

    });

}