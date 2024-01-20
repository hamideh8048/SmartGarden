// import 'package:drawerbehavior/drawer_scaffold.dart';
//  import 'package:drawerbehavior/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:samrt_garden/model/Plant.dart';
import 'package:samrt_garden/screen/AddGardenScreen.dart';
// import 'package:drawerbehavior/drawerbehavior.dart' as drawer;
import 'package:samrt_garden/screen/AdminScreen.dart';
import 'package:samrt_garden/screen/GardenDetailsScreen.dart';
import 'package:samrt_garden/screen/GuideScreen.dart';
import 'package:samrt_garden/screen/LoginScreen.dart';
import 'package:samrt_garden/screen/NotificationScreen.dart';
import 'package:samrt_garden/screen/PlantsScreen.dart';
import 'package:samrt_garden/utils/Constant.dart';
import 'package:samrt_garden/utils/NotificationHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/services.dart';

class LaunchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LaunchScreenState();
  }
}

class LaunchScreenState extends State<LaunchScreen> {
  int? selectedMenuItemId;
  // final DrawerScaffoldController controller = DrawerScaffoldController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // late SideDrawer sideDrawer;

  String email = '', password = '';

  late BuildContext contextDrawer;

  late NotificationHelper _notificationHelper;

  bool isExistGarden = false;


