bool validateLoginDetails(String uname,String pw){
  if(uname.isNotEmpty && pw.isNotEmpty) {
    return true;
  }
  else{
    return false;
  }
}