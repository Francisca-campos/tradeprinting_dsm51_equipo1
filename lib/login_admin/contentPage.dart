//import 'package:tradeprinting_dsm51_equipo1/pages/admin/show_recipe.dart';
//import 'package:tradeprinting_dsm51_equipo1/pages/maps_page.dart';
//import 'package:tradeprinting_dsm51_equipo1/pages/myrecipes/list_my_recipe.dart';
import 'package:tradeprinting_dsm51_equipo1/pages/admin/show_recipe.dart';
import 'package:tradeprinting_dsm51_equipo1/widgets/home_page.dart';

abstract class Content {
  Future<HomePageProductos> lista();
  //Future<InicioPage> productos(String id);
  //Future<MapsPage> mapa();
  //Future<ListMyrecipes> myrecipe(String id);
  Future<InicioPage> admin();
}

class ContentPage implements Content {
  Future<HomePageProductos> lista() async {
    return HomePageProductos();
  }

  //Future<MapsPage> mapa() async {
  //return MapsPage();
  //}

  Future<InicioPage> admin() async {
    return InicioPage();
  }

  //Future<IncioPage> productos(String id) async {
  //print('en content page $id');
  //return InicioPage(
  //id: id,
  //);
  //}

  //Future<ListMytradeprinting_dsm51_equipo1> myproducto(String id) async {
  //  print('listados mis productos $id');
  // return ListMyTradeprinting_dsm51_equipo1(
  //   id: id,
  // );
  //}
}
