SELECT TOP 1 
JSON_VALUE(JSON_QUERY(waybill_data, '$.recipient_address'), '$.full_address'),
JSON_QUERY(waybill_data, '$.recipient_address'),
 display_order_number 
 ,waybill_data
FROM 
 _t_order_carton_master WITH (NOLOCK)


 select waybill_data,*
 FROM 
 _t_order_carton_master WITH (NOLOCK)


  SELECT JSON_VALUE(JSON_QUERY(
  '{"{""error"":""logistics.package_print_failed"",
""message"":""Some package failed to print, please try again later. Detail: order_sn: 221124V73Y31GP print failed."",
""request_id"":""1dd09935b7ec9987cf4a9dd596afda20""}"}'),'$.error')

 SELECT JSON_VALUE(JSON_QUERY(
 '{
  "cod": false,
  "cod_amount": 0,
  "create_date_ymd_sl": "2022/03/17",
  "deliver_area": "",
  "delivery_hub": "",
  "ec_order_no": "",
  "is_lm_dg_bool": 0,
  "lm_tn": "",
  "logistic_id": 30005,
  "manufacturers_name": "蝦皮購物",
  "manufacturers_website": "www.shopee.tw",
  "order_weight": 450,
  "pickup_hub": "",
  "preferred_delivery_option": 2,
  "recipient_addr": "新竹縣竹北市十興路318號.新瀧一街6號",
  "recipient_address": {
    "city": "",
    "country": "TW",
    "district": "",
    "full_address": "7-11 義山門市 新竹縣竹北市十興路318號.新瀧一街6號 店號200125",
    "name": "黃柏豪",
    "phone": "******725",
    "state": "",
    "town": null,
    "zipcode": null
  },
  "recipient_sort_code": {
    "first_recipient_sort_code": "",
    "second_recipient_sort_code": "",
    "third_recipient_sort_code": ""
  },
  "return_sort_code": {
    "return_first_sort_code": ""
  },
  "sender_sort_code": {
    "first_sender_sort_code": "",
    "second_sender_sort_code": "",
    "third_sender_sort_code": ""
  },
  "shipping_carrier": "7-11",
  "shopee_tracking_no": "TW228323095759Y",
  "sod": false,
  "spx_receive_station": {
    "spx_first_receive_station": ""
  },
  "spx_sub_district": "",
  "third_party_logistic_info": {
    "area": "",
    "barcode": "200125773UQ870416980",
    "barcode_dc": "",
    "barcode_no1": "",
    "barcode_no2": "",
    "barcode_no3": "",
    "barcode_no4": "",
    "barcode_no5": "",
    "barcode_pr": "",
    "branch_code": "",
    "branch_name": "",
    "customer_code": "",
    "deliver_area_txt": "",
    "deliver_date_ymd": "",
    "deliver_router": "",
    "ec_bar_code16": "",
    "ec_bar_code9": "",
    "ec_order_number": "",
    "ec_supplier_name": "",
    "equipment_id": "",
    "eshop_id": "",
    "first_pick_barcode": "",
    "is_cod_bool": false,
    "large_logistics_id": "",
    "last_third_digits_recipient_phone": "",
    "last_third_digits_sender_phone": "",
    "manufacturers_name": "蝦皮購物",
    "manufacturers_website": "www.shopee.tw",
    "md_driver_code": "",
    "ok_aisle_no": "",
    "ok_grid_no": "",
    "ok_mid_type": "",
    "ok_tracking_number": "",
    "order_no": "",
    "parent_id": "",
    "pelican_tracking_no": "",
    "pick_router": "",
    "print_date": "20220317",
    "print_datetime": "",
    "prompt": "",
    "purchase_time": 1647438542,
    "putorder_stackzone_code": "",
    "pzip": "",
    "pzip_c": "",
    "qrcode": "",
    "rcv_store_name": "",
    "receiver_name": "",
    "recipient_area": "",
    "return_cycle": "",
    "return_mode": "",
    "return_time": 1648296057,
    "route_step": "",
    "sd_driver_code": "",
    "second_pick_barcode": "",
    "service_description": "*商品已付款，請檢視證件*",
    "ship_type": "",
    "store_type": "",
    "suda5_code": ""
  },
  "tracking_no": "70416980",
  "zone": ""
}'
 
 
 
 , '$.recipient_address'), '$.full_address')
