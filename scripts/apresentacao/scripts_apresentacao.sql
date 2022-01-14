/* PROCEDURES */
call exibir_unidade_geracao_distribuida(10);
call exibir_unidade_geracao_distribuida_por_concessionaria("coelba");
call geracao_distribuida.cadastrar_produtor('71521374040', 'diego cunha', 'diego2@gmail.com', '71981114626', 'M', '1986-12-29', NULL);
call geracao_distribuida.cadastrar_produtor('48529517000107', 'Nome fantasia', 'email2@gmail.com', '71981114626', NULL, NULL, 'Razão Social');

/* TRIGGERS */
INSERT INTO `cad_unid_geracao_distribuida` 
(`id_cad_produtor`,`id_cad_distribuidora`,`id_cad_tipo_unid_geracao`,`id_cad_grupo_fornecimento`,`id_endereco`,`dt_instalacao`,`nn_potencia_instalada`)
VALUES (3,1,3,1,1,'2021-11-11 00:00:00',8000);

UPDATE `cad_unid_geracao_distribuida` SET `id_cad_tipo_unid_geracao` = 4 WHERE `id` = 3