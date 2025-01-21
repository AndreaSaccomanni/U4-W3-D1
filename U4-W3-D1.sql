CREATE TABLE Clienti(
NumeroCliente BIGSERIAL NOT NULL PRIMARY KEY,
Nome VARCHAR(25) NOT NULL,
Cognome VARCHAR(30) NOT NULL,
AnnoDiNascita INT NULL,
RegioneResidenza VARCHAR(20) NULL
);

CREATE TABLE Prodotti(
IdProdotto BIGSERIAL NOT NULL PRIMARY KEY,
Descrizione VARCHAR(100) NOT NULL,
InProduzione BOOLEAN NOT NULL,
InCommercio BOOLEAN NOT NULL,
DataAttivazione DATE NOT NULL,
DataDisattivazione DATE NOT NULL
);

CREATE TABLE Fornitore(
NumeroFornitore BIGSERIAL NOT NULL PRIMARY KEY ,
Denominazione VARCHAR(25) NOT NULL,
RegioneResidenza VARCHAR(20)  NOT NULL
);

CREATE TABLE Fatture (
    NumeroFattura BIGSERIAL NOT NULL PRIMARY KEY,
    Tipologia VARCHAR(25) NOT NULL,
    Importo NUMERIC(10, 2) NOT NULL,
    Iva INT NOT NULL,
    IdCliente BIGINT NOT NULL REFERENCES Clienti(NumeroCliente),
    DataFattura DATE NOT NULL,
    NumeroFornitore BIGINT NOT NULL REFERENCES Fornitore(NumeroFornitore)
);

INSERT INTO Clienti (Nome, Cognome, AnnoDiNascita, RegioneResidenza) 
VALUES ('Marco', 'Esposito', 1983, 'Campania'),
    ('Sara', 'Russo', 1995, 'Toscana');

INSERT INTO Prodotti (Descrizione, InProduzione, InCommercio, DataAttivazione, DataDisattivazione)
VALUES
    ('Smartphone X100', TRUE, TRUE, '2022-01-01', '2025-12-31'),
    ('Laptop Pro 15', TRUE, TRUE, '2021-05-15', '2026-05-15'),
    ('Tablet Mini', TRUE, FALSE, '2020-09-10', '2023-12-31'),
    ('Monitor UltraHD', FALSE, TRUE, '2023-03-01', '2028-03-01'),
    ('Cuffie Wireless Z', TRUE, TRUE, '2024-06-01', '2030-06-01'),
    ('Mouse Ergonomico', FALSE, FALSE, '2019-02-01', '2022-02-01');

INSERT INTO Fornitore (Denominazione, RegioneResidenza) 
VALUES
    ('TechItalia', 'Lombardia'),
    ('HardwareSolutions', 'Lazio'),
    ('Digital World', 'Piemonte'),
    ('SmartTech', 'Toscana'),
    ('Forniture Plus', 'Campania');
	
INSERT INTO Fatture (Tipologia, Importo, Iva, IdCliente, DataFattura, NumeroFornitore) 
VALUES
    ('Acquisto', 250.75, 22, 1, '2025-01-01', 1),
    ('Vendita', 1800.00, 22, 2, '2025-01-05', 2),
    ('Acquisto', 750.50, 10, 3, '2025-01-10', 3),
    ('Servizio', 1200.00, 22, 4, '2025-01-15', 4),
    ('Acquisto', 450.00, 22, 5, '2025-01-20', 5);

INSERT INTO Clienti (Nome, Cognome, AnnoDiNascita, RegioneResidenza)
VALUES
		('Luca', 'Rossini', 1982, 'Lazio'),
		('Antonio', 'Gialli', 1982, 'Umbria');

INSERT INTO public.Prodotti (Descrizione, InProduzione, InCommercio, DataAttivazione, DataDisattivazione)
VALUES 
  ('Prodotto C', FALSE, FALSE, '2020-07-01', '2022-07-01');

-- Esercizio 1
SELECT * FROM public.Clienti WHERE nome = 'Mario';
-- Esercizio 2
SELECT nome, cognome FROM public.Clienti WHERE AnnoDiNascita = 1982;
-- Esercizio 3
SELECT count(*) AS numero_fatture_iva22 FROM public.Fatture WHERE iva = 22;
-- Esercizio 4
SELECT * FROM public.Prodotti WHERE EXTRACT(YEAR FROM DataAttivazione) = 2020
	AND (InProduzione = TRUE OR InCommercio = TRUE);
-- Esercizio 5
SELECT * FROM public.Fatture 
	INNER JOIN public.Clienti ON Fatture.IdCliente = Clienti.NumeroCliente
	WHERE Fatture.importo < 1000;
-- Esercizio 6
SELECT * FROM public.Fatture 
	INNER JOIN public.Fornitore ON Fatture.NumeroFornitore = Fornitore.NumeroFornitore;
-- Esercizio 7
SELECT count(*) AS NumeroFatture, EXTRACT(YEAR FROM Fatture.DataFattura) AS Anno
FROM public.Fatture WHERE iva = 22 GROUP BY EXTRACT(YEAR FROM DataFattura); 
-- Esercizio 8
SELECT count(*) AS NumeroFatture, sum(Importo) AS SommaImporto, 
	EXTRACT(YEAR FROM DataFattura) FROM public.Fatture
	GROUP BY EXTRACT(YEAR FROM DataFattura);