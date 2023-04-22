-- создание базы данных для 3 семинара
DROP DATABASE IF EXISTS lesson_3;
CREATE DATABASE lesson_3;
USE lesson_3;

-- Создание таблицы Персонал
DROP TABLE IF EXISTS staff;
CREATE TABLE staff (
	id INT AUTO_INCREMENT PRIMARY KEY, 
	firstname VARCHAR(45),
	lastname VARCHAR(45),
	post VARCHAR(100),
	seniority INT, 
	salary INT, 
	age INT
);

-- Наполнение таблицы данными
INSERT INTO staff (firstname, lastname, post, seniority, salary, age)
VALUES
	('Вася', 'Петров', 'Начальник', '40', 100000, 60),
	('Петр', 'Власов', 'Начальник', '8', 70000, 30),
	('Катя', 'Катина', 'Инженер', '2', 70000, 19),
	('Саша', 'Сасин', 'Инженер', '12', 50000, 35),
	('Иван', 'Иванов', 'Рабочий', '40', 30000, 59),
	('Петр', 'Петров', 'Рабочий', '20', 25000, 40),
	('Сидр', 'Сидоров', 'Рабочий', '10', 20000, 35),
	('Антон', 'Антонов', 'Рабочий', '8', 19000, 28),
	('Юрий', 'Юрков', 'Рабочий', '5', 15000, 25),
	('Максим', 'Максимов', 'Рабочий', '2', 11000, 22),
	('Юрий', 'Галкин', 'Рабочий', '3', 12000, 24),
	('Людмила', 'Маркина', 'Уборщик', '10', 10000, 49);
    
/* Задача 1
Отсортируйте данные по полю заработная плата (salary) в порядке: 
	- убывания; 
	- возрастания.
*/

-- сортировка данных по полю з/п (salary) в порядке убывания. 
SELECT salary FROM staff ORDER BY salary DESC;

-- сортировка данных по полю з/п (salary) в порядке возрастания. 
SELECT salary FROM staff ORDER BY salary;

/* Задача 2
Выведите 5 максимальных заработных плат (salary).
*/

-- вывод 5 максимальных заработных плат (salary).
SET @limit_view = 5;
PREPARE STMT FROM 'SELECT salary FROM staff ORDER BY salary DESC LIMIT ?';
EXECUTE STMT USING @limit_view;

/* Задача 3
Посчитайте суммарную зарплату (salary) по каждой специальности (роst).
*/

-- вывод суммарных зарплат (salary) по каждой специальности (роst).
SELECT post, SUM(salary) FROM staff GROUP BY post;

/* Задача 4
Найдите кол-во сотрудников с специальностью (post) «Рабочий» в возрасте 
от 24 до 49 лет включительно.
*/

-- вывод кол-ва сотрудников с специальностью (post) «Рабочий» 
-- в возрасте от 24 до 49 лет включительно.
SET @post_name_view = 'Уборщик',
	@age_min_view = 24, 
	@age_max_view = 49;
SELECT COUNT(post) AS cnt_staff FROM staff
WHERE post = @post_name_view
	AND age > @age_min_view
	AND age <= @age_max_view;

/* Задача 5
Найдите количество специальностей.
*/

-- вывод кол-ва специальностей.
SELECT COUNT(group_post) AS cnt_post
FROM (
	SELECT post AS group_post 
	FROM staff 
	GROUP BY post) AS cnt_staff;

/* Задача 6
Выведите специальности, у которых средний возраст сотрудников меньше 30 лет.
*/

-- вывод специальностей, у которых средний возраст сотрудников меньше 30 лет.
SET @age_max_view = 30;
SELECT post FROM staff 
GROUP BY post
HAVING AVG(age) < @age_max_view;
