-- Adminer 4.7.7 PostgreSQL dump

DROP TABLE IF EXISTS "address";
DROP SEQUENCE IF EXISTS address_id_seq;
CREATE SEQUENCE address_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."address" (
    "id" integer DEFAULT nextval('address_id_seq') NOT NULL,
    "city" character varying(100) NOT NULL,
    "street" character varying(100) NOT NULL,
    "postal_code" integer NOT NULL,
    CONSTRAINT "Address_pk" PRIMARY KEY ("id")
) WITH (oids = false);

COMMENT ON TABLE "public"."address" IS 'L''adresse des clients mais aussi l''adresse de facturation et de livraison';

COMMENT ON COLUMN "public"."address"."city" IS 'L''adresse du client, de la commande et/ou de la livraison';

INSERT INTO "address" ("id", "city", "street", "postal_code") VALUES
(1,	'Bernard',	'chemin Isaac Thibault',	32199),
(2,	'Faure',	'559, chemin Laurence Dubois',	56946),
(3,	'Saint Julien',	'rue de Lamy',	11982),
(4,	'Sainte Constance',	'53, rue Marianne Boucher',	55303),
(5,	'Meunier',	'19, rue Begue',	72835),
(6,	'Gimenez',	'42, rue Teixeira',	34675),
(7,	'Saint Pauline-les-Bains',	'820, boulevard Roche',	68125),
(8,	'CoulonVille',	'78, chemin de Humbert',	79635),
(9,	'Blin',	'38, avenue Christine Monnier',	12322),
(10,	'Chevallier',	'87, boulevard de Nicolas',	73374),
(11,	'Besancon',	'132 rue de Belfort',	25000),
(12,	'Paris',	'54 rue Montmartre',	75018);

DROP TABLE IF EXISTS "composition";
CREATE TABLE "public"."composition" (
    "id_ingredient" integer NOT NULL,
    "id_product" integer NOT NULL,
    "quantity_ingredient" smallint,
    CONSTRAINT "pk_composition" PRIMARY KEY ("id_ingredient", "id_product"),
    CONSTRAINT "fk_ingredrient" FOREIGN KEY (id_ingredient) REFERENCES product(id) MATCH FULL NOT DEFERRABLE,
    CONSTRAINT "fk_product" FOREIGN KEY (id_product) REFERENCES product(id) MATCH FULL NOT DEFERRABLE
) WITH (oids = false);

COMMENT ON TABLE "public"."composition" IS 'table de liaison entre les produits d''une même table (self relationship)';

INSERT INTO "composition" ("id_ingredient", "id_product", "quantity_ingredient") VALUES
(3,	13,	1),
(3,	14,	1),
(3,	15,	1),
(3,	17,	1),
(3,	20,	1),
(4,	13,	1),
(4,	16,	1),
(4,	17,	1),
(4,	18,	1),
(4,	19,	1),
(5,	13,	1),
(5,	18,	1),
(5,	14,	1),
(5,	15,	1),
(5,	22,	1),
(6,	13,	1),
(6,	22,	1),
(6,	14,	2),
(6,	20,	1),
(6,	21,	1),
(7,	13,	1),
(7,	14,	1),
(7,	15,	1),
(7,	16,	1),
(7,	17,	1),
(8,	13,	1),
(8,	20,	1),
(8,	14,	1),
(8,	16,	1),
(8,	21,	1),
(9,	13,	1),
(9,	16,	1),
(9,	14,	1),
(9,	18,	1),
(9,	17,	1),
(10,	13,	1),
(10,	16,	1),
(10,	14,	1),
(10,	18,	1),
(10,	20,	1),
(11,	13,	2),
(11,	16,	1),
(11,	19,	1),
(11,	20,	1),
(11,	21,	1),
(12,	13,	1),
(12,	16,	1),
(12,	17,	2),
(12,	18,	1),
(12,	22,	1);

