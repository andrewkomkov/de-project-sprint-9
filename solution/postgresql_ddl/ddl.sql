-- DROP SCHEMA cdm;

CREATE SCHEMA cdm;

-- Drop table

-- DROP TABLE cdm.user_category_counters;

CREATE TABLE cdm.user_category_counters (
	id serial4 NOT NULL, -- Идентификатор записи
	user_id uuid NOT NULL, -- Идентификатор пользователя в формате UUID
	category_id uuid NOT NULL, -- Идентификатор категории в формате UUID
	category_name varchar(255) NOT NULL, -- Название категории
	order_cnt int4 NOT NULL, -- Счётчик заказов, не может быть отрицательным
	CONSTRAINT user_category_counters_order_cnt_check CHECK ((order_cnt >= 0)),
	CONSTRAINT user_category_counters_pkey PRIMARY KEY (id),
	CONSTRAINT user_category_unique UNIQUE (user_id, category_id)
);
COMMENT ON TABLE cdm.user_category_counters IS 'Таблица, содержащая информацию о заказах пользователей по категориям.';

-- Column comments

COMMENT ON COLUMN cdm.user_category_counters.id IS 'Идентификатор записи';
COMMENT ON COLUMN cdm.user_category_counters.user_id IS 'Идентификатор пользователя в формате UUID';
COMMENT ON COLUMN cdm.user_category_counters.category_id IS 'Идентификатор категории в формате UUID';
COMMENT ON COLUMN cdm.user_category_counters.category_name IS 'Название категории';
COMMENT ON COLUMN cdm.user_category_counters.order_cnt IS 'Счётчик заказов, не может быть отрицательным';

-- Constraint comments

COMMENT ON CONSTRAINT user_category_unique ON cdm.user_category_counters IS 'Уникальный индекс для комбинации user_id и category_id';


-- cdm.user_product_counters definition

-- Drop table

-- DROP TABLE cdm.user_product_counters;

CREATE TABLE cdm.user_product_counters (
	id serial4 NOT NULL, -- Идентификатор записи
	user_id uuid NOT NULL, -- Идентификатор пользователя в формате UUID
	product_id uuid NOT NULL, -- Идентификатор продукта в формате UUID
	product_name varchar(255) NOT NULL, -- Наименование продукта
	order_cnt int4 NOT NULL, -- Счётчик заказов, не может быть отрицательным
	CONSTRAINT user_product_counters_order_cnt_check CHECK ((order_cnt >= 0)),
	CONSTRAINT user_product_counters_pkey PRIMARY KEY (id),
	CONSTRAINT user_product_unique UNIQUE (user_id, product_id)
);
COMMENT ON TABLE cdm.user_product_counters IS 'Cчётчик заказов по продуктам';

-- Column comments

COMMENT ON COLUMN cdm.user_product_counters.id IS 'Идентификатор записи';
COMMENT ON COLUMN cdm.user_product_counters.user_id IS 'Идентификатор пользователя в формате UUID';
COMMENT ON COLUMN cdm.user_product_counters.product_id IS 'Идентификатор продукта в формате UUID';
COMMENT ON COLUMN cdm.user_product_counters.product_name IS 'Наименование продукта';
COMMENT ON COLUMN cdm.user_product_counters.order_cnt IS 'Счётчик заказов, не может быть отрицательным';

-- Constraint comments

COMMENT ON CONSTRAINT user_product_unique ON cdm.user_product_counters IS 'Уникальный индекс для комбинации user_id и product_id';

-- DROP SCHEMA dds;

CREATE SCHEMA dds;
-- dds.h_category definition

-- Drop table

-- DROP TABLE dds.h_category;

CREATE TABLE dds.h_category (
	h_category_pk uuid NOT NULL, -- Уникальный идентификатор категории
	category_name varchar NOT NULL, -- Название категории
	load_dt timestamp NOT NULL DEFAULT now(), -- Дата и время загрузки объекта в таблицу
	load_src varchar(100) NOT NULL, -- Наименование системы-источника, откуда был загружен объект
	CONSTRAINT h_category_pkey PRIMARY KEY (h_category_pk)
);
COMMENT ON TABLE dds.h_category IS 'Хаб-таблица для категорий';

-- Column comments

