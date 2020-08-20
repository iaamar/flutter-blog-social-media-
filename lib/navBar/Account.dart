import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var text = "Account"
        .text
        .white
        .xl4
        .fontFamily('Open')
        .lineHeight(2)
        .size(context.isMobile ? 15 : 50)
        .bold
        .make();
    return Container(
      child: SafeArea(
        child: VStack(
          [
            Row(
              children: <Widget>[
                VStack(
                  [
                    text,
                    VxBox()
                        .color(Colors.white)
                        .size(190, 6)
                        .alignTopCenter
                        .make()
                        .shimmer()
                  ],
                ).pLTRB(12, 12, 0, 0)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
