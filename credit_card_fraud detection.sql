create database if not exists creditcardtransactions;
use creditcardtransactions;
select * from transactions;
select * from cc_info;

SHOW TABLES;
SELECT * FROM transactions;
SELECT * FROM cc_info;

SELECT DISTINCT state FROM cc_info;

SELECT count(credit_card) FROM transactions; #294588
SELECT count(credit_card) FROM cc_info;

SELECT count(t.credit_card) FROM transactions t JOIN cc_info c
ON t.credit_card = c.credit_card; #294588

SELECT * FROM transactions t JOIN cc_info c
ON t.credit_card = c.credit_card;

SELECT * FROM transactions t join cc_info c
ON t.credit_card = c.credit_card
WHERE c.credit_card_limit < t.transaction_dollar_amount;

CREATE TABLE credit_card_data AS
SELECT t.*, c.*
FROM transactions t
JOIN cc_info c
ON t.credit_card = c.credit_card;
/*The credit_card column exists in both transactions (t) and cc_info (c) tables. 
When using SELECT t.*, c.*, the result includes two columns named credit_card, causing a conflict.*/

CREATE TABLE credit_card_data AS 
SELECT 
    t.credit_card AS card_number, 
    t.`date`, 
    t.transaction_dollar_amount, 
    t.`Long`, -- column names are not case sensitive, used backticks since 'Long' is a special keyword
    t.lat, 
    c.city, 
    c.state, 
    c.zipcode, 
    -- c.credit_card AS card_number, -- Alias to avoid duplication
    c.credit_card_limit
FROM transactions t
JOIN cc_info c 
ON t.credit_card = c.credit_card;

SELECT * FROM credit_card_data;

DESCRIBE credit_card_data;

  


ALTER TABLE credit_card_data MODIFY `date` DATETIME;

CREATE INDEX idx_card_number_date ON credit_card_data (card_number, `date`);
CREATE INDEX idx_coordinates ON credit_card_data (`long`, lat);

SELECT ST_Distance(
    POINT(t1.long, t1.lat), 
    POINT(t2.long, t2.lat)
) AS distance
FROM credit_card_data t1
JOIN credit_card_data t2 ON t1.card_number = t2.card_number;


SELECT 
    t1.card_number AS card_number, 
    t1.`date` AS transaction_date_1, 
    t2.`date` AS transaction_date_2, 
    t1.city AS city1, 
    t2.city AS city2
FROM credit_card_data t1
JOIN credit_card_data t2
  ON t1.card_number = t2.card_number
 AND t1.`date` < t2.`date`
WHERE ST_Distance(
    POINT(t1.`long`, t1.lat), 
    POINT(t2.`long`, t2.lat)
) > 500
  AND TIMESTAMPDIFF(HOUR, t1.`date`, t2.`date`) < 1; # zero rows returned

