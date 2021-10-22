BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "Category" (
	"categoryId"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT NOT NULL UNIQUE,
	PRIMARY KEY("categoryId" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Period" (
	"periodId"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT NOT NULL UNIQUE,
	PRIMARY KEY("periodId" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Account" (
	"accountId"	INTEGER NOT NULL UNIQUE,
	"accountName"	TEXT NOT NULL,
	"userId"	INTEGER NOT NULL,
	FOREIGN KEY("userId") REFERENCES "User"("userId"),
	PRIMARY KEY("accountId" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "User" (
	"userId"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT NOT NULL,
	"gender"	TEXT NOT NULL,
	"dateOfBirth"	INTEGER NOT NULL,
	"state"	TEXT,
	PRIMARY KEY("userId")
);
CREATE TABLE IF NOT EXISTS "User_Budget" (
	"UserId"	INTEGER NOT NULL,
	"budgetId"	INTEGER NOT NULL,
	FOREIGN KEY("UserId") REFERENCES "User"("userId"),
	FOREIGN KEY("budgetId") REFERENCES "Budget"("budgetId"),
	PRIMARY KEY("UserId","budgetId")
);
CREATE TABLE IF NOT EXISTS "Budget" (
	"budgetId"	INTEGER NOT NULL UNIQUE,
	"startDate"	INTEGER NOT NULL,
	"amount"	INTEGER NOT NULL,
	"period"	INTEGER NOT NULL,
	"description"	TEXT,
	FOREIGN KEY("period") REFERENCES "Period"("periodId"),
	PRIMARY KEY("budgetId" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Expense" (
	"expenseId"	INTEGER NOT NULL UNIQUE,
	"date"	INTEGER NOT NULL,
	"amount"	INTEGER NOT NULL,
	"category"	INTEGER NOT NULL,
	"description"	TEXT,
	"percentage"	INTEGER DEFAULT 100,
	FOREIGN KEY("category") REFERENCES "Category"("categoryId"),
	PRIMARY KEY("expenseId" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Expense_Account" (
	"expenseId"	INTEGER NOT NULL,
	"accountId"	INTEGER NOT NULL,
	FOREIGN KEY("accountId") REFERENCES "Account"("accountId"),
	FOREIGN KEY("expenseId") REFERENCES "Expense"("expenseId"),
	PRIMARY KEY("expenseId","accountId")
);
COMMIT;
