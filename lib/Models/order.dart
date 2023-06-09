import 'item.dart';

class Order {
  String? order_id,
      user_id,
      user_name,
      user_mob_num,
      billing_address,
      reciever_id,
      party_name,
      party_address,
      party_gst_num,
      party_mob_num,
      base_price,
      status,
      loading_type,
      order_date,
      orderType,
      date;

  late List<Item> items;
}
