-- создаём базу данных для 1 семинара
DROP DATABASE IF EXISTS lesson_1;
CREATE DATABASE lesson_1;
USE lesson_1;

/* Задача 1
Создайте таблицу с мобильными телефонами. 
Заполните БД данными (поля и наполнение из презентации)
*/

-- создание таблицы
CREATE TABLE mobile_phones(
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
	product_name VARCHAR(45) NOT NULL, 
	manufacturer VARCHAR(45) NOT NULL,
    product_count SMALLINT UNSIGNED NOT NULL DEFAULT 0,
	price DECIMAL(10,0) NOT NULL DEFAULT 0
);

-- наполнение таблицы
INSERT INTO mobile_phones (
product_name, manufacturer, product_count, price)
VALUES
('iPhone X', 'Apple', 3, 76000),
('iPhone 8', 'Apple', 2, 51000),
('Galaxy S9', 'Samsung', 2, 56000),
('Galaxy S8', 'Samsung', 1, 41000),
('P20 Pro', 'Huawei', 5, 36000);

/* Задача 2
Выведите название, производителя и цену для товаров, 
количество которых превышает 2
*/

-- Вывод товаров, количество которых превышает 2
set @not_display = 2;
SELECT product_name, manufacturer, price
FROM mobile_phones
WHERE product_count > @not_display;

/* Задача 3
Выведите весь ассортимент товаров марки “Samsung”
*/

-- Вывод товаров марки “Samsung”
SET @display = 'Samsung';
SELECT product_name, manufacturer, product_count, price
FROM mobile_phones
WHERE manufacturer = @display;

/* Задача 4
* С помощью регулярных выражений найти:
	4.1. Товары, в которых есть упоминание "Iphone"
	4.2. Товары, в которых есть упоминание "Samsung"
	4.3. Товары, в которых есть ЦИФРЫ
	4.4. Товары, в которых есть ЦИФРА "8"
*/

-- 4.1. Вывод товаров, в которых есть упоминание "Iphone"
SET @finde = '%Iphone%';
SELECT product_name, manufacturer, product_count, price 
FROM mobile_phones
WHERE product_name LIKE @finde
OR manufacturer LIKE @finde;

-- 4.2. Вывод товаров, в которых есть упоминание "Samsung"
SET @finde = '%Samsung%';
SELECT product_name, manufacturer, product_count, price 
FROM mobile_phones
WHERE product_name LIKE @finde
OR manufacturer LIKE @finde;

-- 4.3. Вывод товаров, в которых есть ЦИФРЫ
SET @finde = '[0-9]';
SELECT product_name, manufacturer, product_count, price 
FROM mobile_phones
WHERE product_name REGEXP @finde
OR manufacturer REGEXP @finde;

-- 4.4. Вывод товаров, в которых есть ЦИФРА "8"
SET @finde = '[8]';
SELECT product_name, manufacturer, product_count, price 
FROM mobile_phones
WHERE product_name REGEXP @finde
OR manufacturer REGEXP @finde;