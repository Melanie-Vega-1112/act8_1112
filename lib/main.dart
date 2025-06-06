import 'package:animate_do/animate_do.dart';
import 'package:act8/helpers/ColorsSys.dart';
import 'package:act8/helpers/Strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20, top: 20),
            child: InkWell(
              onTap: () {
                // Navega a la última página con animación
                _pageController.animateToPage(
                  2,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              child: Text(
                'Skip',
                style: TextStyle(
                    color: ColorSys.gray,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          PageView(
            onPageChanged: (int page) {
              setState(() {
                currentIndex = page;
              });
            },
            controller: _pageController,
            physics: BouncingScrollPhysics(), // Mejor efecto de desplazamiento
            children: <Widget>[
              makePage(
                image: 'assets/images/muebleriasBaratasMexico.png',
                title: Strings.muebleriasBaratasMexicoTitle,
                content: Strings.muebleriasBaratasMexicoContent,
              ),
              makePage(
                reverse: true,
                image: 'assets/images/muebleriasCdmx.jpg',
                title: Strings.muebleriasCdmxTitle,
                content: Strings.muebleriasCdmxContent,
              ),
              makePage(
                image: 'assets/images/uwuw.jpg',
                title: Strings.uwuwTitle,
                content: Strings.uwuwContent,
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildIndicator(),
            ),
          )
        ],
      ),
    );
  }

  Widget makePage({image, title, content, reverse = false}) {
    return Container(
      padding: EdgeInsets.only(left: 50, right: 50, bottom: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          !reverse
              ? Column(
                  children: <Widget>[
                    FadeInUp(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Image.asset(image),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                )
              : SizedBox(),
          FadeInUp(
              duration: Duration(milliseconds: 900),
              child: Text(
                title,
                style: TextStyle(
                    color: ColorSys.primary,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              )),
          SizedBox(
            height: 20,
          ),
          FadeInUp(
              duration: Duration(milliseconds: 1200),
              child: Text(
                content,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ColorSys.gray,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              )),
          reverse
              ? Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Image.asset(image),
                    ),
                  ],
                )
              : SizedBox(),
        ],
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 6,
      width: isActive ? 30 : 6,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          color: ColorSys.secoundry, borderRadius: BorderRadius.circular(5)),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 3; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }

    return indicators;
  }
}
