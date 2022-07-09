import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gilog/MVP/Model/deliver_list_item.dart';
import 'package:gilog/MVP/Presenter/Http/http_presenter.dart';
import 'package:gilog/MVP/View/Account/login.dart';

import '../../../../Utils/constants.dart';
import '../../../../Utils/deliver_item_widget.dart';
import '../../../Presenter/Http/deliver_http.dart';

class Deliver_liver_page extends StatefulWidget {
  const Deliver_liver_page({Key? key}) : super(key: key);

  @override
  _Deliver_liver_pageState createState() => _Deliver_liver_pageState();
}

class _Deliver_liver_pageState extends State<Deliver_liver_page> {
  List<dynamic>? data = [];

  int one = 0;
  int two = 0;
  int three = 0;
  int four = 0;
  int five = 0;

  @override
  void initState() {
    // TODO: implement initState
    // init_void();
    super.initState();
  }

  init_void() async {
    var token = await Http_Presenter().read_token();
    data = await Deliver_Http().get_item_list(token, context);
    // print(data![0].payState);
    check();
    if (data == null) {
      return "nulll";
    } else {
      return data;
    }
  }

  check() {
    one = 0;
    two = 0;
    three = 0;
    four = 0;
    five = 0;
    for (var i = 0; data!.length > i; i++) {
      switch (data![i].deliveryState) {
        case 1:
          one += 1;
          break;
        case 2:
          two += 1;
          break;
        case 3:
          three += 1;
          break;
        case 4:
          four += 1;
          break;
        case 5:
          five +=1;
          break;
      }
    }

    print("one$one two$two three$three four$four");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //색변경
        ),
      ),
      body: FutureBuilder(
          future: init_void(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == false) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData == false) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 0.7, color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  InkWell(
                      onTap: () async {
                        print(data!.length);
                      },
                      child: Text(
                        ("주문/배송 조회"),
                        style: TextStyle(fontSize: 21),
                      )),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Container(
                    width: size.width * 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: Colors.grey),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Container(
                        width: size.width * 1,
                        height: size.height * 0.62,
                        color: Colors.grey.shade200,
                        child: Center(
                            child: Text(
                          "아직 주문한 기록이 없습니다!",
                          style: TextStyle(fontSize: 18),
                        ))),
                  ),
                ],
              );
            }
            //error가 발생하게 될 경우 반환하게 되는 부분
            if (snapshot.hasError) {
              return Center(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator()),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 0.7, color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  InkWell(
                      onTap: () async {
                        print(data!.length);
                      },
                      child: Text(
                        ("주문/배송 조회"),
                        style: TextStyle(fontSize: 21),
                      )),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Container(

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: size.width * 0.2,
                          child: Column(
                            children: [
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: size.width * 0.06,
                                  ),
                                  Text("$one"),
                                  SizedBox(
                                    width: size.width * 0.04,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 15,
                                    color: Colors.grey.shade400,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Row(
                                children: [
                                  SizedBox(width: size.width*0.02,),
                                  Text("준비중"),

                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: size.width * 0.2,
                          child: Column(
                            children: [
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: size.width * 0.06,
                                  ),
                                  Text("$two"),
                                  SizedBox(
                                    width: size.width * 0.07,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 15,
                                    color: Colors.grey.shade400,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Row(
                                children: [
                                  Text("배송보류"),
                                  SizedBox(
                                    width: size.width * 0.04,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: size.width * 0.2,
                          child: Column(
                            children: [
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: size.width * 0.06,
                                  ),
                                  Text("$three"),
                                  SizedBox(
                                    width: size.width * 0.04,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 15,
                                    color: Colors.grey.shade400,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: size.width * 0.025,
                                  ),
                                  Text("배송대기"),
                                  SizedBox(
                                    width: size.width * 0.04,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: size.width * 0.2,
                          child: Column(
                            children: [
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: size.width * 0.06,
                                  ),
                                  Text("$three"),
                                  SizedBox(
                                    width: size.width * 0.04,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 15,
                                    color: Colors.grey.shade400,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: size.width * 0.025,
                                  ),
                                  Text("배송중"),
                                  SizedBox(
                                    width: size.width * 0.04,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: size.width * 0.2,
                          child: Column(
                            children: [
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: size.width * 0.06,
                                  ),
                                  Text("$four"),
                                  SizedBox(
                                    width: size.width * 0.04,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Row(
                                children: [
                                  Text("배송완료"),
                                  SizedBox(
                                    width: size.width * 0.04,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: Colors.grey),
                      ),
                    ),
                  ),
                  Container(
                      width: size.width * 1,
                      height: size.height * 0.62,
                      color: Colors.grey.shade200,
                      child: ListView.builder(
                          itemCount: data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Deliver_Item(
                                id: data![index].id,
                                prcie: data![index].price,
                                datetime: data![index].orderDate,
                            payState: data![index].payState,);
                          })),
                ],
              );
            }
          }),
    );
  }
}
