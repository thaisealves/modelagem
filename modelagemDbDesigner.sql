CREATE TABLE "public.users" (
	"id" serial NOT NULL,
	"name" varchar(70) NOT NULL,
	"email" varchar(70) NOT NULL UNIQUE,
	"password" TEXT NOT NULL,
	CONSTRAINT "users_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.products" (
	"id" serial NOT NULL,
	"name" varchar(100) NOT NULL,
	"price" bigint NOT NULL,
	"photosId" serial NOT NULL UNIQUE,
	"informationId" serial NOT NULL UNIQUE,
	CONSTRAINT "products_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.productPhotos" (
	"id" serial NOT NULL UNIQUE,
	"primaryPhoto" TEXT NOT NULL UNIQUE,
	"otherPhotos" TEXT([]),
	CONSTRAINT "productPhotos_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.clothesInformation" (
	"id" serial NOT NULL,
	"category" varchar(20) NOT NULL UNIQUE,
	"size" varchar(5) NOT NULL,
	CONSTRAINT "clothesInformation_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.purchase" (
	"id" serial NOT NULL,
	"userId" int NOT NULL,
	"productId" int NOT NULL,
	"quantity" int NOT NULL,
	"status" varchar(30) NOT NULL,
	"address" TEXT NOT NULL,
	"date" DATE NOT NULL DEFAULT 'now()',
	CONSTRAINT "purchase_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);




ALTER TABLE "products" ADD CONSTRAINT "products_fk0" FOREIGN KEY ("photosId") REFERENCES "productPhotos"("id");
ALTER TABLE "products" ADD CONSTRAINT "products_fk1" FOREIGN KEY ("informationId") REFERENCES "clothesInformation"("id");



ALTER TABLE "purchase" ADD CONSTRAINT "purchase_fk0" FOREIGN KEY ("userId") REFERENCES "users"("id");
ALTER TABLE "purchase" ADD CONSTRAINT "purchase_fk1" FOREIGN KEY ("productId") REFERENCES "products"("id");





