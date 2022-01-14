CREATE VIEW `view_unid_geracao_alta_tensao` AS
	SELECT 
		`gd`.`id` as id_unid_geracao_distribuida,
		`p`.`nm_produtor` as nm_produtor,
		`p`.`cad_tipo_produtor` as tipo_produtor,
		`tug`.`nm_sigla` as sigla_tipo,
		`tug`.`nm_tipo_unid_geracao` as tipo_unid_geracao,
		`gf`.`nm_grupo_fornecimento` as nm_grupo,
		`gf`.`ds_grupo_fornecimento` as ds_grupo,
		`d`.`nm_distribuidora` as nm_distribuidora,
		`m`.`nm_municipio` as nm_municipio,
		`es`.`nm_sigla` as sigla_estado
	FROM `cad_unid_geracao_distribuida` `gd`
	INNER JOIN `cad_produtor` `p` ON `gd`.`id_cad_produtor` = `p`.`id`
	INNER JOIN `cad_tipo_unid_geracao` `tug` ON `gd`.`id_cad_tipo_unid_geracao` = `tug`.`id`
	INNER JOIN `cad_grupo_fornecimento` `gf` ON `gd`.`id_cad_grupo_fornecimento` = `gf`.`id`
	INNER JOIN `cad_distribuidora` `d` ON `gd`.`id_cad_distribuidora` = `d`.`id`
	INNER JOIN `endereco` `e` ON `gd`.`id_endereco` = `e`.`id`
	INNER JOIN `municipio` `m` ON  `e`.`id_municipio` = `m`.`id`
	INNER JOIN `estado` `es` ON `m`.`id_estado` = `es`.`id`
	WHERE
		`gf`.`tensao` = 'A'