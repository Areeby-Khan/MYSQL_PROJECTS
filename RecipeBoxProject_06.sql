CREATE DATABASE RecipeBoxProject;
USE RecipeBoxProject;

--Recipes Table
--Stores recipe details.
CREATE TABLE IF NOT EXISTS Recipes (
    recipe_id INT PRIMARY KEY AUTO_INCREMENT,
    recipe_name VARCHAR(100) NOT NULL,
    instructions TEXT
);
--INSERT DATA
INSERT INTO Recipes (recipe_name, instructions) VALUES 
('Pasta', 'Boil pasta and mix with sauce'),
('Salad', 'Chop vegetables and mix with dressing'),
('Burger','Patti with mashroum sause with cheese'),
('Noodles','Boiled chicken tikka noodles'),
('Smoke Chicken','Smoke with coal & aluminum foil'),
('grilled fish','Grilled strong steam with green sause'),
('Chicken Steak','Tender Chicken with Bbq sause');
SELECT *FROM Recipes;

--Ingredients Table
CREATE TABLE Ingredients (
    ingredient_id INT PRIMARY KEY AUTO_INCREMENT,
    ingredient_name VARCHAR(100) NOT NULL
);

--INSERT DATA
INSERT INTO Ingredients (ingredient_name) VALUES 
('Pasta'),
('Tomato Sauce'),
('Patti'),
('Chicken tikka'),
('Smoke Coal'),
('Olive Oil'),
('Bbq Sause');
SELECT *FROM Ingredients;

--Recipe_Ingredients Table
CREATE TABLE Recipe_Ingredients (
    recipe_id INT,
    ingredient_id INT,
    quantity_needed DECIMAL(5, 2), -- e.g., 2.5 (2.5 units)
    unit VARCHAR(20), -- e.g., 'grams', 'ml', etc.
    PRIMARY KEY (recipe_id, ingredient_id),
    FOREIGN KEY (recipe_id) REFERENCES Recipes(recipe_id),
    FOREIGN KEY (ingredient_id) REFERENCES Ingredients(ingredient_id)
);
--insert data
INSERT INTO Recipe_Ingredients (recipe_id, ingredient_id, quantity_needed, unit) VALUES 
(1, 1, 200, 'grams'), 
(1, 2, 100, 'grams'), 
(2, 3, 1, 'kg'), 
(2, 4, 2, 'kg'), 
(2, 5, 10, 'ml'),
(3,2,1,'grams');
SELECT *FROM Recipe_Ingredients;

--FRIGE TABLE 
CREATE TABLE Fridge (
    ingredient_id INT PRIMARY KEY,
    quantity_available DECIMAL(5, 2), 
    unit VARCHAR(20),
    FOREIGN KEY (ingredient_id) REFERENCES Ingredients(ingredient_id)
);


--INSERT DATA
INSERT INTO Fridge (ingredient_id, quantity_available, unit) VALUES 
(1, 250, 'grams'),
(2, 150, 'grams'),
(3, 2, 'unit'),  
(4, 3, 'unit'),  
(5, 50, 'ml'),
(6,40,'grams');
SELECT * FROM Fridge;

-- Query Recipes You Can Cook with Available Ingredients


SELECT r.recipe_name
FROM Recipes r
JOIN Recipe_Ingredients ri ON r.recipe_id = ri.recipe_id
JOIN Fridge f ON ri.ingredient_id = f.ingredient_id
WHERE f.quantity_available >= ri.quantity_needed 
AND f.unit = ri.unit
GROUP BY r.recipe_id
HAVING COUNT(ri.ingredient_id) = (SELECT COUNT(*) FROM Recipe_Ingredients WHERE recipe_id = r.recipe_id);
--List All Ingredients Required for a Recipe
SELECT i.ingredient_name, ri.quantity_needed, ri.unit
FROM Recipe_Ingredients ri
JOIN Ingredients i ON ri.ingredient_id = i.ingredient_id
WHERE ri.recipe_id = 1; 
--Check Ingredients Missing for a Specific Recipe

SELECT i.ingredient_name, ri.quantity_needed - IFNULL(f.quantity_available, 0) AS quantity_missing, ri.unit
FROM Recipe_Ingredients ri
JOIN Ingredients i ON ri.ingredient_id = i.ingredient_id
LEFT JOIN Fridge f ON ri.ingredient_id = f.ingredient_id
WHERE ri.recipe_id = 1 AND (f.quantity_available IS NULL OR f.quantity_available < ri.quantity_needed);

--List All Recipes with Ingredients and Quantities in the Fridge (Detailed Recipe Inventory)
SELECT r.recipe_name,
       i.ingredient_name,
       ri.quantity_needed AS required_quantity,
       ri.unit,
       IFNULL(f.quantity_available, 0) AS available_quantity,
       CASE 
           WHEN f.quantity_available >= ri.quantity_needed THEN 'Available'
           ELSE 'Insufficient'
       END AS status
FROM Recipes r
JOIN Recipe_Ingredients ri ON r.recipe_id = ri.recipe_id
JOIN Ingredients i ON ri.ingredient_id = i.ingredient_id
LEFT JOIN Fridge f ON ri.ingredient_id = f.ingredient_id
ORDER BY r.recipe_name;

--Project 02


