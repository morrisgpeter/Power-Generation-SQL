DELIMITER ;;
CREATE PROCEDURE `exibir_unidade_geracao_distribuida_por_concessionaria`(IN concessionaria VARCHAR(255))
BEGIN
	DECLARE id_concessionaria INT;
	
	SET id_concessionaria = (SELECT `id` FROM `cad_distribuidora` WHERE `nm_distribuidora` = concessionaria);

	SELECT * FROM `cad_unid_geracao_distribuida` WHERE `id_cad_distribuidora` = id_concessionaria;
END ;;
DELIMITER ;