import 'package:cats_app/backend/cats_service.dart';
import 'package:cats_app/models/cats_model.dart';
import 'package:cats_app/widgets/cats_intelligence_indicator.dart';
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
          child: RefreshIndicator(
            onRefresh: () async {
              catsModel = await Provider.of<CatsService>(context, listen: false)
                  .getCats();
              setState(() {});
            },
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: const Text(
                    "Catbreed",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: catsModel == null
                              ? [const CircularProgressIndicator()]
                              : List.generate(catsModel!.length, (index) {
                                  return SizedBox(
                                    height: 324,
                                    child: Card(
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0)),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 12),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: Column(
                                          children: [
                                            Stack(children: [
                                              Image.network(
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  }
                                                  return Center(
                                                    child: SizedBox(
                                                      height: 300,
                                                      child: Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          value: loadingProgress
                                                                      .expectedTotalBytes !=
                                                                  null
                                                              ? loadingProgress
                                                                      .cumulativeBytesLoaded /
                                                                  loadingProgress
                                                                      .expectedTotalBytes!
                                                              : null,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                "https://cdn2.thecatapi.com/images/${catsModel![index].referenceImageId}.jpg",
                                                width: double.infinity,
                                                height: 300,
                                                fit: BoxFit.fill,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Image.network(
                                                    "https://placekitten.com/200/300", // URL de imagen de reemplazo
                                                    width: double.infinity,
                                                    height: 300,
                                                    fit: BoxFit.cover,
                                                  );
                                                },
                                              ),
                                              Positioned(
                                                top: 10,
                                                left: 10,
                                                child: Text(
                                                  catsModel![index].name!,
                                                  style: const TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 18,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Positioned(
                                                left: 10,
                                                bottom: 10,
                                                child: Text(
                                                  catsModel![index].origin ??
                                                      "Unknown",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 18,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Positioned(
                                                  right: 10,
                                                  bottom: 10,
                                                  child: CatCircles(
                                                      number: catsModel![index]
                                                          .intelligence!) /*CatsIntelligenceIndicator(
                                                    number: catsModel![index]
                                                            .intelligence ??
                                                        0),*/
                                                  ),
                                            ])
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                })),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
