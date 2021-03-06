DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `validar_cnpj`(CNPJ CHAR(14)) RETURNS smallint(1)
BEGIN
	DECLARE INDICE INT;
    DECLARE SOMA INT;
    DECLARE DIGITO_1 INT;
    DECLARE DIGITO_2 INT;
    DECLARE VAR1 INT;
    DECLARE VAR2 INT;
    DECLARE DIGITO_1_CNPJ CHAR(1);
    DECLARE DIGITO_2_CNPJ CHAR(1);
    DECLARE NR_DOCUMENTO_AUX VARCHAR(14);
    SET SOMA = 0;
    SET INDICE = 1;
    SET VAR1 = 5;
	/* Verificando se o formato é valido */
	SET NR_DOCUMENTO_AUX = LTRIM(RTRIM(CNPJ));
    IF (NR_DOCUMENTO_AUX IN ('00000000000000', '11111111111111', '22222222222222', '33333333333333', '44444444444444', '55555555555555', '66666666666666', '77777777777777', '88888888888888', '99999999999999')) THEN
		RETURN 0;
    END IF;
    
    IF (LENGTH(NR_DOCUMENTO_AUX) <> 14) THEN
		RETURN 0;
    END IF;
	/* Iniciando a validacao */
	SET DIGITO_1_CNPJ = SUBSTRING(CNPJ, LENGTH(CNPJ)- 1, 1);
    SET DIGITO_2_CNPJ = SUBSTRING(CNPJ, LENGTH(CNPJ), 1);
 
	WHILE (INDICE <= 4 ) DO
		SET SOMA = SOMA + CAST(SUBSTRING(CNPJ, INDICE, 1) AS UNSIGNED) * VAR1;
        SET INDICE = INDICE + 1;
        SET VAR1 = VAR1 - 1;
	END WHILE;
 
       
    SET VAR2 = 9;
    WHILE (INDICE <= 12 ) DO
        SET SOMA = SOMA + CAST(SUBSTRING(CNPJ, INDICE, 1) AS UNSIGNED) * VAR2;
        SET INDICE = INDICE + 1;
        SET VAR2 = VAR2 - 1;
    END WHILE;
 
    SET DIGITO_1 = (SOMA % 11 );
 
	/* Primeiro Digito Verificador */
    IF DIGITO_1 < 2 THEN
        SET DIGITO_1 = 0;
    ELSE
        SET DIGITO_1 = 11 - (SOMA % 11);
	END IF;

    SET INDICE = 1;
    SET SOMA = 0;
    SET VAR1 = 6;
    
 
    WHILE (INDICE <= 5 ) DO
        SET SOMA = SOMA + CAST(SUBSTRING(CNPJ, INDICE, 1) AS UNSIGNED) * VAR1;
        SET INDICE = INDICE + 1;
        SET VAR1 = VAR1 - 1;
    END WHILE;
 
    SET VAR2 = 9;
    WHILE (INDICE <= 13 ) DO
        SET SOMA = SOMA + CAST(SUBSTRING(CNPJ, INDICE, 1) AS UNSIGNED) * VAR2;
        SET INDICE = INDICE + 1;
        SET VAR2 = VAR2 - 1;       
    END WHILE;
    
    SET DIGITO_2 = (SOMA % 11);
	/* Segundo Digito Verificador */
    IF DIGITO_2 < 2 THEN
        SET DIGITO_2 = 0;
    ELSE
        SET DIGITO_2 = 11 - (SOMA % 11 );
	END IF;
    
	/* Validando os digitos verificadores calculados com os digitos verificadores do CNPJ informado */
    IF (DIGITO_1 = DIGITO_1_CNPJ) AND (DIGITO_2 = DIGITO_2_CNPJ) THEN
        RETURN 1;
    ELSE
        RETURN 0;
	END IF;
END ;;
DELIMITER ;