DROP TABLE IF EXISTS "delivery_mode";
DROP SEQUENCE IF EXISTS delivery_mode_id_seq;
CREATE SEQUENCE delivery_mode_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."delivery_mode" (
    "id" integer DEFAULT nextval('delivery_mode_id_seq') NOT NULL,
    "delivery_name" character varying(100),
    CONSTRAINT "delivery_mode_pk" PRIMARY KEY ("id")
) WITH (oids = false);

INSERT INTO "delivery_mode" ("id", "delivery_name") VALUES
(1,	'Livraison'),
(2,	'A emporter'),
(3,	'Sur place');

DROP TABLE IF EXISTS "menu";
CREATE TABLE "public"."menu" (
    "id_pizzeria" smallint NOT NULL,
    "id_product" smallint NOT NULL,
    "menu_price" numeric(10,0),
    CONSTRAINT "pk_menu" PRIMARY KEY ("id_product", "id_pizzeria"),
    CONSTRAINT "fk_pizzeria" FOREIGN KEY (id_pizzeria) REFERENCES pizzeria(id) MATCH FULL NOT DEFERRABLE,
    CONSTRAINT "fk_product" FOREIGN KEY (id_product) REFERENCES product(id) MATCH FULL NOT DEFERRABLE
) WITH (oids = false);

COMMENT ON TABLE "public"."menu" IS 'table de liaison entre un produit complet (exemple : margherita) et une pizzéria';

INSERT INTO "menu" ("id_pizzeria", "id_product", "menu_price") VALUES
(2,	3,	11),
(2,	5,	14),
(2,	6,	15),
(2,	7,	13),
(2,	8,	11),
(2,	9,	15),
(2,	10,	12),
(2,	11,	12),
(2,	12,	12),
(2,	13,	12),
(1,	3,	11),
(1,	4,	13),
(1,	5,	14),
(1,	6,	15),
(1,	7,	13),
(1,	8,	11),
(1,	9,	15),
(1,	11,	12),
(1,	12,	12),
(1,	13,	12);

