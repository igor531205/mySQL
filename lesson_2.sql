-- создаём базу данных для 2 семинара
DROP DATABASE IF EXISTS lesson_2;
CREATE DATABASE lesson_2;
USE lesson_2;

/* Задача 1
Используя операторы языка SQL, создайте таблицу “sales”.  
Заполните БД данными (поля и наполнение из презентации)
*/

-- создание таблицы
CREATE TABLE sales (
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
    order_date DATE NOT NULL, 
    count_product SMALLINT UNSIGNED NOT NULL DEFAULT 0
);

-- наполнение таблицы
INSERT INTO sales (
    order_date, count_product)
VALUES
    ('2022-01-01', 156),
    ('2022-01-02', 180),
    ('2022-01-03', 21),
    ('2022-01-04', 124),
    ('2022-01-05', 341);

/* Задача 2
Для таблицы “sales” укажите тип заказа в зависимости от кол-ва : 
меньше 100 - Маленький заказ
от 100 до 300 - Средний заказ
больше 300 - Большой заказ
*/

-- Вывод продаж
SET @lower_bound = 100, 
    @upper_bound = 300;
SELECT 
    id AS 'id заказа',
    order_date AS 'Дата',
    count_product AS 'Количество',
    CASE
        WHEN count_product < @lower_bound THEN 'Маленький заказ'
        WHEN count_product >= @lower_bound and
            count_product <= @upper_bound THEN 'Средний заказ'
        WHEN count_product > @upper_bound THEN 'Большой заказ'
        ELSE 'null'
    END AS 'Тип заказа'	
FROM sales;

/* Задача 3
Создайте таблицу “orders”, заполните ее значениями.
Выберите все заказы. В зависимости от поля order_status 
выведите столбец full_order_status: OPEN – «Order is in open state»; 
CLOSED - «Order is closed»; CANCELLED - «Order is cancelled»
*/

-- создание таблицы
CREATE TABLE orders (
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
    employee_id VARCHAR(10) NOT NULL, 
    amount DECIMAL(10,2) NOT NULL DEFAULT 0,
    order_status VARCHAR(16) NOT NULL
);

-- наполнение таблицы
INSERT INTO orders (
    employee_id, amount, order_status)
VALUES
    ('e03', 15.00, 'OPEN'),
    ('e01', 25.50, 'OPEN'),
    ('e05', 100.70 , 'CLOSED'),
    ('e02', 22.18, 'OPEN'),
    ('e04', 9.50, 'CANCELLED');

-- Вывод заказов
SET @state_open = 'OPEN', 
    @state_closed = 'CLOSED', 
    @state_cancelled = 'CANCELLED';
SELECT 
    id AS 'id заказа',
    employee_id AS 'id клиента',
    amount AS 'Сумма',
    CASE order_status
        WHEN @state_open THEN 'Заказ открыт'
        WHEN @state_closed THEN 'Заказ закрыт'
        WHEN @state_cancelled THEN 'Заказ отменен'
        ELSE 'Неизвестное состояние'
    END AS 'Статус'
FROM orders;
