/* Query personal total expense of  userId = 2*/
SELECT sum(amount * percentage / 100) AS userId_2_total_expense
FROM Expense
WHERE expenseId in (
	SELECT expenseId
	FROM Expense_Account
	WHERE accountId in (
		SELECT userId
		FROM Account
		WHERE userId = 2
	)
);

/* Query personal total expense  of  userId = 30 by category*/
SELECT sum(amount * percentage / 100) AS userId_30_total_expense_by_category_of_food
FROM Expense
WHERE expenseId in (
	SELECT expenseId
	FROM Expense_Account
	WHERE accountId in (
		SELECT accountId
		FROM Account
		WHERE userId = 30
	) AND category in (
		SELECT categoryId
		FROM category
		WHERE  name like "%Food%"
		)
);


/* Query personal total expense of  userId = 13 by account of mastercard*/
SELECT sum(amount * percentage / 100) AS userId_13_total_expense_by_account
FROM Expense
WHERE expenseId in (
	SELECT expenseId
	FROM Expense_Account
	WHERE accountId in (
		SELECT accountId
		FROM Account
		WHERE userId = 13 and accountName Like "%mastercard%"
	) 
);

/* Query personal total expense of  userId = 13 in Aug. 2021 (by period)*/
SELECT sum(amount * percentage  / 100) AS userId_13_total_expense_in_Aug_2021
FROM Expense
WHERE date like "%8/%/2021%" AND expenseId in (
	SELECT expenseId
	FROM Expense_Account
	WHERE accountId in (
		SELECT accountId
		FROM Account
		WHERE userId = 13
	) 
);


/* Query all users' monthly budget, partitioned by state*/
SELECT name, state, amount, count(*) Over (PARTITION BY state)
FROM User
JOIN User_Budget on User_Budget.userId = User.userId
JOIN Budget on Budget.budgetId = User_Budget.budgetId
WHERE period = 2;





/* Query count users who recorded over 1000 in the system*/
SELECT User.userId, sum(Expense.amount * Expense.percentage  / 100) as total_expense 
FROM Expense
JOIN Expense_Account on Expense_Account.expenseId = Expense.expenseId
JOIN Account on Account.accountId = Expense_Account.accountId
JOIN User on User.userId = Account.userId
GROUP by User.userId
HAVING total_expense > 1000;
