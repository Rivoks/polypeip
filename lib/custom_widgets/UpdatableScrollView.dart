import 'package:flutter/material.dart';
import 'package:polypeip/custom_widgets/CustomText.dart';

class UpdatableScrollView extends StatelessWidget {
  final List<Widget> listWidget;
  final VoidCallback updateMethod;
  final ScrollController scrollController;

  UpdatableScrollView({
    @required this.listWidget,
    @required this.updateMethod,
    this.scrollController
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: CustomText.textColor(FontColor.yellow),
      backgroundColor: Colors.white,
      onRefresh: this.updateMethod, 
      displacement: 30.0,
      child: SingleChildScrollView(
        controller: this.scrollController,
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: this.listWidget
        )
      )
    );
  }

}