COMMENT ON COLUMN dds.h_category.h_category_pk IS 'Уникальный идентификатор категории';
COMMENT ON COLUMN dds.h_category.category_name IS 'Название категории';
COMMENT ON COLUMN dds.h_category.load_dt IS 'Дата и время загрузки объекта в таблицу';
COMMENT ON COLUMN dds.h_category.load_src IS 'Наименование системы-источника, откуда был загружен объект';


-- dds.h_order definition

-- Drop table

-- DROP TABLE dds.h_order;

CREATE TABLE dds.h_order (
	h_order_pk uuid NOT NULL, -- Уникальный идентификатор заказа (PK)
	order_id int4 NOT NULL, -- Идентификатор заказа
	order_dt timestamp NOT NULL, -- Дата и время совершения заказа
	load_dt timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Дата и время загрузки записи в таблицу
	load_src varchar NOT NULL, -- Наименование системы-источника, откуда был загружен заказ
	CONSTRAINT h_order_pkey PRIMARY KEY (h_order_pk)
);

-- Column comments

COMMENT ON COLUMN dds.h_order.h_order_pk IS 'Уникальный идентификатор заказа (PK)';
COMMENT ON COLUMN dds.h_order.order_id IS 'Идентификатор заказа';
COMMENT ON COLUMN dds.h_order.order_dt IS 'Дата и время совершения заказа';
COMMENT ON COLUMN dds.h_order.load_dt IS 'Дата и время загрузки записи в таблицу';
COMMENT ON COLUMN dds.h_order.load_src IS 'Наименование системы-источника, откуда был загружен заказ';


-- dds.h_product definition

-- Drop table

-- DROP TABLE dds.h_product;

CREATE TABLE dds.h_product (
	h_product_pk uuid NOT NULL, -- Уникальный идентификатор продукта
	product_id varchar NOT NULL, -- Идентификатор продукта
	load_dt timestamp NOT NULL DEFAULT now(), -- Дата и время загрузки объекта в таблицу
	load_src varchar(100) NOT NULL, -- Наименование системы-источника, откуда был загружен объект
	CONSTRAINT h_product_pkey PRIMARY KEY (h_product_pk)
);
COMMENT ON TABLE dds.h_product IS 'Хаб-таблица для продуктов';

-- Column comments

COMMENT ON COLUMN dds.h_product.h_product_pk IS 'Уникальный идентификатор продукта';
COMMENT ON COLUMN dds.h_product.product_id IS 'Идентификатор продукта';
COMMENT ON COLUMN dds.h_product.load_dt IS 'Дата и время загрузки объекта в таблицу';
COMMENT ON COLUMN dds.h_product.load_src IS 'Наименование системы-источника, откуда был загружен объект';


-- dds.h_restaurant definition

-- Drop table

-- DROP TABLE dds.h_restaurant;

CREATE TABLE dds.h_restaurant (
	h_restaurant_pk uuid NOT NULL, -- Уникальный идентификатор записи в таблице h_restaurant
	restaurant_id varchar NOT NULL, -- Уникальный идентификатор ресторана
	load_dt timestamp NOT NULL DEFAULT now(), -- Дата и время загрузки объекта в таблицу
	load_src varchar NOT NULL, -- Наименование системы-источника, откуда был загружен объект
	CONSTRAINT h_restaurant_pkey PRIMARY KEY (h_restaurant_pk)
);
COMMENT ON TABLE dds.h_restaurant IS 'Хаб-таблица для ресторанов';

-- Column comments

COMMENT ON COLUMN dds.h_restaurant.h_restaurant_pk IS 'Уникальный идентификатор записи в таблице h_restaurant';
COMMENT ON COLUMN dds.h_restaurant.restaurant_id IS 'Уникальный идентификатор ресторана';
COMMENT ON COLUMN dds.h_restaurant.load_dt IS 'Дата и время загрузки объекта в таблицу';
COMMENT ON COLUMN dds.h_restaurant.load_src IS 'Наименование системы-источника, откуда был загружен объект';


-- dds.h_user definition

-- Drop table

-- DROP TABLE dds.h_user;

CREATE TABLE dds.h_user (
	h_user_pk uuid NOT NULL, -- Уникальный идентификатор пользователя
	user_id varchar NOT NULL, -- Идентификатор пользователя
	load_dt timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Дата и время загрузки объекта в таблицу
	load_src varchar NOT NULL DEFAULT 'orders-system-kafka'::character varying, -- Наименование системы-источника, откуда был загружен объект
	CONSTRAINT h_user_pkey PRIMARY KEY (h_user_pk)
);
COMMENT ON TABLE dds.h_user IS 'Хаб для сущности пользователь';

