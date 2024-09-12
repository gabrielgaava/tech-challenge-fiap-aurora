CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE customer (
    id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    cpf varchar(11) UNIQUE,
    name varchar(256),
    email varchar(256) UNIQUE
);

CREATE TABLE product (
    id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    name varchar UNIQUE,
    description varchar,
    image_url varchar,
    price float,
    category varchar
);

CREATE TABLE "order" (
    id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_number SERIAL UNIQUE,
    customer_id uuid,
    created_at timestamp,
    amount float,
    status varchar,
    paid_at timestamp DEFAULT null,
    FOREIGN KEY (customer_id) REFERENCES customer (id)
);

CREATE TABLE "order_history" (
    order_id uuid,
    previous_status varchar,
    new_status varchar,
    moment timestamp,
    FOREIGN KEY (order_id) REFERENCES "order" (id),
    PRIMARY KEY (order_id, previous_status, new_status)
);

CREATE TABLE "order_products" (
    order_id uuid,
    product_id uuid,
    quantity int,
    FOREIGN KEY (order_id) REFERENCES "order" (id),
    FOREIGN KEY (product_id) REFERENCES product (id),
    PRIMARY KEY (order_id, product_id)
);

CREATE TABLE payment (
    id uuid PRIMARY KEY,
    external_id varchar,
    order_id uuid,
    status varchar,
    gateway varchar,
    amount float,
    transaction_data varchar,
    payed_at timestamp,
    FOREIGN KEY (order_id) REFERENCES "order" (id)
);

INSERT INTO public.customer (id, cpf, name, email)
VALUES (
    '98756d48-ce07-4292-b395-0cbc76f99823',
    '47667846855',
    'Gabriel Henrique da Silva Gava',
    'gabriel.gava@gmail.com'
);

INSERT INTO public.product (id, name, description, image_url, price, category)
VALUES (
    'cde11e9b-c4f8-4451-8f50-c1b05686ec77',
    'X Salada',
    'Pão Brioche, Hambúrguer, Queijo Mussarela, Alface, Tomate e Molhos',
    'https://s2-receitas.glbimg.com/Td050XeFMOBB7XFeJigA5voIlvE=/0x0:1200x675/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_1f540e0b94d8437dbbc39d567a1dee68/internal_photos/bs/2024/7/K/ehv3mfQjmY0VivlyFd8g/x-salada-classico.jpg',
    22.90,
    'SANDWICH'
), (
    '3fa9dec2-97e3-4e24-985e-405bd152647b',
    'Batata Frita',
    'Batata selecionada, sequinha e saborosa',
    'https://gastronomiacarioca.zonasul.com.br/wp-content/uploads/2023/05/batata_frita_destaque_ilustrativo_zona_sul.jpg',
    9.50,
    'SIDE_DISH'
), (
    '597c2c39-de76-4f56-b244-7c268dea4f22',
    'Refrigerante 500ml',
    'Coca Cola, Coca Cola Zero, Guarana, Guarana Zero, Sprite e Fanta',
    'https://doutorjairo.com.br/media/uploads/istock-refrigerante.jpg',
    6.00,
    'DRINK'
), (
    'f36aefe8-c343-44a0-8d09-1d7fa95007ea',
    'Brownie',
    'Brownie com chocolate 70% de 100 gramas. Doce e amargo na medida certa!',
    'https://vitat.com.br/receitas/images/recipeshandler.jpg?id=4882&tipo=r&default=s',
    10.00,
    'DESSERT'
);

