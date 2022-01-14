DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `cadastrar_produtor`(IN cpf_cnpj VARCHAR(14), IN nm_produtor VARCHAR(100), IN ds_email VARCHAR(100), IN ds_telefone VARCHAR(11), IN pf_sexo CHAR(1), IN pf_dt_nascimento DATE, IN pj_nm_razao_social VARCHAR(100))
BEGIN
	DECLARE ID_PRODUTOR BIGINT(20);
    DECLARE ERRO BOOLEAN;
	DECLARE MSG_ERROR VARCHAR(100);
    DECLARE MSG_SUCESSO VARCHAR(100);
    DECLARE MSG VARCHAR(100);
    DECLARE MSG_ERRO_BD VARCHAR(100);
    
    DECLARE CPF_CNPJ_INVALIDO VARCHAR(45);
    DECLARE CPF_CADASTRADO VARCHAR(45);
    DECLARE CNPJ_CADASTRADO VARCHAR(45); 
    
    DECLARE ERRO_BD SMALLINT DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET ERRO_BD = 1;
    
    SET MSG_SUCESSO = 'CADASTRO REALIZADO COM SUCESSO!';
    SET MSG_ERRO_BD = 'ERRO DE BANCO DE DADOS!';
    SET MSG_ERROR = 'CPF OU CNPJ INVÁLIDO!';
    SET CPF_CNPJ_INVALIDO = 'CPF OU CNPJ INVÁLIDO!';
    SET CPF_CADASTRADO = 'CPF JÁ CADASTRADO!';
    SET CNPJ_CADASTRADO = 'CNPJ JÁ CADASTRADO!';
    
    START TRANSACTION;
    
    /* VERIFICAR SE SÓ POSSUI NÚMEROS */
	IF cpf_cnpj REGEXP ('^[0-9]+$') THEN
		/* VALIDAR TAMANHO */
		IF CHAR_LENGTH(cpf_cnpj) = 11 THEN
			/* VALIDAR CPF */
            IF validar_cpf(cpf_cnpj) THEN
                SET ID_PRODUTOR = (SELECT `pf`.`id` FROM `cad_produtor` `p`
								   INNER JOIN `cad_detalhe_pessoa_fisica` `pf` ON `p`.`id` = `pf`.`id_cad_produtor`
								   WHERE `pf`.`nn_cpf` = cpf_cnpj);
                
                IF ID_PRODUTOR THEN
					SET ERRO = TRUE;
					SET MSG = CPF_CADASTRADO;
				ELSE
                    INSERT INTO `cad_produtor` (`cad_tipo_produtor`,`dt_cadastro`,`nm_produtor`,`ds_email`,`ds_telefone`) 
                    VALUES ('PF',NOW(),nm_produtor,ds_email,ds_telefone);
                    
                    SET ID_PRODUTOR = LAST_INSERT_ID();
                    
                    INSERT INTO `cad_detalhe_pessoa_fisica` (`id_cad_produtor`,`sexo`,`nn_cpf`,`dt_nascimento`)
                    VALUES (ID_PRODUTOR,pf_sexo,cpf_cnpj,pf_dt_nascimento);
                    
                    IF ERRO_BD = 1 THEN
						ROLLBACK;
                        SET ERRO = TRUE;
						SET MSG = MSG_ERRO_BD;
					ELSE
						COMMIT;
                        SET ERRO = FALSE;
						SET MSG = MSG_SUCESSO;
                    END IF;
                END IF;
            ELSE
				SET ERRO = TRUE;
				SET MSG = 'CPF INVÁLIDO!';
            END IF;
		ELSEIF CHAR_LENGTH(cpf_cnpj) = 14 THEN
			/* VALIDAR CNPJ */
			IF validar_cnpj(cpf_cnpj) THEN
				SET ID_PRODUTOR = (SELECT `pj`.`id` FROM `cad_produtor` `p`
								   INNER JOIN `cad_detalhe_pessoa_juridica` `pj` ON `p`.`id` = `pj`.`id_cad_produtor`
								   WHERE `pj`.`nn_cnpj` = cpf_cnpj);
				
				IF ID_PRODUTOR THEN
					SET ERRO = TRUE;
					SET MSG = CNPJ_CADASTRADO;
				ELSE
                    INSERT INTO `cad_produtor` (`cad_tipo_produtor`,`dt_cadastro`,`nm_produtor`,`ds_email`,`ds_telefone`) 
                    VALUES ('PJ',NOW(),nm_produtor,ds_email,ds_telefone);
                    
                    SET ID_PRODUTOR = LAST_INSERT_ID();
                    
                    INSERT INTO `cad_detalhe_pessoa_juridica` (`id_cad_produtor`,`nn_cnpj`,`nm_razao_social`)
                    VALUES (ID_PRODUTOR,cpf_cnpj,pj_nm_razao_social);
					
                    IF ERRO_BD = 1 THEN
						ROLLBACK;
                        SET ERRO = TRUE;
						SET MSG = MSG_ERRO_BD;
					ELSE
						COMMIT;
						SET ERRO = FALSE;
						SET MSG = MSG_SUCESSO;
                    END IF;
                END IF;
            ELSE
				SET ERRO = TRUE;
				SET MSG = 'CNPJ INVÁLIDO!';
            END IF;
		ELSE
			SET ERRO = TRUE;
			SET MSG = CPF_CNPJ_INVALIDO;
		END IF;
	ELSE 
		SET ERRO = TRUE;
        SET MSG = CPF_CNPJ_INVALIDO;
	END IF;
    
    IF ERRO THEN
		SELECT FALSE AS RETORNO, MSG AS MENSAGEM;
    ELSE
		SELECT TRUE AS RETORNO, MSG AS MENSAGEM;
    END IF;
END ;;

DELIMITER ;