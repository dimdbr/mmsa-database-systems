CREATE TABLE IF NOT EXISTS `person` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `first_name` VARCHAR(255) NOT NULL,
    `last_name` VARCHAR(255) NOT NULL,
    `created_at` DATETIME DEFAULT NOW(),
    `updated_at` DATETIME DEFAULT NOW()
)  ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS `item` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `price` DECIMAL(5,2) DEFAULT 0,
    `created_at` DATETIME DEFAULT NOW(),
    `updated_at` DATETIME DEFAULT NOW()
)  ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS `order` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `person_id` INT NOT NULL REFERENCES `person`(`id`),
    `created_at` DATETIME DEFAULT NOW(),
    `updated_at` DATETIME DEFAULT NOW()
)  ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS `order_item` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `order_id` INT NOT NULL REFERENCES `order`(`id`),
    `item_id` INT NOT NULL REFERENCES `item_id`(`id`),
    `quantity` INT DEFAULT 1,
    `discount` DECIMAL(5,2) DEFAULT 0,
    `created_at` DATETIME DEFAULT NOW(),
    `updated_at` DATETIME DEFAULT NOW()
)  ENGINE=INNODB;

INSERT INTO `person`(`first_name`, `last_name`) VALUES
    ('Ann', 'Peterson'),
    ('Josh', 'Harris'),
    ('Sarah', 'Connor'),
    ('James', 'Ball');

INSERT INTO `item`(`name`, `price`) VALUES
    ('TV', 299.99),
    ('Carrot', 1.25),
    ('Patrol', 1.41),
    ('Soap', 0.4),
    ('Football Tickets', 149),
    ('T-Shirt', 19.1),
    ('Playstation 4 Pro', 419.99);

INSERT INTO `order`(`person_id`) VALUES
    (1),
    (2),
    (4),
    (4);

INSERT INTO `order_item`(`order_id`, `item_id`, `quantity`, `discount`) VALUES
    (1, 3, 4, 0),
    (1, 6, 1, 0),
    (2, 1, 1, 11.2),
    (2, 7, 1, 15.99),
    (3, 4, 3, 0),
    (3, 2, 8, 0),
    (3, 6, 1, 0),
    (4, 5, 1, 1.49);
    
select `first_name`,`last_name`,
(select count(*) from `order` where `order`.person_id=person.id) as total_orders,
(select sum(quantity) from order_item where order_item.order_id in (select id from `order` where `order`.person_id=person.id) ) as total_items_bought,
(select  sum((item.price-order_item.discount)*order_item.quantity)
from `order` 
inner join order_item on `order`.id = order_item.order_id
inner join item on item.id = order_item.item_id 
where  `order`.person_id=person.id
) as total_money_spent 
 from person;

