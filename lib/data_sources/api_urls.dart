class ApiUrls{
  final Uri API_BASE_URL = Uri.parse('http://10.0.2.2:3001');
  final Uri API_USER_LIST = Uri.parse('https://api.randomuser.me/?results=10');
  final Uri API_USER_LOGIN = Uri.parse('http://127.0.0.1:3001/auth/login');
  final Uri API_CONTENTS_LIST = Uri.parse('http://10.0.2.2:3001/api/article/fe/allContents?page=1&perPage=10');
  final Uri API_DEAITL_CONTENTS = Uri.parse('http://10.0.2.2:3001/api/article/fe/getDetailContent');
  final Uri API_CONTENTS_LIST_BY_CATE = Uri.parse("http://10.0.2.2:3001/api/article/mobi/allContents/");
}