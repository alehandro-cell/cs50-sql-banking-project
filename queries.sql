-- Clients registration,two for bizum
INSERT INTO "users" ("name", "phone_number", "email", "password_hash")
VALUES ('Lucía Gómez', '+34600123456', 'lucia@email.com', '$2b$12$examplehash123');

INSERT INTO "users" ("name", "phone_number", "email", "password_hash")
VALUES ('Carlos Pérez', '+34699887766', 'carlos@email.com', '$2b$12$examplehash456');

INSERT INTO "accounts" ("user_id", "balance")
VALUES (2, 100.00);

-- Find actual account balance and most recent transactions order by date
SELECT 
    "accounts"."id" AS "account_id",
    "accounts"."balance",
    "transactions"."amount",
    "transactions"."type",
    "transactions"."timestamp"
FROM "accounts"
JOIN "transactions"  ON "accounts"."id" = "transactions"."account_id"
WHERE "accounts"."user_id" = '1'
ORDER BY "transactions"."timestamp" DESC
LIMIT 10;

-- Bizum simulation
INSERT INTO "bizums" ("sender_account_id", "receiver_phone", "amount")
VALUES (1, '+34699887766', 25.50);

INSERT INTO "transactions" ("account_id", "amount", "type", "bizum_id")
VALUES (1, -25.50, 'bizum', 1);

INSERT INTO "transactions" ("account_id", "amount", "type", "bizum_id")
VALUES (
    (SELECT "accounts"."id" FROM "accounts" 
    JOIN "users"  ON "accounts"."user_id" = "users"."id" 
    WHERE "users"."phone_number" = '+34699887766'),
    25.50,
    'bizum',
    1
);

UPDATE "accounts" 
SET "balance" = "balance" - 25.50 
WHERE "id" = 1;

UPDATE "accounts" 
SET "balance" = "balance" + 25.50 
WHERE "id" = (
    SELECT "accounts"."id"
    FROM "accounts" 
    JOIN "users" ON "accounts"."user_id" = "users"."id"
    WHERE "users"."phone_number" = '+34699887766'
);

-- Find direct debits
SELECT 
    "company_name", 
    "amount", 
    "frequency", 
    "next_payment_date"
FROM "direct_debits"
WHERE "account_id" = 1;

-- 1. Register atm transaction
INSERT INTO "transactions" ("account_id", "amount", "type", "atm_id")
VALUES (1, -50.00, 'atm', 3);

UPDATE "accounts" 
SET "balance" = "balance" - 50.00 
WHERE "id" = 1;