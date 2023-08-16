import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:money_budget/category/controllers/category_controller.dart";
import "package:money_budget/category/views/category_page.dart";
import "package:money_budget/detail/view/detail_page.dart";
import "package:money_budget/detail/view/editpage.dart";
import "package:money_budget/home/views/homepage.dart";
import "package:money_budget/income/views/income_page.dart";
import "package:money_budget/monthly_data/views/monthly_data_page.dart";
import "package:money_budget/outcome/views/outcome_page.dart";

GetPageRoute? generalRouting(RouteSettings settings) {
  switch (settings.name) {
    case Homepage.name:
      return GetPageRoute(
        settings: settings,
        page: () => Homepage(),
      );

    case IncomePage.name:
      return GetPageRoute(
        settings: settings,
        page: () => IncomePage(),
      );
    case OutcomePage.name:
      return GetPageRoute(
        settings: settings,
        page: () => OutcomePage(),
      );
    case DetailPage.name:
      return GetPageRoute(
        settings: settings,
        page: () => DetailPage(),
      );
    case Editpage.name:
      return GetPageRoute(
        settings: settings,
        page: () => Editpage(),
      );
    case Monthlydatapage.name:
      return GetPageRoute(
        settings: settings,
        page: () => Monthlydatapage(),
      );

    case CategoryPage.name:
      return GetPageRoute(
        settings: settings,
        page: () => const CategoryPage(),
      );

    default:
      return null;
  }
}
