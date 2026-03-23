CREATE TABLE demo.customers (
    customer_id      INTEGER PRIMARY KEY,
    full_name        VARCHAR(100) NOT NULL,
    email            VARCHAR(150),
    phone            VARCHAR(30),
    city             VARCHAR(50),
    created_at       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE demo.accounts (
    account_id       INTEGER PRIMARY KEY,
    customer_id      INTEGER NOT NULL,
    account_type     VARCHAR(30) NOT NULL,
    balance          NUMERIC(18,2) NOT NULL,
    currency_code    CHAR(3) NOT NULL DEFAULT 'KRW',
    status           VARCHAR(20) NOT NULL,
    opened_at        TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_accounts_customer
        FOREIGN KEY (customer_id)
        REFERENCES demo.customers(customer_id)
);

CREATE TABLE demo.transactions (
    transaction_id   BIGINT PRIMARY KEY,
    account_id       INTEGER NOT NULL,
    transaction_type VARCHAR(20) NOT NULL,
    amount           NUMERIC(18,2) NOT NULL,
    merchant_name    VARCHAR(100),
    transaction_ts   TIMESTAMP NOT NULL,
    created_at       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_transactions_account
        FOREIGN KEY (account_id)
        REFERENCES demo.accounts(account_id)
);

CREATE TABLE demo.cards (
    card_id          INTEGER PRIMARY KEY,
    account_id       INTEGER NOT NULL,
    card_type        VARCHAR(20) NOT NULL,
    card_number      VARCHAR(20) NOT NULL,
    card_status      VARCHAR(20) NOT NULL,
    issued_at        TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_cards_account
        FOREIGN KEY (account_id)
        REFERENCES demo.accounts(account_id)
);

CREATE TABLE demo.branches (
    branch_id        INTEGER PRIMARY KEY,
    branch_name      VARCHAR(100) NOT NULL,
    city             VARCHAR(50) NOT NULL,
    opened_at        TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);