-- Column comments

COMMENT ON COLUMN dds.h_user.h_user_pk IS 'Уникальный идентификатор пользователя';
COMMENT ON COLUMN dds.h_user.user_id IS 'Идентификатор пользователя';
COMMENT ON COLUMN dds.h_user.load_dt IS 'Дата и время загрузки объекта в таблицу';
COMMENT ON COLUMN dds.h_user.load_src IS 'Наименование системы-источника, откуда был загружен объект';


-- dds.l_order_product definition

-- Drop table

-- DROP TABLE dds.l_order_product;

CREATE TABLE dds.l_order_product (
	hk_order_product_pk uuid NOT NULL,
	h_order_pk uuid NOT NULL,
	h_product_pk uuid NOT NULL,
	load_dt timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	load_src varchar NOT NULL,
	CONSTRAINT l_order_product_pkey PRIMARY KEY (hk_order_product_pk),
	CONSTRAINT l_order_product_h_order_pk_fkey FOREIGN KEY (h_order_pk) REFERENCES dds.h_order(h_order_pk),
	CONSTRAINT l_order_product_h_product_pk_fkey FOREIGN KEY (h_product_pk) REFERENCES dds.h_product(h_product_pk)
);


-- dds.l_order_user definition

-- Drop table

-- DROP TABLE dds.l_order_user;

CREATE TABLE dds.l_order_user (
	hk_order_user_pk uuid NOT NULL,
	h_order_pk uuid NOT NULL,
	h_user_pk uuid NOT NULL,
	load_dt timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	load_src varchar NOT NULL,
	CONSTRAINT l_order_user_pkey PRIMARY KEY (hk_order_user_pk),
	CONSTRAINT l_order_user_h_order_pk_fkey FOREIGN KEY (h_order_pk) REFERENCES dds.h_order(h_order_pk),
	CONSTRAINT l_order_user_h_user_pk_fkey FOREIGN KEY (h_user_pk) REFERENCES dds.h_user(h_user_pk)
);


-- dds.l_product_category definition

-- Drop table

-- DROP TABLE dds.l_product_category;

CREATE TABLE dds.l_product_category (
	hk_product_category_pk uuid NOT NULL,
	h_category_pk uuid NOT NULL,
	h_product_pk uuid NOT NULL,
	load_dt timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	load_src varchar NOT NULL,
	CONSTRAINT l_product_category_pkey PRIMARY KEY (hk_product_category_pk),
	CONSTRAINT l_product_category_h_category_pk_fkey FOREIGN KEY (h_category_pk) REFERENCES dds.h_category(h_category_pk),
	CONSTRAINT l_product_category_h_product_pk_fkey FOREIGN KEY (h_product_pk) REFERENCES dds.h_product(h_product_pk)
);


-- dds.l_product_restaurant definition

-- Drop table

-- DROP TABLE dds.l_product_restaurant;

CREATE TABLE dds.l_product_restaurant (
	hk_product_restaurant_pk uuid NOT NULL,
	h_restaurant_pk uuid NOT NULL,
	h_product_pk uuid NOT NULL,
	load_dt timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	load_src varchar NOT NULL,
	CONSTRAINT l_product_restaurant_pkey PRIMARY KEY (hk_product_restaurant_pk),
	CONSTRAINT l_product_restaurant_h_product_pk_fkey FOREIGN KEY (h_product_pk) REFERENCES dds.h_product(h_product_pk),
	CONSTRAINT l_product_restaurant_h_restaurant_pk_fkey FOREIGN KEY (h_restaurant_pk) REFERENCES dds.h_restaurant(h_restaurant_pk)
);


-- dds.s_order_cost definition

-- Drop table

-- DROP TABLE dds.s_order_cost;

CREATE TABLE dds.s_order_cost (
	hk_order_cost_pk uuid NOT NULL,
	"cost" numeric(19, 5) NOT NULL,
	payment numeric(19, 5) NOT NULL,
	h_order_pk uuid NOT NULL,
	load_dt timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	load_src varchar NOT NULL,
	CONSTRAINT s_order_cost_cost_check CHECK ((cost >= (0)::numeric)),
	CONSTRAINT s_order_cost_payment_check CHECK ((payment >= (0)::numeric)),
	CONSTRAINT s_order_cost_pkey PRIMARY KEY (hk_order_cost_pk),
	CONSTRAINT s_order_cost_un UNIQUE (h_order_pk),
	CONSTRAINT s_order_cost_h_order_pk_fkey FOREIGN KEY (h_order_pk) REFERENCES dds.h_order(h_order_pk)
);