DROP TABLE IF EXISTS "order";
DROP SEQUENCE IF EXISTS order_order_num_seq;
CREATE SEQUENCE order_order_num_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."order" (
    "order_num" integer DEFAULT nextval('order_order_num_seq') NOT NULL,
    "id_delivery_address" integer NOT NULL,
    "id_pizzeria" integer NOT NULL,
    "id_user" integer NOT NULL,
    "id_payment_choice" integer NOT NULL,
    "id_delivery_mode" integer NOT NULL,
    "payment_time" timestamp,
    "creation_time" timestamp DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "order_pk" PRIMARY KEY ("order_num"),
    CONSTRAINT "address_fk" FOREIGN KEY (id_delivery_address) REFERENCES address(id) MATCH FULL ON UPDATE CASCADE ON DELETE SET NULL NOT DEFERRABLE,
    CONSTRAINT "delivery_mode_fk" FOREIGN KEY (id_delivery_mode) REFERENCES delivery_mode(id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT NOT DEFERRABLE,
    CONSTRAINT "payment_choice_fk" FOREIGN KEY (id_payment_choice) REFERENCES payment_choice(id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT NOT DEFERRABLE,
    CONSTRAINT "pizzeria_fk" FOREIGN KEY (id_pizzeria) REFERENCES pizzeria(id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT NOT DEFERRABLE,
    CONSTRAINT "user_fk" FOREIGN KEY (id_user) REFERENCES "user"(id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT NOT DEFERRABLE
) WITH (oids = false);

INSERT INTO "order" ("order_num", "id_delivery_address", "id_pizzeria", "id_user", "id_payment_choice", "id_delivery_mode", "payment_time", "creation_time") VALUES
(4,	9,	2,	9,	1,	1,	'2020-11-13 19:22:10.568816',	'2020-11-13 19:22:10.568816'),
(5,	8,	2,	8,	2,	2,	NULL,	'2020-11-13 19:28:01.145342');

DROP TABLE IF EXISTS "order_line";
CREATE TABLE "public"."order_line" (
    "id_order" smallint NOT NULL,
    "id_product" smallint NOT NULL,
    "product_price" numeric,
    "product_quantity" smallint,
    CONSTRAINT "pk_order_line" PRIMARY KEY ("id_product", "id_order"),
    CONSTRAINT "fk_order" FOREIGN KEY (id_order) REFERENCES "order"(order_num) MATCH FULL NOT DEFERRABLE,
    CONSTRAINT "fk_product" FOREIGN KEY (id_product) REFERENCES product(id) MATCH FULL NOT DEFERRABLE
) WITH (oids = false);

INSERT INTO "order_line" ("id_order", "id_product", "product_price", "product_quantity") VALUES
(4,	3,	11,	1),
(4,	5,	14,	1),
(5,	9,	15,	5);

DROP TABLE IF EXISTS "payment_choice";
DROP SEQUENCE IF EXISTS payment_choice_id_seq;
CREATE SEQUENCE payment_choice_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."payment_choice" (
    "id" integer DEFAULT nextval('payment_choice_id_seq') NOT NULL,
    "paiment_name" character varying(30) NOT NULL,
    CONSTRAINT "payment_choice_pk" PRIMARY KEY ("id")
) WITH (oids = false);

COMMENT ON COLUMN "public"."payment_choice"."paiment_name" IS 'nom du mode de paiement (exemple : cb)';

INSERT INTO "payment_choice" ("id", "paiment_name") VALUES
(1,	'CB'),
(2,	'Espèces'),
(3,	'Paypal');

DROP TABLE IF EXISTS "pizzeria";
DROP SEQUENCE IF EXISTS pizzeria_id_seq;
CREATE SEQUENCE pizzeria_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."pizzeria" (
    "id" integer DEFAULT nextval('pizzeria_id_seq') NOT NULL,
    "employees_number" smallint,
    "id_address" integer NOT NULL,
    CONSTRAINT "pizzeria_pk" PRIMARY KEY ("id"),
    CONSTRAINT "pizzeria_uq" UNIQUE ("id_address"),
    CONSTRAINT "address_fk" FOREIGN KEY (id_address) REFERENCES address(id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT NOT DEFERRABLE
) WITH (oids = false);

COMMENT ON COLUMN "public"."pizzeria"."employees_number" IS 'nombre d''employés au sein de la pizzéria';

INSERT INTO "pizzeria" ("id", "employees_number", "id_address") VALUES
(1,	5,	11),
(2,	10,	12);

DROP TABLE IF EXISTS "product";
DROP SEQUENCE IF EXISTS product_id_seq;
CREATE SEQUENCE product_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."product" (
    "id" integer DEFAULT nextval('product_id_seq') NOT NULL,
    "product_name" character varying(255) NOT NULL,
    "unit" character varying(255),
    "description" text,
    "picture" character varying(150),
    CONSTRAINT "product_pk" PRIMARY KEY ("id"),
    CONSTRAINT "unique_product_name" UNIQUE ("product_name")
) WITH (oids = false);

COMMENT ON COLUMN "public"."product"."product_name" IS 'nom du produit';

COMMENT ON COLUMN "public"."product"."unit" IS '(exemple : cl ou gr)';

INSERT INTO "product" ("id", "product_name", "unit", "description", "picture") VALUES
(3,	'pizza_Chauvin-la-Foret',	NULL,	'Aide ne branche immobile minute rue. Science risquer mauvais sol repandre place naissance faveur. Vers leger combien espoir visite desormais.',	'http://auger.fr/'),
(4,	'pizza_Munoz-sur-Evrard',	NULL,	'Mois leur fete fort fumer bande perdre salle. Chacun cou retourner rouler. Unique ce liberte chiffre condamner accord souffrir.',	'https://chartier.com/'),
(5,	'pizza_Michaud',	NULL,	'Presenter experience couper trainer exposer poche autant. Simple service attirer pourquoi.',	'http://moreau.fr/'),
(6,	'pizza_Sainte Matthieu-sur-Mer',	NULL,	'Te point dominer creer. Moitie pensee franc barbe. Un adresser plante aucun tot reposer.',	'https://bonnet.fr/'),
(7,	'pizza_BaillyBourg',	NULL,	'Trouver quitter croix rappeler. Annee militaire direction tu tel.',	'https://www.guibert.com/'),
(8,	'pizza_Launay',	NULL,	'Depart vers vol. Compter souffrir odeur. Premier pretendre probleme scene.',	'http://www.berthelot.net/'),
(9,	'pizza_Payet',	NULL,	'Marche accent faim declarer dehors metier reveler. Continuer tresor couleur siecle tantot. Sur soldat deviner. Politique troisieme toute craindre crainte superieur dont.',	'https://ferreira.org/'),
(10,	'pizza_Sainte HortenseBourg',	NULL,	'Aventure seuil nu etre retenir. Du religion raison car portier troubler. Rose hiver amuser nul. Porter appartement simple compter interet vie blanc.',	'http://mallet.net/'),
(11,	'pizza_HamonBourg',	NULL,	'Penetrer projet arriver bureau marche femme. Reussir honte billet reconnaitre reveler maintenant demander.',	'http://www.martel.fr/'),
(12,	'pizza_Le Roux-sur-Monnier',	NULL,	'Verre feuille environ etudier. Difficile rideau rencontre titre distance renverser.',	'http://masse.com/'),
(13,	'ton',	NULL,	'Public vaincre abandonner quelque tuer. Parce Que reveler son causer placer fonder. Succes empecher fer mille. Village habitude craindre repousser clair.',	'http://gerard.com'),
(14,	'reveiller',	NULL,	'Lieu chasser beaux soir. Tomber different docteur complet. Conscience sortir bas crise vague scene musique. Apporter grand tout agir.',	'https://www.dumont.fr/'),
(15,	'danser',	NULL,	'Sourire user commencement fin travail bruler. eternel doux table bete. Ressembler long pain caractere. Conversation portier passe energie rejoindre blanc mur.',	'https://www.bigot.fr/'),
(16,	'attirer',	NULL,	'Rien tromper extraordinaire rien accent certain. Pierre retour commencer complet habiller.',	'http://www.baron.com/'),
(17,	'devoir',	NULL,	'eclairer sur decider ouvert ordre. Lutte pensee fonder y repousser. Effet par oui arme assurer.',	'https://labbe.org/'),
(18,	'rire',	NULL,	'Jeu pareil rouge sujet courant. Signifier consulter genou fermer certainement. Nuit couche amener mer. Douter sorte le present joindre.',	'https://rodriguez.fr/'),
(19,	'pendre',	NULL,	'Reveiller detail debut sien beau quant a. Enfin debout perte certain herbe couper. Sans impression y voiture gauche jusque. Bras quant a dimanche existence prison liberte detacher.',	'https://www.blondel.fr/'),
(20,	'puissance',	NULL,	'Empire dix rassurer mensonge corps action anglais militaire. Froid patron du mince frapper absolument instinct. Tot gagner desir doigt.',	'http://www.bernier.com/'),
(21,	'moment',	NULL,	'eclater rompre vue aucun aller lettre. Genou calme disposer continuer. Changer franc rejeter armer ah masse. Pas reve voyage. Humain dont note couvrir choisir.',	'https://godard.com/'),
(22,	'cinquante',	NULL,	'Frais accent banc. Entendre voisin trois reveler sac. Admettre sorte comme lorsque masse voir.',	'https://www.maury.com/');

DROP TABLE IF EXISTS "status";
DROP SEQUENCE IF EXISTS status_id_seq;
CREATE SEQUENCE status_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."status" (
    "id" integer DEFAULT nextval('status_id_seq') NOT NULL,
    "status_name" character varying(255) NOT NULL,
    CONSTRAINT "status_pk" PRIMARY KEY ("id")
) WITH (oids = false);

COMMENT ON COLUMN "public"."status"."status_name" IS 'état d''une commande, d''un paiement, etc.';

INSERT INTO "status" ("id", "status_name") VALUES
(1,	'en cours de livraison'),
(2,	'récupérée'),
(3,	'en attente de préparation'),
(4,	'en attente de livraison'),
(5,	'livrée');

DROP TABLE IF EXISTS "status_order";
CREATE TABLE "public"."status_order" (
    "id_order" smallint NOT NULL,
    "id_status" smallint NOT NULL,
    "time" timestamp,
    "is_active" boolean,
    "id_user" integer,
    CONSTRAINT "pk_status_order" PRIMARY KEY ("id_order", "id_status"),
    CONSTRAINT "fk_order" FOREIGN KEY (id_order) REFERENCES "order"(order_num) MATCH FULL NOT DEFERRABLE,
    CONSTRAINT "fk_status" FOREIGN KEY (id_status) REFERENCES status(id) MATCH FULL NOT DEFERRABLE,
    CONSTRAINT "user_fk" FOREIGN KEY (id_user) REFERENCES "user"(id) MATCH FULL ON UPDATE CASCADE ON DELETE SET NULL NOT DEFERRABLE
) WITH (oids = false);

INSERT INTO "status_order" ("id_order", "id_status", "time", "is_active", "id_user") VALUES
(4,	1,	'2020-11-13 19:22:10.568816',	'0',	9),
(4,	3,	'2020-11-13 19:32:10.568816',	'0',	9),
(4,	4,	'2020-11-13 19:42:10.568816',	'0',	9),
(4,	5,	'2020-11-13 19:52:10.568816',	'1',	9),
(5,	1,	'2020-11-13 19:22:10.568816',	'1',	8);

DROP TABLE IF EXISTS "stock";
CREATE TABLE "public"."stock" (
    "id_product" smallint NOT NULL,
    "id_pizzeria" smallint NOT NULL,
    "last_replineshment" date,
    "next_replenishment" date,
    "quantity" integer,
    CONSTRAINT "stock_pk" PRIMARY KEY ("id_pizzeria", "id_product"),
    CONSTRAINT "fk_product" FOREIGN KEY (id_product) REFERENCES product(id) MATCH FULL NOT DEFERRABLE,
    CONSTRAINT "pizz_fk" FOREIGN KEY (id_pizzeria) REFERENCES pizzeria(id) MATCH FULL NOT DEFERRABLE
) WITH (oids = false);

COMMENT ON TABLE "public"."stock" IS 'Table de liaison entre product et pizzéria';

INSERT INTO "stock" ("id_product", "id_pizzeria", "last_replineshment", "next_replenishment", "quantity") VALUES
(13,	2,	'2020-12-16',	'2020-12-23',	200),
(14,	2,	'2020-12-16',	'2020-12-23',	1000),
(15,	2,	'2020-12-16',	'2020-12-23',	500),
(16,	2,	'2020-12-16',	'2020-12-23',	150),
(17,	2,	'2020-12-16',	'2020-12-23',	300),
(18,	2,	'2020-12-16',	'2020-12-23',	500),
(19,	2,	'2020-12-16',	'2020-12-23',	300),
(20,	2,	'2020-12-16',	'2020-12-23',	300),
(21,	2,	'2020-12-16',	'2020-12-23',	300),
(22,	2,	'2020-12-16',	'2020-12-23',	300),
(13,	1,	'2020-12-13',	'2020-12-20',	200),
(14,	1,	'2020-12-13',	'2020-12-20',	1000),
(15,	1,	'2020-12-13',	'2020-12-20',	500),
(16,	1,	'2020-12-13',	'2020-12-20',	150),
(17,	1,	'2020-12-13',	'2020-12-20',	300),
(18,	1,	'2020-12-13',	'2020-12-20',	500),
(19,	1,	'2020-12-13',	'2020-12-20',	300),
(20,	1,	'2020-12-13',	'2020-12-20',	300),
(21,	1,	'2020-12-13',	'2020-12-20',	300),
(22,	1,	'2020-12-13',	'2020-12-20',	300);

DROP TABLE IF EXISTS "user";
DROP SEQUENCE IF EXISTS user_id_seq;
CREATE SEQUENCE user_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."user" (
    "id" integer DEFAULT nextval('user_id_seq') NOT NULL,
    "first_name" character varying(100) NOT NULL,
    "last_name" character varying(50) NOT NULL,
    "phone_number" integer NOT NULL,
    "email" character varying(255) NOT NULL,
    "password" character varying(255),
    "id_address" integer NOT NULL,
    "id_user_groups" integer NOT NULL,
    CONSTRAINT "user_pk" PRIMARY KEY ("id"),
    CONSTRAINT "address_fk" FOREIGN KEY (id_address) REFERENCES address(id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT NOT DEFERRABLE,
    CONSTRAINT "user_groups_fk" FOREIGN KEY (id_user_groups) REFERENCES user_groups(id) MATCH FULL ON UPDATE CASCADE ON DELETE RESTRICT NOT DEFERRABLE
) WITH (oids = false);

COMMENT ON TABLE "public"."user" IS 'table des employés et des clients';

COMMENT ON COLUMN "public"."user"."first_name" IS 'le nom des utilisateurs';

COMMENT ON COLUMN "public"."user"."phone_number" IS 'numéro de téléphone des clients';

COMMENT ON COLUMN "public"."user"."email" IS 'mail des clients';

INSERT INTO "user" ("id", "first_name", "last_name", "phone_number", "email", "password", "id_address", "id_user_groups") VALUES
(1,	'Kath',	'Farmiloe',	-9733,	'kfarmiloe0@jimdo.com',	'8bjyLHydt',	1,	3),
(2,	'Nance',	'Kilborn',	-4802,	'nkilborn1@skyrock.com',	'54f9jnwdDse',	2,	4),
(3,	'Rhiamon',	'Esberger',	-4652,	'resberger2@reuters.com',	'4lHzQS',	3,	1),
(4,	'Justus',	'Rennicks',	-85,	'jrennicks3@sfgate.com',	'Qei6BB8HHNIC',	4,	2),
(5,	'Reinaldos',	'Roaf',	-4518,	'rroaf4@independent.co.uk',	'MOORB6ljQbJx',	5,	2),
(6,	'Shirlene',	'Croome',	-8478,	'scroome5@nba.com',	'VAgiTc',	6,	2),
(7,	'Gasper',	'MacPeake',	-9046,	'gmacpeake6@joomla.org',	'cpd7hjVxRBLm',	7,	2),
(8,	'Abramo',	'Jerrems',	-4119,	'ajerrems7@cisco.com',	'a2uSh72L',	8,	2),
(9,	'Rorke',	'Taylorson',	-7688,	'rtaylorson8@ask.com',	'Tt6NscV',	9,	2),
(10,	'Gideon',	'Fullylove',	-577,	'gfullylove9@com.com',	'uMbyJFN',	10,	2);

DROP TABLE IF EXISTS "user_groups";
DROP SEQUENCE IF EXISTS user_groups_id_seq;
CREATE SEQUENCE user_groups_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1;

CREATE TABLE "public"."user_groups" (
    "id" integer DEFAULT nextval('user_groups_id_seq') NOT NULL,
    "user_groups_name" character varying(255) NOT NULL,
    CONSTRAINT "user_groups_pk" PRIMARY KEY ("id")
) WITH (oids = false);

COMMENT ON TABLE "public"."user_groups" IS 'Liste de groupes utilisateur (exemple : client, employé, admin, etc.)';

COMMENT ON COLUMN "public"."user_groups"."user_groups_name" IS 'Element de la liste des groupes utilisateurs existant';

INSERT INTO "user_groups" ("id", "user_groups_name") VALUES
(1,	'pizzaïolo'),
(2,	'client'),
(3,	'manager'),
(4,	'livreur');

-- 2020-11-13 19:57:36.261977+00