CREATE TABLE `dim_dealer` (
    `dealer_id` int  NOT NULL ,
    `country_name` varchar(100)  NOT NULL ,
    `location` varchar(100)  NOT NULL ,
    `dealer_name` varchar(100)  NOT NULL ,
    `dealer_contact` varchar(100)  NOT NULL ,
    PRIMARY KEY (
        `dealer_id`
    )
);

CREATE TABLE `dim_branch` (
    `branch_id` int  NOT NULL ,
    `name` varchar(100)  NOT NULL ,
    `address` varchar(100)  NOT NULL ,
    `country` varchar(100)  NOT NULL ,
    PRIMARY KEY (
        `branch_id`
    )
);

CREATE TABLE `dim_date` (
    `date_id` int  NOT NULL ,
    `date` date  NOT NULL ,
    PRIMARY KEY (
        `date_id`
    )
);

CREATE TABLE `fact_revenue` (
    `dealer_id` int  NOT NULL ,
    `date_id` int  NOT NULL ,
    `branch_id` int  NOT NULL ,
    `units_sold` int  NOT NULL ,
    `revenue` decimal(8,2)  NOT NULL ,
    PRIMARY KEY (
        `dealer_id`,`date_id`,`branch_id`
    ),
    CONSTRAINT `fk_fact_revenue_dealer_id` FOREIGN KEY(`dealer_id`) REFERENCES `dim_dealer` (`dealer_id`),
    CONSTRAINT `fk_fact_revenue_date_id` FOREIGN KEY(`date_id`) REFERENCES `dim_date` (`date_id`),
    CONSTRAINT `fk_fact_revenue_branch_id` FOREIGN KEY(`branch_id`) REFERENCES `dim_branch` (`branch_id`)
);

CREATE TABLE `dim_product` (
    `product_id` int  NOT NULL ,
    `model_id` int  NOT NULL ,
    `product_name` varchar(100)  NOT NULL ,
    `variant_name` varchar(100)  NOT NULL ,
    `fuel_type` varchar(100)  NOT NULL ,
    PRIMARY KEY (
        `product_id`
    )
);

CREATE TABLE `fact_supply` (
    `product_id` int  NOT NULL ,
    `date_id` int  NOT NULL ,
    `branch_id` int  NOT NULL ,
    `units_supplied` int  NOT NULL ,
    PRIMARY KEY (
        `product_id`,`date_id`,`branch_id`
    ),
    CONSTRAINT `fk_fact_supply_product_id` FOREIGN KEY(`product_id`) REFERENCES `dim_product` (`product_id`),
    CONSTRAINT `fk_fact_supply_date_id` FOREIGN KEY(`date_id`) REFERENCES `dim_date` (`date_id`),
    CONSTRAINT `fk_fact_supply_branch_id` FOREIGN KEY(`branch_id`) REFERENCES `dim_branch` (`branch_id`)
);

INSERT INTO `dim_dealer` (`dealer_id`, `country_name`, `location`, `dealer_name`, `dealer_contact`) VALUES (1, 'Kenya', 'Nairobi', 'Bluegrass Rv', '(578)905-0710');
INSERT INTO `dim_dealer` (`dealer_id`, `country_name`, `location`, `dealer_name`, `dealer_contact`) VALUES (2, 'Kenya', 'Nairobi', 'Toyota / Waipahu Auto Co', '(367)341-5172x46829');
INSERT INTO `dim_dealer` (`dealer_id`, `country_name`, `location`, `dealer_name`, `dealer_contact`) VALUES (3, 'Uganda', 'Kampala', 'Ben Funk Inc', '022.543.8835');
INSERT INTO `dim_dealer` (`dealer_id`, `country_name`, `location`, `dealer_name`, `dealer_contact`) VALUES (4, 'Tanzania', 'Dodoma', 'Car Quest Auto Parts', '07664036852');
INSERT INTO `dim_dealer` (`dealer_id`, `country_name`, `location`, `dealer_name`, `dealer_contact`) VALUES (5, 'Somalia', 'Mogadishu', 'Savile ROW Custom Clothiers', '1-262-220-0023');

INSERT INTO `dim_branch` (`branch_id`, `name`, `address`, `country`) VALUES (1, 'Vappa Shop Br.', '496 Brooklyn Mission Apt. 466\nCelestineberg, WV 99122', 'Kenya');
INSERT INTO `dim_branch` (`branch_id`, `name`, `address`, `country`) VALUES (2, '23Rd Century Br.', '65849 Ashlee Rapid Apt. 540\nDaughertyhaven, IN 26630', 'Kenya');
INSERT INTO `dim_branch` (`branch_id`, `name`, `address`, `country`) VALUES (3, 'Spray Shop Br.', '5024 Ondricka Rapid\nMyrnaburgh, MS 75706-7194', 'Uganda');
INSERT INTO `dim_branch` (`branch_id`, `name`, `address`, `country`) VALUES (4, 'Odit Br.', '20001 Gulgowski Keys\nLake Sasha, KY 20272-6264', 'Tanzania');
INSERT INTO `dim_branch` (`branch_id`, `name`, `address`, `country`) VALUES (5, 'Veniam Br.', '68676 Koepp Tunnel\nEast Sven, FL 77729', 'Somalia');


