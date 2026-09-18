-- Deletes prior tables if they exist
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS bizums;
DROP TABLE IF EXISTS direct_debits;
DROP TABLE IF EXISTS atms;
DROP TABLE IF EXISTS accounts;
DROP TABLE IF EXISTS users;

-- Represent users of the bank
CREATE TABLE "users" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "phone_number" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password_hash" TEXT NOT NULL,   
    PRIMARY KEY("id")
);

-- Represent accounts of the users
CREATE TABLE "accounts" (
    "id" INTEGER,
    "user_id" INTEGER,
    "balance" REAL NOT NULL DEFAULT '0.00',
    PRIMARY KEY("id"),
    FOREIGN KEY ("user_id") REFERENCES "users"("id")
);

-- Represent atm transactions 
CREATE TABLE "atms" (
    "id" INTEGER,
    "location" TEXT NOT NULL,
    "bank_branch" TEXT,
    PRIMARY KEY("id")
);

-- Represent recurrent direct debits
CREATE TABLE "direct_debits" (
    "id" INTEGER,
    "account_id" INTEGER NOT NULL,
    "company_name" TEXT NOT NULL, -- Ej: Iberdrola, Netflix
    "amount" REAL NOT NULL,
    "frequency" TEXT NOT NULL CHECK("frequency" IN ('monthly', 'yearly')),
    "next_payment_date" TEXT NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY ("account_id") REFERENCES "accounts"("id")
);

-- Represent Bizums mobile transfers
CREATE TABLE "bizums" (
    "id" INTEGER,
    "sender_account_id" INTEGER,
    "receiver_phone" TEXT NOT NULL,
    "amount" REAL NOT NULL,
    "timestamp" DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("id"),
    FOREIGN KEY ("sender_account_id") REFERENCES "accounts"("id")
);

-- Represent posible transaction in the account
CREATE TABLE "transactions" (
    "id" INTEGER,
    "account_id" INTEGER NOT NULL,
    "amount" REAL NOT NULL,
    "type" TEXT NOT NULL CHECK("type" IN ('bizum', 'atm', 'direct_debit', 'transfer')),
    "atm_id" INTEGER,             
    "direct_debit_id" INTEGER,   
    "bizum_id" INTEGER,          
    "timestamp" DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("id"),
    FOREIGN KEY ("account_id") REFERENCES "accounts"("id"),
    FOREIGN KEY ("atm_id") REFERENCES "atms"("id"),
    FOREIGN KEY ("direct_debit_id") REFERENCES "direct_debits"("id"),
    FOREIGN KEY ("bizum_id") REFERENCES "bizums"("id")
);

-- Create indexes to speed common searches
CREATE INDEX "index_transactions_account" ON "transactions"("account_id");
CREATE INDEX "index_transactions_date" ON "transactions"("timestamp");
CREATE INDEX "index_users_phone" ON "users"("phone_number");
