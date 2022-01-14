SHOW TABLES;

ANALYZE TABLE `cad_unid_geracao_distribuida`;
ANALYZE TABLE `cad_produtor`;
ANALYZE TABLE `cad_detalhe_pessoa_fisica`;
ANALYZE TABLE `cad_detalhe_pessoa_juridica`;

EXPLAIN SELECT * FROM `cad_unid_geracao_distribuida` WHERE `id` = 1;
EXPLAIN SELECT * FROM `cad_produtor` WHERE `id` = 1;
EXPLAIN SELECT * FROM `cad_detalhe_pessoa_fisica` WHERE `id` = 1;
EXPLAIN SELECT * FROM `cad_detalhe_pessoa_juridica` WHERE `id` = 1;

EXPLAIN SELECT * FROM `cad_produtor` `p`, `cad_detalhe_pessoa_fisica` `pf` WHERE `pf`.`nn_cpf` = '81615394052';
/*
1	SIMPLE	pf		const	uq_nn_cpf	uq_nn_cpf	11	const	1	100.00	
1	SIMPLE	p		ALL					2	100.00	
*/
EXPLAIN SELECT * FROM `cad_produtor` `p`, `cad_detalhe_pessoa_juridica` `pj` WHERE `pj`.`nn_cnpj` = '85482319000153';
/*
1	SIMPLE	pj		const	uq_nn_cnpj	uq_nn_cnpj	14	const	1	100.00	
1	SIMPLE	p		ALL					2	100.00	
*/

SHOW INDEX FROM `cad_detalhe_pessoa_fisica`;
SHOW INDEX FROM `cad_detalhe_pessoa_juridica`;
/*
Na tabela cad_detalhe_pessoa_fisica e cad_detalhe_pessoa_juridica já possuem 2 index que são:
cad_detalhe_pessoa_fisica
	- PRIMARY
	- uq_nn_cpf
	- fk_cad_detalhe_pessoa_fisica_cad_consumidor_idx
cad_detalhe_pessoa_juridica
	- PRIMARY
	- uq_nn_cnpj
	- fk_cad_detalhe_pessoa_juridica_cad_consumidor_idx
*/

SELECT * FROM information_schema.statistics WHERE table_name ='cad_detalhe_pessoa_fisica' AND table_schema = 'geracao_distribuida';
SELECT * FROM information_schema.statistics WHERE table_name ='cad_detalhe_pessoa_juridica' AND table_schema = 'geracao_distribuida';