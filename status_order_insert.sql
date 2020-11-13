insert into public.status_order (id_order, id_status, "time", is_active, id_user) values (4, 1, '2020-11-13 19:22:10.568816', false, 9);
insert into public.status_order (id_order, id_status, "time", is_active, id_user) values (4, 3, '2020-11-13 19:32:10.568816', false, 9);
insert into public.status_order (id_order, id_status, "time", is_active, id_user) values (4, 4, '2020-11-13 19:42:10.568816', false, 9);
insert into public.status_order (id_order, id_status, "time", is_active, id_user) values (4, 5, '2020-11-13 19:52:10.568816', true, 9);
insert into public.status_order (id_order, id_status, "time", is_active, id_user) values (5, 8);


-- pour calculer le délais d'attente de la préparation a la livraison d'un produit, il faut faire la différence entre la colomne time de la ligne possédant l'id_status 1 et celle de la ligne possédant l'id_status 5
-- ayant toute deux le même id_order 
-- même chose pour la vente à emporter mais la différence entre l'id_status 1 et 2