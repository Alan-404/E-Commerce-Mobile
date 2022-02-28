import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/models/banner.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mobile/models/category.dart';
import 'package:mobile/widgets/dashboard.dart';
/* import 'package:mobile/models/discount.dart';
import 'package:mobile/models/product.dart'; */

Future<List<BannerModel>> getAllBanners() async {
  var response =
      await http.get(Uri.parse('http://10.0.2.2:8000/banner/banner_api'));
  Map<String, dynamic> jsonData = jsonDecode(response.body);

  List<BannerModel> lstBanners = [];
  for (var item in jsonData['banners']) {
    BannerModel banner = BannerModel(
        id: item['id'],
        image: item['image'],
        distributorId: item['distributor_id']);
    lstBanners.add(banner);
  }
  return lstBanners;
}

Future<List<CategoryModel>> getAllCategories() async {
  var response =
      await http.get(Uri.parse('http://10.0.2.2:8000/category/category_api'));
  Map<String, dynamic> jsonData = jsonDecode(response.body);
  List<CategoryModel> lstCategories = [];
  for (var item in jsonData['categories']) {
    CategoryModel category = CategoryModel(
        id: item['id'],
        name: item['name'],
        description: item['description'],
        thumnail: item['thumnail']);
    lstCategories.add(category);
  }
  return lstCategories;
}

Widget buildImage(String urlImage, int index) => Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      color: Colors.grey,
      width: double.infinity,
      child: Image.network(urlImage, fit: BoxFit.cover),
    );

Widget buidCategory(String image) => Container(
      margin: const EdgeInsets.only(left: 5, right: 5),
      child: Image(
        image: NetworkImage(image),
        width: 100,
      ),
    );

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key, required route}) : super(key: key);
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<List<BannerModel>> lstBanners;
  late Future<List<CategoryModel>> lstCategories;
  late Future<Object> lstProducts;
  CarouselController buttonCarouselController = CarouselController();
  @override
  void initState() {
    super.initState();
    lstBanners = getAllBanners();
    lstCategories = getAllCategories();
    //lstProducts = getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text("VinalaSHOP"),
        automaticallyImplyLeading: false,
        actions: [ButtonTheme(child: const Icon(Icons.info))],
      ),
      body: const HomeScreen(),
    );
  }
}
