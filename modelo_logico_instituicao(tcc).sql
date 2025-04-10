-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema modelo_logiso_instituicao
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema modelo_logiso_instituicao
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `modelo_logiso_instituicao` DEFAULT CHARACTER SET utf8 ;
USE `modelo_logiso_instituicao` ;

-- -----------------------------------------------------
-- Table `modelo_logiso_instituicao`.`professores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modelo_logiso_instituicao`.`professores` (
  `matricula` VARCHAR(20) NOT NULL,
  `nome` VARCHAR(200) NULL,
  `telefone` VARCHAR(13) NULL,
  `email` VARCHAR(200) NULL,
  `areas_atuacao` TEXT NULL,
  PRIMARY KEY (`matricula`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modelo_logiso_instituicao`.`alunos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modelo_logiso_instituicao`.`alunos` (
  `matricula` VARCHAR(20) NOT NULL,
  `nome` VARCHAR(200) NULL,
  `ano_de_ingresso` INT NULL,
  `telefone` VARCHAR(13) NULL,
  `email` VARCHAR(200) NULL,
  `cursos` VARCHAR(45) NULL,
  PRIMARY KEY (`matricula`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modelo_logiso_instituicao`.`enderecos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modelo_logiso_instituicao`.`enderecos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `logradouro` VARCHAR(200) NOT NULL,
  `numero` VARCHAR(10) NOT NULL,
  `complemento` VARCHAR(45) NULL,
  `bairro` VARCHAR(45) NULL,
  `cidade` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modelo_logiso_instituicao`.`cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modelo_logiso_instituicao`.`cursos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `modalidade` VARCHAR(45) NOT NULL,
  `turno` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modelo_logiso_instituicao`.`tccs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modelo_logiso_instituicao`.`tccs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(60) NULL,
  `palavras_chave` VARCHAR(45) NULL,
  `link` VARCHAR(45) NULL,
  `professores_matricula` VARCHAR(20) NOT NULL,
  `alunos_matricula` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tccs_professores_idx` (`professores_matricula` ASC) VISIBLE,
  INDEX `fk_tccs_alunos1_idx` (`alunos_matricula` ASC) VISIBLE,
  CONSTRAINT `fk_tccs_professores`
    FOREIGN KEY (`professores_matricula`)
    REFERENCES `modelo_logiso_instituicao`.`professores` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tccs_alunos1`
    FOREIGN KEY (`alunos_matricula`)
    REFERENCES `modelo_logiso_instituicao`.`alunos` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modelo_logiso_instituicao`.`enderecos_alunos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modelo_logiso_instituicao`.`enderecos_alunos` (
  `alunos_matricula` VARCHAR(20) NOT NULL,
  `enderecos_id` INT NOT NULL,
  PRIMARY KEY (`alunos_matricula`, `enderecos_id`),
  INDEX `fk_alunos_has_enderecos_enderecos1_idx` (`enderecos_id` ASC) VISIBLE,
  INDEX `fk_alunos_has_enderecos_alunos1_idx` (`alunos_matricula` ASC) VISIBLE,
  CONSTRAINT `fk_alunos_has_enderecos_alunos1`
    FOREIGN KEY (`alunos_matricula`)
    REFERENCES `modelo_logiso_instituicao`.`alunos` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alunos_has_enderecos_enderecos1`
    FOREIGN KEY (`enderecos_id`)
    REFERENCES `modelo_logiso_instituicao`.`enderecos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modelo_logiso_instituicao`.`alunos/professores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modelo_logiso_instituicao`.`alunos/professores` (
  `alunos_matricula` VARCHAR(20) NOT NULL,
  `professores_matricula` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`alunos_matricula`, `professores_matricula`),
  INDEX `fk_alunos_has_professores_professores1_idx` (`professores_matricula` ASC) VISIBLE,
  INDEX `fk_alunos_has_professores_alunos1_idx` (`alunos_matricula` ASC) VISIBLE,
  CONSTRAINT `fk_alunos_has_professores_alunos1`
    FOREIGN KEY (`alunos_matricula`)
    REFERENCES `modelo_logiso_instituicao`.`alunos` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alunos_has_professores_professores1`
    FOREIGN KEY (`professores_matricula`)
    REFERENCES `modelo_logiso_instituicao`.`professores` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modelo_logiso_instituicao`.`cursos\alunos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modelo_logiso_instituicao`.`cursos\alunos` (
  `alunos_matricula` VARCHAR(20) NOT NULL,
  `cursos_id` INT NOT NULL,
  PRIMARY KEY (`alunos_matricula`, `cursos_id`),
  INDEX `fk_alunos_has_cursos_cursos1_idx` (`cursos_id` ASC) VISIBLE,
  INDEX `fk_alunos_has_cursos_alunos1_idx` (`alunos_matricula` ASC) VISIBLE,
  CONSTRAINT `fk_alunos_has_cursos_alunos1`
    FOREIGN KEY (`alunos_matricula`)
    REFERENCES `modelo_logiso_instituicao`.`alunos` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alunos_has_cursos_cursos1`
    FOREIGN KEY (`cursos_id`)
    REFERENCES `modelo_logiso_instituicao`.`cursos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
