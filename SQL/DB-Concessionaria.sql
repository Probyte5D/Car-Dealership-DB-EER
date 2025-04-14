-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema concessionariaauto
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema concessionariaauto
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `concessionariaauto` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `concessionariaauto` ;

-- -----------------------------------------------------
-- Table `concessionariaauto`.`clienti`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `concessionariaauto`.`clienti` (
  `cliente_ID` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(20) NULL DEFAULT NULL,
  `cognome` VARCHAR(20) NULL DEFAULT NULL,
  `telefono` VARCHAR(50) NULL DEFAULT NULL,
  `email` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`cliente_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 31
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `concessionariaauto`.`marche`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `concessionariaauto`.`marche` (
  `marca_ID` INT NOT NULL AUTO_INCREMENT,
  `marca` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`marca_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 31
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `concessionariaauto`.`modelli`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `concessionariaauto`.`modelli` (
  `modello_ID` INT NOT NULL AUTO_INCREMENT,
  `marca_ID` INT NOT NULL,
  `modello` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`modello_ID`),
  INDEX `marca_ID` (`marca_ID` ASC) VISIBLE,
  CONSTRAINT `modelli_ibfk_1`
    FOREIGN KEY (`marca_ID`)
    REFERENCES `concessionariaauto`.`marche` (`marca_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 31
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `concessionariaauto`.`venditori`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `concessionariaauto`.`venditori` (
  `venditore_ID` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(25) NULL DEFAULT NULL,
  `cognome` VARCHAR(20) NULL DEFAULT NULL,
  `telefono` VARCHAR(50) NULL DEFAULT NULL,
  `email` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`venditore_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 31
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `concessionariaauto`.`veicoli`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `concessionariaauto`.`veicoli` (
  `veicolo_ID` INT NOT NULL AUTO_INCREMENT,
  `modello_ID` INT NOT NULL,
  `venditore_ID` INT NOT NULL,
  `anno_immatricolazione` YEAR NULL DEFAULT NULL,
  `prezzo_acquisto` FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (`veicolo_ID`),
  INDEX `modello_ID` (`modello_ID` ASC) VISIBLE,
  INDEX `venditore_ID` (`venditore_ID` ASC) VISIBLE,
  CONSTRAINT `veicoli_ibfk_1`
    FOREIGN KEY (`modello_ID`)
    REFERENCES `concessionariaauto`.`modelli` (`modello_ID`),
  CONSTRAINT `veicoli_ibfk_2`
    FOREIGN KEY (`venditore_ID`)
    REFERENCES `concessionariaauto`.`venditori` (`venditore_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 31
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `concessionariaauto`.`vendite`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `concessionariaauto`.`vendite` (
  `vendita_ID` INT NOT NULL AUTO_INCREMENT,
  `veicolo_ID` INT NOT NULL,
  `cliente_ID` INT NOT NULL,
  `data_vendita` DATE NOT NULL,
  `prezzo_vendita` FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (`vendita_ID`),
  INDEX `cliente_ID` (`cliente_ID` ASC) VISIBLE,
  INDEX `veicolo_ID` (`veicolo_ID` ASC) VISIBLE,
  CONSTRAINT `vendite_ibfk_1`
    FOREIGN KEY (`cliente_ID`)
    REFERENCES `concessionariaauto`.`clienti` (`cliente_ID`),
  CONSTRAINT `vendite_ibfk_2`
    FOREIGN KEY (`veicolo_ID`)
    REFERENCES `concessionariaauto`.`veicoli` (`veicolo_ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 31
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `concessionariaauto` ;

-- -----------------------------------------------------
-- procedure Insert_data
-- -----------------------------------------------------

DELIMITER $$
USE `concessionariaauto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Insert_data`()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK; -- Annulla la transazione in caso di errore
    END;
    
    -- Iniziamo una transazione    
	START TRANSACTION;

	-- Insert data into venditori
	INSERT INTO venditori (nome, cognome, telefono, email) VALUES
	('Marco', 'Rossi', '1234567890', 'marco.rossi@gmail.com'),
	('Luca', 'Bianchi', '0987654321', 'luca.bianchi@gmail.com'),
	('Giulia', 'Verdi', '1122334455', 'giulia.verdi@gmail.com'),
	('Anna', 'Neri', '2233445566', 'anna.neri@gmail.com'),
	('Paolo', 'Gialli', '3344556677', 'paolo.gialli@gmail.com'),
	('Laura', 'Blu', '4455667788', 'laura.blu@gmail.com'),
	('Matteo', 'Marroni', '5566778899', 'matteo.marroni@gmail.com'),
	('Sara', 'Rossi', '6677889900', 'sara.rossi@gmail.com'),
	('Davide', 'Bianchi', '7788990011', 'davide.bianchi@gmail.com'),
	('Elisa', 'Verdi', '8899001122', 'elisa.verdi@gmail.com');

	-- Insert data into marche
	INSERT INTO marche (marca) VALUES
	('Toyota'),
	('Honda'),
	('Ford'),
	('BMW'),
	('Audi'),
	('Mercedes-Benz'),
	('Volkswagen'),
	('Nissan'),
	('Hyundai'),
	('Kia');

	-- Insert data into clienti
	INSERT INTO clienti (nome, cognome, telefono, email) VALUES
	('Andrea', 'Ferrari', 123456789, 'andrea.ferrari@gmail.com'),
	('Maria', 'Russo', 987654321, 'maria.russo@gmail.com'),
	('Giovanni', 'Conti', 112233445, 'giovanni.conti@gmail.com'),
	('Francesca', 'Lombardi', 223344556, 'francesca.lombardi@gmail.com'),
	('Alessandro', 'Moretti', 334455667, 'alessandro.moretti@gmail.com'),
	('Martina', 'Ricci', 445566778, 'martina.ricci@gmail.com'),
	('Stefano', 'Marino', 556677889, 'stefano.marino@gmail.com'),
	('Chiara', 'Greco', 667788990, 'chiara.greco@gmail.com'),
	('Lorenzo', 'Bruno', 778899001, 'lorenzo.bruno@gmail.com'),
	('Valentina', 'Gallo', 889900112, 'valentina.gallo@gmail.com');

	-- Insert data into modelli
	INSERT INTO modelli (marca_ID, modello) VALUES
	(1, 'Corolla'),
	(2, 'Civic'),
	(3, 'Mustang'),
	(4, 'X5'),
	(5, 'A4'),
	(6, 'C-Class'),
	(7, 'Golf'),
	(8, 'Altima'),
	(9, 'Elantra'),
	(10, 'Sportage');

	-- Insert data into veicoli
	INSERT INTO veicoli (modello_ID, venditore_ID, anno_immatricolazione, prezzo_acquisto) VALUES
	(1, 1, 2020, 20000.00),
	(2, 2, 2019, 18000.00),
	(3, 3, 2021, 25000.00),
	(4, 4, 2018, 30000.00),
	(5, 5, 2022, 35000.00),
	(6, 6, 2020, 40000.00),
	(7, 7, 2019, 22000.00),
	(8, 8, 2021, 24000.00),
	(9, 9, 2018, 21000.00),
	(10, 10, 2022, 26000.00);

	-- Insert data into vendite
	INSERT INTO vendite (veicolo_ID, cliente_ID, data_vendita, prezzo_vendita) VALUES
	(1, 1, '2023-01-15', 22000.00),
	(2, 2, '2023-02-20', 19000.00),
	(3, 3, '2023-03-25', 27000.00),
	(4, 4, '2023-04-30', 32000.00),
	(5, 5, '2023-05-05', 37000.00),
	(6, 6, '2023-06-10', 42000.00),
	(7, 7, '2023-07-15', 24000.00),
	(8, 8, '2023-08-20', 26000.00),
	(9, 9, '2023-09-25', 23000.00),
	(10, 10, '2023-10-30', 28000.00);

	-- Confermiamo le modifiche
	COMMIT;
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
