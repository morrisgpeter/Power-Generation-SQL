CREATE DEFINER = CURRENT_USER TRIGGER `geracao_distribuida`.`cad_unid_geracao_distribuida_AFTER_UPDATE` AFTER UPDATE ON `cad_unid_geracao_distribuida` FOR EACH ROW
BEGIN
	DECLARE nm_grupo_fornecimento_old CHAR(3);
    DECLARE nm_grupo_fornecimento_new CHAR(3);

	IF NEW.`id_cad_grupo_fornecimento` != OLD.`id_cad_grupo_fornecimento` THEN
		SET nm_grupo_fornecimento_old = (SELECT `nm_grupo_fornecimento` FROM `cad_grupo_fornecimento` WHERE `id`= OLD.`id_cad_grupo_fornecimento`);
		SET nm_grupo_fornecimento_new = (SELECT `nm_grupo_fornecimento` FROM `cad_grupo_fornecimento` WHERE `id`= NEW.`id_cad_grupo_fornecimento`);
        
		INSERT INTO `hist_unid_geracao_distribuida`
        (`id_cad_unid_geracao_distribuida`,`old_cad_grupo_fornecimento`,`new_cad_grupo_fornecimento`,`ds_historico`) 
        VALUES
        (NEW.`id`, OLD.`id_cad_grupo_fornecimento`,NEW.`id_cad_grupo_fornecimento`,CONCAT('GRUPO DE FORNECIMENTO ALTERADO DE [',nm_grupo_fornecimento_old, '] PARA [',nm_grupo_fornecimento_new,'].'));
    END IF;
END