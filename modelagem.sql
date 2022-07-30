CREATE DATABASE drivenbank;
----
CREATE TABLE states(
	id SERIAL PRIMARY KEY,
	name VARCHAR(70) NOT NULL
);

CREATE TABLE cities(
	id SERIAL PRIMARY KEY,
	name VARCHAR(70) NOT NULL,
	"stateId" INTEGER REFERENCES states(id) NOT NULL
);

CREATE TYPE "phoneType" AS ENUM ('landline', 'mobile');

CREATE TABLE customers(
	id SERIAL PRIMARY KEY,
	"fullName" VARCHAR(70) NOT NULL,
	cpf VARCHAR(11) NOT NULL UNIQUE,
	email VARCHAR(30) NOT NULL UNIQUE, 
	password TEXT NOT NULL
);

CREATE TABLE "customerPhones"(
	id SERIAL PRIMARY KEY,
	"customerId" INTEGER REFERENCES customers(id) NOT NULL,
	number VARCHAR(12),
	type "phoneType"
);

CREATE TABLE "customerAddresses"(
	id SERIAL PRIMARY KEY,
	"customerId" INTEGER REFERENCES customers(id) UNIQUE NOT NULL,
	street TEXT NOT NULL,
	number VARCHAR(5) NOT NULL,
	complement TEXT, 
	"postalCode" VARCHAR(20) NOT NULL,
	"cityId" INTEGER REFERENCES cities(id) NOT NULL
);

CREATE TABLE "bankAccount"(
	id SERIAL PRIMARY KEY,
	"customerId" INTEGER REFERENCES customers(id) NOT NULL,
	"accountNumber" INTEGER NOT NULL UNIQUE,
	agency TEXT NOT NULL,
	"openDate" DATE NOT NULL DEFAULT NOW(),
	"closeDate" DATE 
);

CREATE TYPE "transactionsType" AS ENUM ('deposit', 'withdraw');

CREATE TABLE transactions(
	id SERIAL PRIMARY KEY, 
	"bankAccountId" INTEGER REFERENCES "bankAccount"(id) NOT NULL,
	amount REAL NOT NULL,
	type "transactionsType" NOT NULL,
	time TIMESTAMP DEFAULT NOW() NOT NULL,
	description TEXT,
	cancelled BOOLEAN DEFAULT false
);

CREATE TABLE "creditCards"(
	id SERIAL PRIMARY KEY, 
	"bankAccountId" INTEGER REFERENCES "bankAccount"(id) NOT NULL,
	name VARCHAR(50) NOT NULL,
	number VARCHAR(25) NOT NULL UNIQUE, 
	"securityCode" VARCHAR(5) NOT NULL, 
	"expirationMonth" INTEGER NOT NULL, 
	"expirationYear" INTEGER NOT NULL, 
	password TEXT NOT NULL, 
	"limit" INTEGER NOT NULL
);
