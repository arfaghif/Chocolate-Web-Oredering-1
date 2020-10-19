-- MySQL Script generated by MySQL Workbench
-- Mon Oct 19 22:22:55 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema choc
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema choc
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `choc` DEFAULT CHARACTER SET utf8 ;
USE `choc` ;

-- -----------------------------------------------------
-- Table `choc`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `choc`.`user` (
  `username` VARCHAR(45) NOT NULL,
  `nama` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `type` INT NOT NULL,
  PRIMARY KEY (`username`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) ,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `choc`.`chocolate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `choc`.`chocolate` (
  `idchocolate` INT NOT NULL AUTO_INCREMENT,
  `nama` VARCHAR(45) NOT NULL,
  `amount_sold` INT NOT NULL DEFAULT 0,
  `price` INT NOT NULL,
  `amount_remaining` INT NOT NULL,
  `decs` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idchocolate`),
  INDEX `addchoco_idx` (`username` ASC) ,
  UNIQUE INDEX `idchocolate_UNIQUE` (`idchocolate` ASC) ,
  CONSTRAINT `addchoco`
    FOREIGN KEY (`username`)
    REFERENCES `choc`.`user` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `choc`.`transaksi`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `choc`.`transaksi` (
  `idtransaksi` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `idchocolate` INT NOT NULL,
  `amount` INT NOT NULL,
  `time` DATETIME NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `total_price` INT NOT NULL,
  PRIMARY KEY (`idtransaksi`),
  INDEX `user_buy_choco_idx` (`username` ASC) ,
  INDEX `type_choco_idx` (`idchocolate` ASC) ,
  UNIQUE INDEX `idtransaksi_UNIQUE` (`idtransaksi` ASC) ,
  CONSTRAINT `user_buy_choco`
    FOREIGN KEY (`username`)
    REFERENCES `choc`.`user` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `type_choco`
    FOREIGN KEY (`idchocolate`)
    REFERENCES `choc`.`chocolate` (`idchocolate`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
