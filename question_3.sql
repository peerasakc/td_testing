insert into `kaidee-client.data_service.x_sales_transaction`
values (1,1,5)
 ,(1,2,7)
 ,(2,3,1)
 ,(3,2,3)
 ,(4,4,10)
 ,(4,5,5)
 ,(4,6,2)
 ,(4,7,3);

insert into `kaidee-client.data_service.x_product`
values (1,'aa',10,1)
 ,(2,'bb',20,1)
 ,(3,'cc',30,2)
 ,(4,'dd',10,3)
 ,(5,'dd',20,3)
 ,(6,'dd',50,3)
 ,(7,'dd',5,3);

insert into `kaidee-client.data_service.x_product_class`
values (1,'class a')
 ,(2,'class b')
 ,(3,'class c');

with processing as
(
 select pc.product_class_name,p.product_name,st.quantity,sum(st.quantity*p.retail_price) as sales_value
 from `kaidee-client.data_service.x_sales_transaction` st
 join `kaidee-client.data_service.x_product` p
   on st.product_id = p.product_id
 join `kaidee-client.data_service.x_product_class` pc
   on p.product_class_id = pc.product_class_id
 group by pc.product_class_name,p.product_name,st.quantity
)
, result_rank as
(
 select *
   ,RANK() OVER ( PARTITION BY processing.product_class_name ORDER BY processing.product_class_name,processing.sales_value desc,processing.quantity ) AS rank
 from processing
)
 select *
 from result_rank
 where rank <= 2
 order by product_class_name,rank;