-- dds.s_order_status definition

-- Drop table

-- DROP TABLE dds.s_order_status;

CREATE TABLE dds.s_order_status (
	hk_order_status_pk uuid NOT NULL,
	status varchar NOT NULL,
	h_order_pk uuid NOT NULL,
	load_dt timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	load_src varchar NOT NULL,
	CONSTRAINT s_order_status_pkey PRIMARY KEY (hk_order_status_pk),
	CONSTRAINT s_order_status_un UNIQUE (h_order_pk),
	CONSTRAINT s_order_status_h_order_pk_fkey FOREIGN KEY (h_order_pk) REFERENCES dds.h_order(h_order_pk)
);


-- dds.s_product_names definition

-- Drop table

-- DROP TABLE dds.s_product_names;

CREATE TABLE dds.s_product_names (
	hk_product_names_pk uuid NOT NULL,
	"name" varchar NOT NULL,
	h_product_pk uuid NOT NULL,
	load_dt timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	load_src varchar NOT NULL,
	CONSTRAINT s_product_names_pkey PRIMARY KEY (hk_product_names_pk),
	CONSTRAINT s_product_names_un UNIQUE (h_product_pk),
	CONSTRAINT s_product_names_h_product_pk_fkey FOREIGN KEY (h_product_pk) REFERENCES dds.h_product(h_product_pk)
);


-- dds.s_restaurant_names definition

-- Drop table

-- DROP TABLE dds.s_restaurant_names;

CREATE TABLE dds.s_restaurant_names (
	hk_restaurant_names_pk uuid NOT NULL,
	"name" varchar NOT NULL,
	h_restaurant_pk uuid NOT NULL,
	load_dt timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	load_src varchar NOT NULL,
	CONSTRAINT s_restaurant_names_pkey PRIMARY KEY (hk_restaurant_names_pk),
	CONSTRAINT s_restaurant_names_un UNIQUE (h_restaurant_pk),
	CONSTRAINT s_restaurant_names_h_restaurant_pk_fkey FOREIGN KEY (h_restaurant_pk) REFERENCES dds.h_restaurant(h_restaurant_pk)
);


-- dds.s_user_names definition

-- Drop table

-- DROP TABLE dds.s_user_names;

CREATE TABLE dds.s_user_names (
	hk_user_names_pk uuid NOT NULL,
	username varchar NOT NULL,
	userlogin varchar NOT NULL,
	h_user_pk uuid NOT NULL,
	load_dt timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	load_src varchar NOT NULL,
	CONSTRAINT s_user_names_pkey PRIMARY KEY (hk_user_names_pk),
	CONSTRAINT s_user_names_un UNIQUE (h_user_pk),
	CONSTRAINT s_user_names_h_user_pk_fkey FOREIGN KEY (h_user_pk) REFERENCES dds.h_user(h_user_pk)
);

-- DROP SCHEMA stg;

CREATE SCHEMA stg;

-- Drop table

-- DROP TABLE stg.order_events;

CREATE TABLE stg.order_events (
	id serial4 NOT NULL, -- Идентификатор записи
	object_id int4 NOT NULL, -- Идентификатор объекта в событии
	payload json NOT NULL, -- Событие в формате JSON
	object_type varchar(255) NOT NULL, -- Тип объекта
	sent_dttm timestamp NOT NULL, -- Дата и время отправки сообщения
	CONSTRAINT order_events_object_id_key UNIQUE (object_id),
	CONSTRAINT order_events_pkey PRIMARY KEY (id)
);

-- Column comments

COMMENT ON COLUMN stg.order_events.id IS 'Идентификатор записи';
COMMENT ON COLUMN stg.order_events.object_id IS 'Идентификатор объекта в событии';
COMMENT ON COLUMN stg.order_events.payload IS 'Событие в формате JSON';
COMMENT ON COLUMN stg.order_events.object_type IS 'Тип объекта';
COMMENT ON COLUMN stg.order_events.sent_dttm IS 'Дата и время отправки сообщения';