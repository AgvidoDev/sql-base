# Шпаргалка по SQL (PostgreSQL)

```sql
-- =====================================================
-- ШПАРГАЛКА ПО SQL (PostgreSQL)
-- =====================================================

-- ===== SELECT — выборка данных =====
SELECT column1, column2 FROM table_name WHERE condition;
SELECT DISTINCT column FROM table;  -- уникальные значения
SELECT * FROM table LIMIT 10;       -- первые 10 записей

-- ===== INSERT — вставка данных =====
INSERT INTO table (column1, column2) VALUES (value1, value2);
INSERT INTO table VALUES (value1, value2);  -- все колонки по порядку
INSERT INTO table (column) VALUES (value) RETURNING *;  -- вставка с возвратом

-- ===== UPDATE — обновление данных =====
UPDATE table SET column1 = value1 WHERE condition;
UPDATE table SET column1 = value1, column2 = value2 WHERE id = 1;

-- ===== DELETE — удаление данных =====
DELETE FROM table WHERE condition;
DELETE FROM table;  -- все записи (осторожно!)
TRUNCATE table;     -- быстрая очистка таблицы

-- ===== CREATE — создание объектов =====
CREATE DATABASE db_name;                    -- база данных
CREATE SCHEMA schema_name;                   -- схема
CREATE TABLE table_name (                    -- таблица
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price NUMERIC(10,2) CHECK (price > 0),
    created_at TIMESTAMP DEFAULT NOW()
);

-- ===== ALTER — изменение структуры =====
ALTER TABLE table ADD column type;           -- добавить колонку
ALTER TABLE table DROP column;                -- удалить колонку
ALTER TABLE table RENAME TO new_name;         -- переименовать таблицу
ALTER TABLE table ALTER column SET NOT NULL;  -- изменить ограничение

-- ===== DROP — удаление объектов =====
DROP TABLE table;                             -- удалить таблицу
DROP TABLE IF EXISTS table;                    -- удалить если существует
DROP DATABASE db_name;                         -- удалить базу (осторожно!)
DROP SCHEMA schema_name CASCADE;                -- удалить схему со всем содержимым

-- ===== JOIN — объединение таблиц =====
-- INNER JOIN   -- только совпадающие записи
-- LEFT JOIN    -- все из левой + совпадения из правой
-- RIGHT JOIN   -- все из правой + совпадения из левой
-- FULL JOIN    -- все записи из обеих таблиц
-- CROSS JOIN   -- декартово произведение
SELECT * FROM t1 JOIN t2 ON t1.id = t2.fk_id;

-- ===== GROUP BY — группировка =====
SELECT category, COUNT(*) FROM table GROUP BY category;
SELECT category, AVG(price) FROM table GROUP BY category HAVING AVG(price) > 100;

-- ===== ORDER BY — сортировка =====
SELECT * FROM table ORDER BY column ASC;   -- по возрастанию
SELECT * FROM table ORDER BY column DESC;  -- по убыванию
SELECT * FROM table ORDER BY col1, col2;   -- по нескольким колонкам

-- ===== ТИПЫ ДАННЫХ =====
-- INT, INT2 (small), INT4, INT8 (big)        -- целые числа
-- SERIAL, BIGSERIAL                          -- автоинкремент
-- NUMERIC(10,2), DECIMAL                      -- числа с плавающей точкой
-- VARCHAR(n), CHAR(n), TEXT                    -- строки
-- BOOLEAN                                      -- true/false
-- DATE, TIME, TIMESTAMP                        -- дата/время
-- JSON, JSONB                                   -- JSON данные
-- ARRAY                                          -- массивы

-- ===== ОГРАНИЧЕНИЯ (Constraints) =====
-- PRIMARY KEY                -- уникальный идентификатор
-- FOREIGN KEY                -- ссылка на другую таблицу
-- NOT NULL                   -- не может быть NULL
-- UNIQUE                     -- все значения уникальны
-- CHECK (условие)            -- проверка условия
-- DEFAULT значение           -- значение по умолчанию

-- ===== УСТАНОВКА СВЯЗЕЙ =====
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),                    -- краткая форма
    product_id INT, 
    FOREIGN KEY (product_id) REFERENCES products(id)     -- полная форма
);

-- ===== РАБОТА СО СХЕМАМИ =====
SET search_path TO schema_name;        -- переключиться на схему
SHOW search_path;                       -- показать текущую схему
CREATE SCHEMA IF NOT EXISTS schema;      -- создать если не существует

-- ===== ПОЛЕЗНЫЕ ФУНКЦИИ =====
SELECT NOW(), CURRENT_DATE, CURRENT_TIMESTAMP;   -- текущие дата/время
SELECT DATE_PART('year', date_column);           -- извлечь часть даты
SELECT EXTRACT(YEAR FROM date_column);            -- альтернатива DATE_PART
SELECT COUNT(*), SUM(column), AVG(column);       -- агрегатные функции
SELECT MIN(column), MAX(column);                   -- минимум/максимум
SELECT COALESCE(column, 'default');                -- заменить NULL на значение
SELECT CAST(value AS type);                         -- преобразование типа

-- ===== УСЛОВНЫЕ КОНСТРУКЦИИ =====
SELECT 
    name,
    CASE 
        WHEN age < 18 THEN 'child'
        ELSE 'adult' 
    END as type
FROM users;

-- ===== КОММЕНТАРИИ =====
-- однострочный комментарий
/* 
   многострочный 
   комментарий 
*/

-- ===== УПРАВЛЕНИЕ ТРАНЗАКЦИЯМИ =====
BEGIN;               -- начать транзакцию
COMMIT;              -- подтвердить изменения
ROLLBACK;            -- откатить изменения
SAVEPOINT sp_name;   -- точка сохранения

-- ===== EXPLAIN — анализ запросов =====
EXPLAIN SELECT * FROM table;           -- показать план запроса
EXPLAIN ANALYZE SELECT * FROM table;    -- выполнить и проанализировать
```
