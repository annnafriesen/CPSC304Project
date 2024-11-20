DROP TABLE Allergy;
DROP TABLE UserHasAllergy;
DROP TABLE User;
DROP TABLE PremiumUser;
DROP TABLE StandardUser;
DROP TABLE BudgetUser;
DROP TABLE UserCreatesMealPlan;
DROP TABLE Rating;
DROP TABLE Equipment;
DROP TABLE EquipmentLocations;
DROP TABLE Recipe;
DROP TABLE RecipeHasIngredient;
DROP TABLE MealPlanContainsRecipe;
DROP TABLE Ingredient;
DROP TABLE MealPlan;
DROP TABLE GroceryList;
DROP TABLE GroceryListContainsIngredient;

CREATE TABLE Allergy (type VARCHAR PRIMARY KEY);

CREATE TABLE UserHasAllergy
(allergyType VARCHAR,
userID INTEGER,
severity VARCHAR,
PRIMARY KEY (allergyType, userID),
FOREIGN KEY allergyType REFERENCES Allergy(allergyType)
ON DELETE CASCADE
ON UPDATE CASCADE,
FOREIGN KEY userID REFERENCES User(userID));

CREATE TABLE User
(userID INTEGER PRIMARY KEY,
fullName VARCHAR,
country VARCHAR,
userPrefID INTEGER UNIQUE,
cuisine VARCHAR,
diet VARCHAR,
groceryStore VARCHAR);

CREATE TABLE PremiumUser
(userID INTEGER PRIMARY KEY,
nutritionalAdvisorName VARCHAR,
FOREIGN KEY userID REFERENCES User(userID));

CREATE TABLE StandardUser
(userID INTEGER PRIMARY KEY,
mealPlanLimit INTEGER,
FOREIGN KEY userID REFERENCES User(userID));

CREATE TABLE BudgetUser
(userID INTEGER PRIMARY KEY,
studentDiscount FLOAT,
FOREIGN KEY userID REFERENCES User(userID));

CREATE TABLE UserCreatesMealPlan
(userID INTEGER,
mealPlanID INTEGER,
PRIMARY KEY (userID, mealPlanID),
FOREIGN KEY userID REFERENCES User(userID),
FOREIGN KEY mealPlanID REFERENCES MealPlan(mealPlanID)
ON DELETE SET NULL);

CREATE TABLE Rating
(ratingID INTEGER PRIMARY KEY,
overallRating INTEGER,
difficultlyRating INTEGER,
userID INTEGER NOT NULL,
recipeID INTEGER NOT NULL,
FOREIGN KEY userID REFERENCES User(userID),
FOREIGN KEY recipeID REFERENCES Recipe(ID));

CREATE TABLE Equipment
(equipmentID INTEGER,
equipmentType VARCHAR,
PRIMARY KEY (equipmentID, equipmentType));

CREATE TABLE EquipmentLocations
(equipmentType VARCHAR PRIMARY KEY,
equipmentLocation VARCHAR);

CREATE TABLE Recipe
(ID INTEGER PRIMARY KEY,
name VARCHAR,
author VARCHAR);

CREATE TABLE RecipeHasIngredient
(recipeID INTEGER,
ingredientName VARCHAR,
quantity INTEGER,
PRIMARY KEY (recipeID, ingredientName),
FOREIGN KEY recipeID REFERENCES Recipe(ID),
FOREIGN KEY ingredientName REFERENCES Ingredient(name)
ON DELETE CASCADE);

CREATE TABLE MealPlanContainsRecipe
(mealPlanID INTEGER,
recipeID INTEGER,
PRIMARY KEY (mealPlanID, recipeID),
FOREIGN KEY mealPlanID REFERENCES MealPlan(mealPlanID),
FOREIGN KEY recipeID REFERENCES Recipe(ID)
ON DELETE CASCADE);

CREATE TABLE Ingredient
(name VARCHAR PRIMARY KEY,
foodGroup VARCHAR);

CREATE TABLE IngredientNutritionalInfo
(name VARCHAR,
calories INTEGER,
fat INTEGER,
protein INTEGER,
PRIMARY KEY (name, calories),
FOREIGN KEY name REFERENCES Ingredient(name));

CREATE TABLE MealPlan
(mealPlanID INTEGER PRIMARY KEY,
endDate DATE,
startDate DATE NOT NULL,
groceryListID INTEGER,
FOREIGN KEY groceryListID REFERENCES groceryList(groceryListID));

CREATE TABLE GroceryList
(groceryListID INTEGER PRIMARY KEY,
totalPrice INTEGER);

CREATE TABLE GroceryListContainsIngredient
(groceryListID INTEGER,
ingredientName VARCHAR,
PRIMARY KEY (groceryListID, ingredientName),
FOREIGN KEY groceryListID REFERENCES GroceryList(groceryListID),
FOREIGN KEY ingredientName REFERENCES Ingredient(name)
ON DELETE CASCADE);

INSERT INTO
Allergy (“type”)
VALUES
	(“Strawberry”),
	(“Tree Nuts”),
	(“Dairy”),
	(“Shellfish”),
	(“Eggs”);

INSERT INTO
UserHasAllergy (allergyType, userID, severity)
VALUES
	(“Dairy”, 4, “Severe”),
	(“Strawberry”, 5, “Mild”),
(“Eggs”, 4, “Mild”),
(“Dairy”, 3, “Severe”),
(“Shellfish”, 1, “Mild”);

