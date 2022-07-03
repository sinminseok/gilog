import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gilog/MVP/Model/deliver_list_item.dart';
import 'package:gilog/MVP/Presenter/Http/http_presenter.dart';

import '../../../../Utils/constants.dart';
import '../../../../Utils/deliver_item_widget.dart';

class Deliver_liver_page extends StatefulWidget {
  const Deliver_liver_page({Key? key}) : super(key: key);

  @override
  _Deliver_liver_pageState createState() => _Deliver_liver_pageState();
}

class _Deliver_liver_pageState extends State<Deliver_liver_page> {
  List<dynamic>? data = [];

  @override
  void initState() {
    // TODO: implement initState
    init_void();
    super.initState();
  }

  init_void() async {
    var token = await Http_Presenter().read_token();
    return data = await Http_Presenter().get_item_list(token);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
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
              return Center(child: CircularProgressIndicator());
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
                        // print(data!.length);
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
                                  Text("0"),
                                  SizedBox(
                                    width: size.width * 0.04,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 18,
                                    color: Colors.grey.shade400,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Row(
                                children: [
                                  Text("결제 완료"),
                                  SizedBox(
                                    width: size.width * 0.04,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: size.width * 0.24,
                          child: Column(
                            children: [
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: size.width * 0.06,
                                  ),
                                  Text("0"),
                                  SizedBox(
                                    width: size.width * 0.07,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 18,
                                    color: Colors.grey.shade400,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Row(
                                children: [
                                  Text("상품 준비중"),
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
                                  Text("0"),
                                  SizedBox(
                                    width: size.width * 0.04,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 18,
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
                                  Text("0"),
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
                      height: size.height * 0.64,
                      color: Colors.grey.shade200,
                      child: ListView.builder(
                          itemCount: data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Deliver_Item(
                                id: data![index].id,
                                prcie: data![index].price,
                                datetime: data![index].orderDate);
                          })),
                ],
              );
            }
          }),
    );
  }
}
