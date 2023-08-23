import "package:get/get.dart";
import "package:money_budget/category/views/category_page.dart";
import "package:money_budget/detail/view/detail_page.dart";
import "package:money_budget/detail/view/editpage.dart";
import "package:money_budget/home/views/homepage.dart";
import "package:money_budget/income/views/income_page.dart";
import "package:money_budget/monthly_data/views/monthly_data_page.dart";
import "package:money_budget/outcome/views/outcome_page.dart";
import "package:money_budget/z_application/navigation/views/navigation_page.dart";

final getRouteList = [
  GetPage(name: "/", page: () => const NavigationScreen()),
  GetPage(name: Homepage.name, page: () => Homepage()),
  GetPage(name: IncomePage.name, page: () => IncomePage()),
  GetPage(name: OutcomePage.name, page: () => OutcomePage()),
  GetPage(name: DetailPage.name, page: () => DetailPage()),
  GetPage(name: Editpage.name, page: () => Editpage()),
  GetPage(name: Monthlydatapage.name, page: () => Monthlydatapage()),
  GetPage(name: CategoryPage.name, page: () => CategoryPage()),
];
