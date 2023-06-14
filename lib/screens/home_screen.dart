import 'package:cats_app/backend/cats_service.dart';
import 'package:cats_app/models/cats_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CatsModel>? catsModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCatsInfo();
  }

  Future getCatsInfo() async {
    catsModel =
        await Provider.of<CatsService>(context, listen: false).getCats();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: catsModel == null
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:
                          List.generate(40, (index) => Text("data $index"))),
            ),
          )),
    );
  }
}
