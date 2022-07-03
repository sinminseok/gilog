
class Http_URL{
  //질문 가져오는 URL
  final String get_question = "http://ec2-3-39-195-205.ap-northeast-2.compute.amazonaws.com:8080/api/question";
 //기록 내용 보내는 URL
  final String post_gilog = "http://ec2-3-39-195-205.ap-northeast-2.compute.amazonaws.com:8080/api/gi-log";
  //로그인후 해당 user 정보 가져오는 URL
  final String get_user_info = "http://ec2-3-39-195-205.ap-northeast-2.compute.amazonaws.com:8080/api/userinfo";
  //기록 image 보내는 URL
  final String post_gilog_img = "http://ec2-3-39-195-205.ap-northeast-2.compute.amazonaws.com:8080/api/gi-log/image";
  //주문 정보 보내는 URL
  final String post_deliver_info = "http://ec2-3-39-195-205.ap-northeast-2.compute.amazonaws.com:8080/api/order";
  //배송정보 가져오는 URL
  final String get_deliver_info = "";

  //처음 회원가입시 보낼 정보 입력 URL
  final String post_user_info = "http://ec2-3-39-195-205.ap-northeast-2.compute.amazonaws.com:8080/api/user/info";

  final String get_item_list_url = "http://ec2-3-39-195-205.ap-northeast-2.compute.amazonaws.com:8080/api/order";

}