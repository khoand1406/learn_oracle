Create or replace function get_orders_by_date
--(
----    date_input orders.orderdatedate%type
--)
return number
is
    l_sum_order number :=0;
begin
    SELECT COUNT(*) AS numberoforders into l_sum_order
                        FROM orders o INNER JOIN cart c ON o.orderid = c.orderid
                        INNER JOIN account a ON c.userid = a.userid
--                        WHERE o.orderdate = :date_input
                        GROUP BY a.userid, a.username;
    
    return l_sum_order;
    end;
    
  --execute  
    DECLARE
    orders_count NUMBER;
    input_date DATE := TO_DATE('2023-10-13', 'YYYY-MM-DD'); -- Replace with your desired date
BEGIN
    orders_count := get_orders_by_date(input_date);
    DBMS_OUTPUT.PUT_LINE('Total orders for ' || TO_CHAR(input_date, 'YYYY-MM-DD') || ': ' || orders_count);
END;