CREATE OR REPLACE PROCEDURE count_orders (
    date_input orders.receiveddate%type,
    order_count_cursor OUT SYS_REFCURSOR
)
AS
    sql_statement VARCHAR(200);
BEGIN
    sql_statement := 'SELECT a.userid, COUNT(*) AS numberoforders 
                        FROM orders o INNER JOIN cart c ON o.orderid = c.orderid
                        INNER JOIN account a ON c.userid = a.userid
                        WHERE o.orderdate = :date_input
                        GROUP BY a.userid, a.username';
    OPEN order_count_cursor FOR sql_statement USING date_input;
END;
    
DECLARE
    order_count_cursor SYS_REFCURSOR;
    date_input DATE := TO_DATE('2023-10-02', 'YYYY-MM-DD');  -- Replace with your desired date
    user_name_l account.userid%type;
    count_result_l NUMBER;
BEGIN
    -- Call the count_orders procedure
    count_orders(date_input, order_count_cursor);

    -- Fetch the data from the cursor
    LOOP
        FETCH order_count_cursor INTO user_name_l, count_result_l;
        EXIT WHEN order_count_cursor%NOTFOUND;

        
        DBMS_OUTPUT.PUT_LINE('User: ' || user_name_l || ' has ' || count_result_l || ' orders');
    END LOOP;

    -- Close the cursor
    CLOSE order_count_cursor;
END;
 
 
                        
                
