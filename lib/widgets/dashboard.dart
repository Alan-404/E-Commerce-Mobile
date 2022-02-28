import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/models/banner.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/models/category.dart';
import 'package:carousel_slider/carousel_slider.dart';

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

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<HomeScreen> {
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
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          FutureBuilder<List<BannerModel>>(
            future: lstBanners,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<String> lstImages = [];
                for (BannerModel item in snapshot.data!) {
                  lstImages.add(item.image);
                }
                return CarouselSlider.builder(
                    itemCount: lstImages.length,
                    itemBuilder: (context, index, realInex) {
                      final urlImage = lstImages[index];
                      return buildImage(urlImage, index);
                    },
                    options: CarouselOptions(height: 250, autoPlay: true));
              }
              return const Text("");
            },
          ),
          Container(
            margin: const EdgeInsets.only(top: 15, bottom: 5),
            child: const Text(
              "Shop By Category",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            color: Colors.grey,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(15),
          ),
          FutureBuilder<List<CategoryModel>>(
            future: lstCategories,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Widget> lstCategoriesShow = [];
                for (CategoryModel item in snapshot.data!) {
                  lstCategoriesShow.add(buidCategory(item.thumnail));
                }
                return Expanded(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: lstCategoriesShow,
                ));
              }
              return const Text("");
            },
          ),
        ],
      ),
    );
  }
}