INSERT INTO
	User (userID, fullName, country, userPrefID, cuisine, diet, groceryStore)
VALUES
	(1, “Alex Dart”, “Canada”, 1, “Standard”, NULL, “Save-On Kerrisdale”),
	(2, “Griffin Velichko”, “Canada”, 2, “Standard”, NULL, “Save-On Dunbar”),
	(3, “Anna Friesen”, “Canada”, 3, “Standard”, NULL, “Save-On Wesbrook”),
	(4, “LeBron James”, “USA”, 4, “Standard”, “Vegan”, “Save-On Kerrisdale”),
	(5, “Grant Sanderson”, “USA”, 5, “Standard”, NULL, “Save-On Dunbar”);

INSERT INTO
PremiumUser (userID, nutritionalAdvisorName)
VALUES
	(1, “Gordon Ramsay”),
	(2, “Gordon Ramsay”),
	(3, “Gordon Ramsay”);

INSERT INTO
StandardUser (userID, mealPlanLimit)
VALUES
	(5, 10);
INSERT INTO
BudgetUser (userID, studentDiscount)
VALUES
	(4, 0.15);

INSERT INTO
	userCreatesMealPlan (userID, mealPlanID)
VALUES
	(1, 1),
	(4, 2),
	(2, 3),
	(4, 4),
	(3, 5);

INSERT INTO
	Rating (ratingID, overallRating, difficultyRating, userID, recipeID)
VALUES
	(1, 4, 3, 1, 2),
	(2, 5, 2, 3, 1),
	(3, 5, 3, 2, 1),
	(4, 3, 4, 5, 4),
	(5, 2, 5, 2, 3);

INSERT INTO
	Equipment (equipmentID, equipmentType)
VALUES
	(1, “Large Knife”),
	(2, “Frying Pan”),
	(3, “Oven”),
	(4, “Spoon”),
	(5, “Mixing Bowl”);

INSERT INTO
	EquipmentLocations (equipmentType, equipmentLocation)
VALUES
	(“Large Knife”, “Knife Block”),
	(“Frying Pan”, “Cabinet”),
	(“Oven”, “Kitchen”),
	(“Spoon”, “Drawer”),
	(“Mixing Bowl”, “Cabinet”);

INSERT INTO
	Recipe (ID, name, author)
VALUES
	(1, “Fried Chicken”, “Anthony Bourdain”),
	(2, “Pancakes”, “Aunt Jemimah”),
	(3, “Ratatouille”, “Remy from Ratatouille”),
	(4, “Shrimp Fried Rice”, “A Shrimp”),
	(5, “Chili”, “Alex Dart”);

INSERT INTO
	RecipeHasIngredient (recipeID, ingredientName, quantity)
VALUES
	(1, “Chicken”, 5),
	(2, “Pancake Mix”, 3),
	(3, “Onion”, 2),
	(4, “Shrimp”, 3),
	(5, “Ground Beef”, 5),
	(1, “Oil”, 10),
	(2, “Water”, 3),
	(3, “Tomato”, 2),
	(4, “Rice”, 5),
	(5, “Diced Tomato”, 7);

INSERT INTO
	MealPlanContainsRecipe (mealPlanID, recipeID)
VALUES
	(1, 1),
	(1, 2),
	(1, 3),
	(2, 2),
	(3, 5);

INSERT INTO
	Ingredient (name, foodGroup)
VALUES
	(“Chicken”, “Meat”),
	(“Pancake Mix”, “Assorted”),
	(“Onion”, “Vegetable”),
	(“Shrimp”, “Seafood”),
	(“Ground Beef”, “Meat”),
	(“Oil”, “Liquids”),
	(“Water”, “Liquids”),
	(“Tomato”, “Vegetable”),
	(“Rice”, “Starches”),
	(“Diced Tomato”, “Vegetable”);

INSERT INTO
	IngredientNutritionalInfo (name, calories, fat, protein)
VALUES
	(“Chicken”, 100, 12, 15),
	(“Pancake Mix”, 150, 22, 2),
	(“Onion”, 75, 0, 1),
	(“Shrimp”, 125, 17, 13),
	(“Ground Beef”, 135, 10, 22),
	(“Oil”, 430, 26, 1),
	(“Water”, 0, 0, 0),
	(“Tomato”, 55, 1, 0),
	(“Rice”, 175, 13, 2),
	(“Diced Tomato”, 55, 1, 0);

INSERT INTO
	MealPlan (mealPlanID, endDate, startDate, groceryListID)
VALUES
	(1, 2024-10-14, 2024-10-21, 1),
	(2, 2024-10-14, 2024-10-21, 2),
	(3, 2024-10-14, 2024-10-21, 3),
	(4, 2024-10-17, 2024-10-24, 4),
	(5, 2024-10-19, 2024-10-26, 5);

INSERT INTO
	GroceryList (groceryListID, totalPrice)
VALUES
	(1, 21),
	(2, 33),
	(3, 24),
	(4, 56),
	(5, 13);

INSERT INTO
	GroceryListContainsIngredient (groceryListID, ingredientName)
VALUES
	(1, “Chicken”),
	(1, “Oil”),
	(2, “Pancake Mix”),
	(2, “Water”),
	(3, “Onion”),
	(3, “Tomato”),
	(4, “Shrimp”),
	(4, “Rice”),
	(5, “Ground Beef”);