  readEmail() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
if(preferences.getString('EMAIL')!=null)
     email = preferences.getString('EMAIL')!;
    String g="";
    }

  registerGarden() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var token = preferences.getString('token');
    if (token != null && token.length > 2) {
      var response = await (Services()).registerFlowerpot(token);

      String q="";
      // if (response != null && response["id"]!=null) {
      //
      //   fmodel = FlowerModel.fromJson(response);
      //   CheckDropdown();
      //   //  taradods.add(TaradodListModel.fromJson(element));
      //   List<String>plantliststr=[];
      //   plants=fmodel!.plants;
      //   plantliststr=plants;
      //   if(fmodel!.plants.length>0)
      //     userplantList= plantList.where((elem) => plantliststr.contains(elem.id)).toList();
      //
      //   setState(() {
      //
      //   });
      // }
    }}

  @override
  void initState() {
    //selectedMenuItemId = menu1.items[0].id;
    super.initState();
readEmail();
   //registerGarden();
   // GetUserPot();
  //  savePlant();
   // getInformation();
   //  Constant.plantList = [];
   //  String description1 =
   //      'این گیاه ابتدا رشد کندی خواهد شد. بعد از اینکه به نقطه بلوغ برسد، محصول نسبتا زیادی تولید میکند. 	اولین برداشت این محصول بعد 4 تا 5 هفته اتفاق میافتد. به آرامی سر گیاه را کوتاه کنید تا برگهای جدید آن رشد کند. \n';
   //  Plant plant1 = new Plant(
   //      id: 1,
   //      title: 'نعنا فلفلی',
   //      germination: '10 تا 20 روز',
   //      category: 'سبزیجات برگی',
   //      harvest: '5 هفته',
   //      best_temp: '20 تا 25 درجه سانتیگراد',
   //      exposure: '13 تا 14 ساعت',
   //      planting_depth: '2 تا 3 میلی متر',
   //      description: description1,
   //      question:
   //          'بعد از اینکه دوره رشد گیاهتون تموم شد و خواستید اون رو با گیاه جدید جایگزین کنید، میتونید توی خاک یا باغچه بکارید، ریحون جزو گیاهانی هست که در شرایط سخت هم خوب رشد می کند',
   //  image: 'assets/images/baby_esfenaj.png');
   //  Constant.plantList.add(plant1);
   //  String description2 =
   //      'در نظر داشته باشید قوه نامیه این بذر بالاست و برای هر بستر 3 یا 4 بذر کافی است. عطر این گیاه فوق العاده است و به سرعت بزرگ میشود. برای برداشت محصول حتی الامکان به صورت برگ چینی و تازه خوری مصرف کنید';
   //  Plant plant2 = new Plant(
   //      id: 2,
   //      title: 'ریحان بنفش ایتالیایی',
   //      germination: '7 تا 15 روز',
   //      category: 'سبزیجات برگی',
   //      harvest: '4 هفته',
   //      best_temp: '20 تا 32 درجه سانتیگراد',
   //      exposure: '14 تا 16 ساعت',
   //      planting_depth: '7 تا 15 میلی متر',
   //      description: description2,
   //      question:
   //          'عناصر ریزمغذی مثل مس، روی و ... که برای سلامتی انسان ضروری هستند، با استفاده از کود گرین چال مدل سوپر گرین به مقدار کافی برای گیاهتون و در نهایت برای شما تولید خواهد شد. پس دیگه نیاز به مکملهای صنعتی نخواهید داشت',
   //  image: 'assets/images/gandomi.png');
   //  Constant.plantList.add(plant2);
    //setFlowers0();
  }




  void logout() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'خروج از حساب کاربری',
              textDirection: TextDirection.rtl,
            ),
            content: Text(
              'آیا مطمئن هستید که می خواهید از حساب کاربری خود خارج شوید؟',
              textDirection: TextDirection.rtl,
            ),
            actions: [
              new TextButton(
                // textColor: Colors.red,
                child: new Text(
                  'لغو',
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new TextButton(
                // textColor: Color.fromRGBO(143, 148, 251, 1),
                child: new Text(
                  'تایید',
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  setState(() {
                   // preferences.setBool('REGISTERED', false);
                  //  preferences.setBool('REGISTERED', false);
                    preferences.setString("token", "");
                    preferences.commit();
                  });
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => LoginScreen()));
                },
              ),
            ],
          );
        });
  }

  // static List<drawer.MenuItem<int>> items = [
  //   new drawer.MenuItem<int>(
  //     id: 1,
  //     title: 'فهرست گیاهان',
  //     prefix: Icon(Icons.person),
  //   ),
  //   new drawer.MenuItem<int>(
  //     id: 2,
  //     title: 'اعلانات',
  //     prefix: Icon(Icons.terrain),
  //   ),
  //   new drawer.MenuItem<int>(
  //     id: 3,
  //     title: 'راهنما',
  //     prefix: Icon(Icons.settings),
  //   ),
  // ];

  // final menu1 = Menu(
  //   items: items.map((e) => e.copyWith(prefix: null)).toList(),
  // );
  //
  // final menuWithIcon1 = Menu(
  //   items: items,
  // );

  Widget headerView(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: 400,
          padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Row(
            children: <Widget>[
              Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${email}",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(color: Colors.white),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "مشاهده حساب کاربری و تنظیمات",
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        ?.copyWith(color: Colors.white.withAlpha(200)),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              )),
              SizedBox(
                width: 16,
              ),
              new Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/images/user1.png")))),
            ],
          ),
        ),
        Divider(
          color: Colors.white.withAlpha(200),
          height: 16,
        )
      ],
    );
  }

  Widget getWidget(bool isExistGarden){
    if(isExistGarden){
      return Center(
        child: Column(
          children: [
            Image.asset(
              "assets/images/sp1.png",
              height: 350,
            ),
            Padding(padding: EdgeInsets.all(12)),
            new GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => GardenDetailsScreen(flowerModel: ,)),
                // );
              },
              child: Container(
                height: 50,
                width: 360,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(colors: [
                      Colors.lightGreen,
                      Colors.lightGreen,
                    ])),
                child: Center(
                    child: Text(
                      "تنظیمات باغچه",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
              ),
            ),
          ],
        ),
      );
    }else{
      return ListView(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.all(8),
            child: Column(
              children: [
                Text('تیم گرین‌چال، اجتماعی از جوانان نوآوری و خوش فکر در کنار متخصصین خبره در حوزه‌های تخصصی و استراتژیک به دنبال رفع چالش‌ها و موانع حوزه کشاورزی و تولید محصولات غذایی است. این تیم با راه حل‌های تحول آفرین قصد دارد در رفع آثار نامطلوب چالش‌های اخیر در حوزه کشاورزی  تولید محصولات خوراکی (از جمله تنش‌های سیاسی در توزیع مواد خوراکی، تغییرات آب و هوا، کاهش ظرفیت بهره‌وری خاک) گام‌های موثری بردارد.',style: TextStyle(),textDirection: TextDirection.rtl,),
                Padding(padding: EdgeInsets.all(12)),
                Image.asset(
                  "assets/images/sp1.png",
                  height: 200,
                ),
                Padding(padding: EdgeInsets.all(12)),
                Text('استراتژی ما به گونه‌ای است که هر فردی با کمترین میزان تجربه و آشنایی به این حوزه با خیال راحت و بدون دغدغه، در نهایت به یک تولید کننده تبدیل می‌شود. ما زمین‌های کشاورزی را در خانه‌های مردم ترویج می‌دهیم؛ فضایی اندک با بازده چندبرابری زمین‌های کشاورزی که می‌تواند هزینه‌های جانبی تولید، زنجیره تامین و فروش محصولات را به حداقل برساند. از ویژگی‌های کلیدی محصولات ما می‌توان به استفاده از تکنولوژی برتر، پایش وضعیت پیوسته و ثبت اطلاعات در بستر اینترنت اشیا بدون نیاز به دخالت کاربری اشاره کرد.',style: TextStyle(),textDirection: TextDirection.rtl,),
                Padding(padding: EdgeInsets.all(12)),
                Image.asset(
                  "assets/images/green_chall_logo.png",
                  height: 200,
                ),
                Padding(padding: EdgeInsets.all(12)),
              ],
            ),
          ),
        ],
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: GestureDetector(
        onTap: (){

            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddGardenScreen()),
            ).then((value) async {
              print('hi hi hi hi');
             // savePlant();
              setState(() {});
            });

          // if(isExistGarden){
          //   Fluttertoast.showToast(
          //       msg: "ظرفیت افزودن باغچه تکمیل می باشد!",
          //       toastLength: Toast.LENGTH_SHORT,
          //       gravity: ToastGravity.CENTER,
          //       timeInSecForIosWeb: 1,
          //       backgroundColor: Colors.red,
          //       textColor: Colors.white,
          //       fontSize: 16.0);
          // }else {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => AddGardenScreen()),
          //   ).then((value) async {
          //     print('hi hi hi hi');
          //     savePlant();
          //     setState(() {});
          //   });
          // }
        },
        child: Container(
          width: 120,
          height: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(36),
              gradient: LinearGradient(colors: [
                Colors.green,
                Colors.green,
              ])),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('گلدان های من ',style: TextStyle(color: Colors.white),),
              Icon(Icons.add_box_outlined,color: Colors.white,),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Green Chall',
          style: TextStyle(color: Colors.black, fontSize: 18),
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
        ),
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Image.asset("assets/icons/humber.png"),
              onPressed: () {
                contextDrawer = context;
                Scaffold.of(context).openEndDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        width: double.infinity,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 36,
            ),
            Container(
              alignment: Alignment.topRight,
              child: Builder(
                builder: (context) => IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.orange,
                  ),
                  onPressed: () => Scaffold.of(context).closeEndDrawer(),
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(24),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(36),
                    gradient: LinearGradient(colors: [
                      Colors.black12,
                      Colors.black12,
                    ])),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(
                      builder: (context) => IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black87,
                        ),
                        onPressed: () => Scaffold.of(context).closeEndDrawer(),
                        tooltip: MaterialLocalizations.of(context)
                            .openAppDrawerTooltip,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          email,
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            Scaffold.of(contextDrawer).closeEndDrawer();
                            logout();
                          },
                          child: Text(
                            'خروج از حساب کاربری',
                            style:
                                TextStyle(color: Colors.orange, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Image.asset(
                        "assets/images/account.png",
                        width: 64,
                        height: 64,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  children: [
                    ListTile(
                      title: const Text(
                        'فهرست گیاهان',
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 16),
                      ),
                      leading: Icon(Icons.arrow_back_ios_new),
                      onTap: () {
                        Scaffold.of(contextDrawer).closeEndDrawer();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlantsScreen()),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text(
                        'اعلانات',
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 16),
                      ),
                      leading: Icon(Icons.arrow_back_ios_new),
                      onTap: () {
                        Scaffold.of(contextDrawer).closeEndDrawer();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotificationsScreen()),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text(
                        'راهنما',
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 16),
                      ),
                      leading: Icon(Icons.arrow_back_ios_new),
                      onTap: () {
                        Scaffold.of(contextDrawer).closeEndDrawer();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GuideScreen()),
                        );
                      },
                    ),
                  ],
                )),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            child: Image.asset("assets/images/image_back_shadow.png"),
            alignment: Alignment.bottomCenter,
          ),
          getWidget(isExistGarden),
        ],
      ),
    );
  }
}
