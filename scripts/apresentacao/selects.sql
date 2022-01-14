/* Retorna a quantidade de unidades de geração distribuída de cada distribuidora */
SELECT 
`d`.`id`,
`d`.`nm_distribuidora`,
count(`d`.`id`) as `qtd_unid_geracao_distribuida`
FROM `cad_distribuidora` `d`
INNER JOIN `cad_unid_geracao_distribuida` `ugd` ON `d`.`id` = `ugd`.`id_cad_distribuidora` 
GROUP BY `d`.`id`;

/* Retorna todas as unidades de geração distribuída que ultrapassaram 100 de produção */
SELECT
`ugd`.`id`, 
`d`.`nm_distribuidora`,
`p`.`nm_produtor`,
`p`.`cad_tipo_produtor`,
`ugd`.`dt_instalacao`,
`m`.`nm_municipio`,
`est`.`nm_estado`,
`ugd`.`nn_potencia_instalada`,
`pgd`.`dt_periodo_inicio`,
`pgd`.`dt_periodo_fim`,
`pgd`.`nn_producao`
FROM `cad_unid_geracao_distribuida` `ugd`
INNER JOIN `cad_distribuidora` `d` ON `ugd`.`id_cad_distribuidora` = `d`.`id`
INNER JOIN `cad_produtor` `p` ON `ugd`.`id_cad_produtor` = `p`.`id`
INNER JOIN `cad_prod_geracao_distribuida` `pgd` ON `ugd`.`id` = `pgd`.`id_cad_unid_geracao_distribuida`
INNER JOIN `endereco` `e` ON `e`.`id` = `ugd`.`id_endereco`
INNER JOIN `municipio` `m` ON `e`.`id_municipio` = `m`.`id`
INNER JOIN `estado` `est` ON `est`.`id` = `m`.`id_estado`
WHERE
`pgd`.`nn_producao` > 100;