INSERT INTO `dim_date` (`date_id`, `date`) VALUES (1, '1987-01-08');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (2, '1986-01-11');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (3, '1985-01-06');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (4, '1996-11-26');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (5, '2019-06-23');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (6, '1998-03-05');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (7, '1996-04-07');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (8, '1993-12-17');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (9, '1982-04-26');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (10, '2019-08-16');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (11, '2015-01-25');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (12, '2013-04-26');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (13, '2016-08-26');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (14, '1998-08-29');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (15, '2003-05-02');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (16, '1985-04-27');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (17, '2004-09-03');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (18, '2007-08-03');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (19, '1998-11-11');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (20, '1998-09-03');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (21, '1991-09-10');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (22, '1997-06-20');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (23, '1976-10-15');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (24, '1973-08-15');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (25, '2003-05-26');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (26, '1987-01-13');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (27, '1988-07-30');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (28, '2022-05-03');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (29, '2019-07-17');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (30, '2021-08-27');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (31, '1994-11-28');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (32, '1976-08-25');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (33, '1972-10-22');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (34, '1998-02-28');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (35, '1982-01-12');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (36, '1982-03-19');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (37, '2017-07-20');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (38, '1980-06-18');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (39, '2011-04-01');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (40, '1975-02-07');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (41, '1990-10-04');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (42, '2022-09-16');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (43, '2015-04-02');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (44, '2002-03-20');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (45, '1991-03-01');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (46, '1986-04-02');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (47, '1970-03-27');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (48, '2015-04-08');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (49, '2006-11-09');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (50, '1990-07-06');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (51, '1998-02-04');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (52, '1996-04-09');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (53, '1973-03-28');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (54, '1986-12-30');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (55, '1991-01-16');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (56, '2008-02-18');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (57, '2008-06-21');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (58, '2020-01-27');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (59, '2021-11-04');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (60, '2010-06-16');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (61, '1999-04-20');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (62, '1975-04-30');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (63, '2010-05-26');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (64, '1993-12-22');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (65, '1971-01-04');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (66, '2002-11-30');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (67, '1979-02-20');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (68, '2020-09-01');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (69, '1999-11-17');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (70, '1980-05-28');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (71, '1985-07-30');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (72, '1970-03-16');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (73, '2017-09-22');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (74, '2001-12-25');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (75, '1981-09-07');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (76, '1988-11-11');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (77, '2001-03-09');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (78, '2021-09-03');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (79, '1988-06-27');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (80, '2005-04-08');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (81, '1989-11-08');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (82, '1988-03-01');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (83, '1972-07-17');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (84, '2017-08-14');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (85, '1998-04-24');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (86, '1993-08-19');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (87, '2010-03-03');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (88, '1999-07-12');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (89, '1998-12-06');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (90, '1991-05-28');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (91, '1973-02-19');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (92, '1981-03-07');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (93, '1972-06-24');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (94, '1992-08-27');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (95, '2015-08-19');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (96, '2008-05-21');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (97, '2018-02-10');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (98, '2003-01-07');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (99, '1991-05-09');
INSERT INTO `dim_date` (`date_id`, `date`) VALUES (100, '2021-11-23');


INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (1, 1, 1, 6, '32486.89');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (1, 1, 11, 25, '75145.59');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (1, 1, 21, 4, '12087.27');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (1, 1, 31, 39, '71426.13');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (1, 1, 41, 21, '54541.30');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (1, 1, 51, 47, '31198.04');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (1, 1, 61, 47, '65036.93');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (1, 1, 71, 41, '82992.19');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (1, 1, 81, 42, '19636.43');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (1, 1, 91, 43, '13029.86');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (1, 1, 6, 6, '56052.36');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (1, 1, 16, 43, '57877.70');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (1, 1, 26, 13, '73465.50');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (1, 1, 36, 42, '93262.41');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (1, 1, 46, 43, '92070.01');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (1, 1, 56, 1, '81017.41');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (1, 1, 66, 47, '85648.09');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (1, 1, 76, 48, '17502.70');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (1, 1, 86, 35, '79805.89');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (1, 1, 96, 43, '47089.20');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (2, 2, 2, 13, '62449.05');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (2, 2, 12, 40, '53387.98');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (2, 2, 22, 20, '67295.14');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (2, 2, 32, 49, '79339.38');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (2, 2, 42, 8, '88275.77');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (2, 2, 52, 6, '66963.74');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (2, 2, 62, 32, '74546.26');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (2, 2, 72, 45, '82224.61');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (2, 2, 82, 49, '11376.67');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (2, 2, 92, 26, '86187.76');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (2, 2, 7, 49, '11622.13');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (2, 2, 17, 22, '14141.62');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (2, 2, 27, 32, '87976.03');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (2, 2, 37, 7, '67439.65');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (2, 2, 47, 6, '28088.38');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (2, 2, 57, 49, '29528.22');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (2, 2, 67, 4, '94143.95');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (2, 2, 77, 17, '96817.99');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (2, 2, 87, 24, '20699.83');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (2, 2, 97, 10, '21476.98');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (3, 3, 3, 31, '50201.84');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (3, 3, 13, 50, '40115.41');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (3, 3, 23, 26, '66713.82');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (3, 3, 33, 6, '79907.72');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (3, 3, 43, 26, '12982.16');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (3, 3, 53, 8, '87538.83');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (3, 3, 63, 16, '83346.72');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (3, 3, 73, 31, '56066.61');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (3, 3, 83, 9, '79743.78');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (3, 3, 93, 36, '34857.42');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (3, 3, 8, 17, '11331.32');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (3, 3, 18, 42, '82591.72');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (3, 3, 28, 23, '92359.76');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (3, 3, 38, 27, '95526.29');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (3, 3, 48, 14, '30114.71');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (3, 3, 58, 3, '75226.56');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (3, 3, 68, 26, '89371.59');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (3, 3, 78, 13, '83105.38');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (3, 3, 88, 20, '19919.98');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (3, 3, 98, 50, '61114.47');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (4, 4, 4, 17, '27048.56');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (4, 4, 14, 40, '84778.27');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (4, 4, 24, 43, '32551.79');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (4, 4, 34, 43, '95875.27');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (4, 4, 44, 36, '60917.47');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (4, 4, 54, 17, '48542.99');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (4, 4, 64, 10, '26350.15');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (4, 4, 74, 9, '72261.57');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (4, 4, 84, 3, '68272.86');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (4, 4, 94, 7, '92686.69');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (4, 4, 9, 35, '60441.09');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (4, 4, 19, 37, '21668.26');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (4, 4, 29, 15, '80071.54');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (4, 4, 39, 46, '37233.88');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (4, 4, 49, 32, '65493.55');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (4, 4, 59, 45, '58471.69');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (4, 4, 69, 24, '56486.44');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (4, 4, 79, 11, '84711.95');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (4, 4, 89, 41, '63393.99');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (4, 4, 99, 44, '64134.01');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (5, 5, 5, 17, '22070.92');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (5, 5, 15, 15, '87339.98');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (5, 5, 25, 44, '84763.19');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (5, 5, 35, 15, '88844.15');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (5, 5, 45, 35, '76603.98');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (5, 5, 55, 40, '78885.40');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (5, 5, 65, 7, '55530.01');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (5, 5, 75, 40, '24322.41');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (5, 5, 85, 48, '17973.33');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (5, 5, 95, 22, '32522.87');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (5, 5, 10, 12, '42860.42');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (5, 5, 20, 41, '91561.59');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (5, 5, 30, 16, '87335.10');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (5, 5, 40, 37, '85040.18');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (5, 5, 50, 14, '80557.85');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (5, 5, 60, 37, '35872.02');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (5, 5, 70, 8, '23281.92');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (5, 5, 80, 49, '94403.11');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (5, 5, 90, 40, '57042.76');
INSERT INTO `fact_revenue` (`dealer_id`, `branch_id`, `date_id`, `units_sold`, `revenue`) VALUES (5, 5, 100, 26, '94981.01');


INSERT INTO `dim_product` (`product_id`, `model_id`, `product_name`, `variant_name`, `fuel_type`) VALUES (1, 7, 'Chrysler', 'variant1', 'petrol');
INSERT INTO `dim_product` (`product_id`, `model_id`, `product_name`, `variant_name`, `fuel_type`) VALUES (2, 3, 'Peugeot', 'variant1', 'petrol');
INSERT INTO `dim_product` (`product_id`, `model_id`, `product_name`, `variant_name`, `fuel_type`) VALUES (3, 9, 'Mazda', 'variant1', 'petrol');
INSERT INTO `dim_product` (`product_id`, `model_id`, `product_name`, `variant_name`, `fuel_type`) VALUES (4, 8, 'Lexus', 'variant2', 'diesel');
INSERT INTO `dim_product` (`product_id`, `model_id`, `product_name`, `variant_name`, `fuel_type`) VALUES (5, 8, 'Jeep', 'variant2', 'diesel');
INSERT INTO `dim_product` (`product_id`, `model_id`, `product_name`, `variant_name`, `fuel_type`) VALUES (6, 6, 'Buick', 'variant1', 'petrol');
INSERT INTO `dim_product` (`product_id`, `model_id`, `product_name`, `variant_name`, `fuel_type`) VALUES (7, 2, 'Ford', 'variant2', 'diesel');
INSERT INTO `dim_product` (`product_id`, `model_id`, `product_name`, `variant_name`, `fuel_type`) VALUES (8, 3, 'Bugatti', 'variant2', 'diesel');
INSERT INTO `dim_product` (`product_id`, `model_id`, `product_name`, `variant_name`, `fuel_type`) VALUES (9, 3, 'Toyota', 'variant2', 'diesel');
INSERT INTO `dim_product` (`product_id`, `model_id`, `product_name`, `variant_name`, `fuel_type`) VALUES (10, 7, 'Bentley', 'variant1', 'petrol');
