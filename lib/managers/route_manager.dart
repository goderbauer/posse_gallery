// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:posse_gallery/managers/category_manager.dart';
import 'package:posse_gallery/models/app_category.dart';
import 'package:posse_gallery/models/category_item.dart';
import 'package:posse_gallery/screens/category_screen.dart';
import 'package:posse_gallery/screens/debug/debug_options_screen.dart';
import 'package:posse_gallery/screens/main_screen.dart';
import 'package:fluro/fluro.dart';

class RouteManager {

  RouteManager() {
    _categories = new CategoryManager().categories();
  }

  static List<AppCategory> _categories;

  // route configuration
  void configureRoutes(Router router) {
    router.define("/", handler: rootHandler);
    router.define("/category/:category", handler: categoryHandler);
    router.define("/debug", handler: debugMenuHandler);
  }

  // handlers
  RouteHandler rootHandler = (Map<String, String> params) {
    return new MainScreen();
  };

  RouteHandler debugMenuHandler = (Map<String, String> params) {
    return new DebugOptionsScreen();
  };

  RouteHandler categoryHandler = (Map<String, String> params) {
    String categoryName = params["category"];
    AppCategory category;
    if (categoryName != null) {
      category = retrieveCategory(categoryName);
    }
    if (category != null) {
      return new CategoryScreen(category: category);
    } else {
      // TODO - show invalid category / not found screen
    }
  };

  // helpers
  static AppCategory retrieveCategory(String routeName) {
    for (AppCategory category in _categories) {
      if (category.routeName == routeName) {
        return category;
      }
    }
    return null;
  }

  static CategoryItem retrieveItem(AppCategory category, String routeName) {
    for (CategoryItem item in category.categoryItems) {
      if (item.routeName == routeName) {
        return item;
      }
    }
    return null;
  }
}
