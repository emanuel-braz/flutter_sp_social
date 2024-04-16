import 'package:flutter/material.dart';
import 'package:flutter_sp_social/core/utils/layout_util.dart';
import 'package:flutter_sp_social/presentation/home/event_store.dart';
import 'package:flutter_sp_social/presentation/home/home_view/carousel_view.dart';
import 'package:flutter_sp_social/presentation/home/home_view/desktop_view.dart';
import 'package:flutter_sp_social/presentation/home/home_view/mobile_view.dart';

class HomePageViewFactory {
  static Widget build(BuildContext context, EventStore store) {
    if (LayoutUtil.isMobileLayout(context)) {
      return MobileView(store: store);
    } else {
      if (store.value?.isCarouselView ?? false) {
        return CarouselView(store: store);
      }
      return DesktopView(store: store);
    }
  }
}
