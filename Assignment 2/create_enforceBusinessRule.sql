Use Pizza_test

DROP TRIGGER checkIngredients

CREATE TRIGGER checkIngredients
	ON Ingredient
	FOR UPDATE
AS
BEGIN
	DECLARE @count INT
	SET @count = 0

    	-- Checking inserted's ingredients
	SELECT @count = COUNT(*)
	FROM Ingredient
	WHERE CurrentStockLevel<0;

	IF @count > 0
	BEGIN
		RAISERROR('Not enough ingredients, the command is terminated', 11, 1)
		ROLLBACK TRANSACTION
		DELETE FROM Orders WHERE OrderNo=(SELECT max(OrderNo) FROM Orders);
	END


END