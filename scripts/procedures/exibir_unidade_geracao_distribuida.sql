DELIMITER ;;
CREATE PROCEDURE `exibir_unidade_geracao_distribuida`(IN numero INT)
BEGIN 
	SELECT * FROM `cad_unid_geracao_distribuida` AS gd LIMIT numero;
END ;;
DELIMITER ;