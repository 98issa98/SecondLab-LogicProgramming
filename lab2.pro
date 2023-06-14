﻿/* Domains */
domain product_id = integer.
domain product_name = string.
domain category = electronics ; furniture ; kitchen.
domain price = float.
domain customer_name = string.
domain customer_phone = string.
domain date = string.

/* Facts  */
product(1, 'tv',electronics,40000.0).
product(2, 'microwave', electronics,55000.0).
product(3, 'refrigerator', electronics10000.0).
product(4, 'iron',furniture,19000.0).
product(5, 'rug', cosmetics, 100.0).
product(6, 'couch',furniture,60000.0).
product(7, 'wardrobe',furniture,20000.0).
product(8, 'cooker',kitchen,5000.0).
product(9, 'sink',kitchen,15000.0).
product(10, 'dishes',kitchen,9000.0).

customer('jake', '122334455').
customer('sam', '9887766554').
customer('issa', '8776655443').
customer('joe', '2334455667').

order('122334455', [2, 3, 5], [2, 1, 5], '2023-04-21').
order('9887766554', [3, 9], [6, 3], '2023-04-23').
order('122334455', [8, 4], [3, 2], '2023-04-27').

/* Rules */
% Get a list of all products in a given category
category_products(Category, Products) :-
findall((ID, Name, Price), product(ID, Name, Category, Price), Products).

% Get the total number of orders for a given customer
customer_order_count(Customertv, Count) :-
findall(Order, order(Customertv, _, _, Order), Orders),
length(Orders, Count).

% Get the cost of all orders of a given customer
customer_total_cost(Customertv, TotalCost) :-
findall((ProductID, Quantity), (order(Customertv, ProductIDs, Quantities, _),
nth0(Index, ProductIDs, ProductID), nth0(Index, Quantities, Quantity)),
ProductQuantities),
aggregate_all(sum(Price * Quantity), (member((ProductID, Quantity), ProductQuantities),
product(ProductID, _, _, Price)), TotalCost).

% Get the average cost of products in a given category
average_category_price(Category, AveragePrice) :-
category_products(Category, Products),
maplist(third, Products, Prices),
average(Prices, AveragePrice).

/* Helper Predicates */
% Returns the third argument from the list
third((_, _, X), X).

% Calculates the average of a list of numbers
average(List, Average) :-
sum_list(List, Sum),
length(List, Length),
Average is Sum / Length.
