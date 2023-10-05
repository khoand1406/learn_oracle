DECLARE
    e1 EXCEPTION;
    PRAGMA exception_init (e1, -20001);
    e2 EXCEPTION;
    PRAGMA exception_init (e2, -20002);
    e3 EXCEPTION;
    PRAGMA exception_init (e3, -20003);
    l_input NUMBER := &input_number;
BEGIN
    -- inner block
    BEGIN
        IF l_input = 1 THEN
            raise_application_error(-20001,'Exception: the input number is 1');
        ELSIF l_input = 2 THEN
            raise_application_error(-20002,'Exception: the input number is 2');
        ELSE
            raise_application_error(-20003,'Exception: the input number is not 1 or 2');
        END IF;
    -- exception handling of the inner block
    EXCEPTION
        WHEN e1 THEN 
            dbms_output.put_line('Handle exception when the input number is 1');
    END;
    -- exception handling of the outer block
    EXCEPTION 
        WHEN e2 THEN
            dbms_output.put_line('Handle exception when the input number is 2');
END;

select a.userid, count(*) as numberoforders 
from orders o inner join cart c on o.orderid= c.orderid
inner join account a on c.userid= a.userid
where o.orderdate= '15-sep-23'
group by a.userid, a.username;

select * from orders o inner join cart c on o.orderid= c.orderid
inner join account a on c.userid= a.userid
where o.orderdate= '15-sep-23'
