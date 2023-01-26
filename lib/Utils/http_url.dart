
final String endpoint = "http://ec2-43-200-33-232.ap-northeast-2.compute.amazonaws.com:8080";


class Http_URL{

  final REST_API_KEY = "ee4ee61f1ea69f5a8d5f5924343083f7";

  final REDIRECT_URL = "$endpoint/api/oauth2/code/kakao";

  //질문 가져오는 URL
  final String get_question = "$endpoint/api/question";
  final String get_server_data = "$endpoint/api/gi-log/all";

  final String update_gilog = "$endpoint/api/gi-log/edit";
 //기록 내용 보내는 URL
  final String post_gilog = "$endpoint/api/gi-log";
  //로그인후 해당 user 정보 가져오는 URL
  final String get_user_info = "$endpoint/api/userinfo";
  //기록 image 보내는 URL
  final String post_gilog_img = "$endpoint/api/gi-log/image";
  //주문 정보 보내는 URL
  final String post_deliver_info = "$endpoint/api/order";

  //처음 회원가입시 보낼 정보 입력 URL
  final String post_user_info = "$endpoint/api/user/info";

  final String get_item_list_url = "$endpoint/api/order";

  final String get_item_detail = "$endpoint/api/order/detail";

  final String post_apple_token_url = "$endpoint/api/oauth2/code/apple";

  final String logout_url = "$endpoint/api/user/delete";
}