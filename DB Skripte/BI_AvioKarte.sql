USE master
GO

DROP DATABASE AvioKompanija_Karte
go
ALTER AUTHORIZATION ON DATABASE::AvioKompanija_Karte TO [sa];

CREATE DATABASE AvioKompanija_Karte
GO

USE AvioKompanija_Karte
GO

--INSERT INTO Klasa (Naziv, BrojKarata, TrenutnoProdato)
--  VALUES (N'BK', 5, DEFAULT);

CREATE TABLE Drzava(
DrzavaID int IDENTITY CONSTRAINT PK_Drzava PRIMARY KEY,
Naziv NVARCHAR(50) NOT NULL
)
CREATE TABLE Grad(
GradID int IDENTITY CONSTRAINT PK_Grad PRIMARY KEY,
Naziv NVARCHAR(50) NOT NULL,
DrzavaID int NOT NULL CONSTRAINT FK_Grad_Drzava FOREIGN KEY REFERENCES Drzava(DrzavaID)
)

CREATE TABLE AvioKompanija(
AvioKompanijaID int IDENTITY CONSTRAINT PK_AvioKompanija PRIMARY KEY,
Naziv NVARCHAR(50) NOT NULL,
GradID INT NOT NULL CONSTRAINT FK_AvioKompanija_Grad FOREIGN KEY REFERENCES Grad(GradID)
)
CREATE TABLE Tip(
TipID INT IDENTITY CONSTRAINT PK_Tip PRIMARY KEY,
Velicina NVARCHAR(15) NOT NULL, --mali srednji veliki
)
CREATE TABLE Avion(
AvionID INT IDENTITY CONSTRAINT PK_Avion PRIMARY KEY,
Naziv NVARCHAR(50) NOT NULL,
Registracija NVARCHAR(50) NOT NULL,
TipID INT NOT NULL CONSTRAINT FK_Avion_Tip FOREIGN KEY REFERENCES Tip(TipID)
)
--CREATE TABLE Avioni(
--AvioniID INT IDENTITY CONSTRAINT PK_Avioni PRIMARY KEY,
--AvioKompanijaID INT NOT NULL CONSTRAINT FK_Avioni_AvioKompanija FOREIGN KEY REFERENCES AvioKompanija(AvioKompanijaID),
--AvionID INT NOT NULL CONSTRAINT FK_Avioni_Avion FOREIGN KEY REFERENCES Avion(AvionID)
--)

CREATE TABLE Aerodrom(
AerodromID int IDENTITY CONSTRAINT PK_Aerodrom PRIMARY KEY,
Naziv NVARCHAR(50) NOT NULL,
GradID int NOT NULL CONSTRAINT FK_Aerodrom_Grad FOREIGN KEY REFERENCES Grad(GradID)
)

CREATE TABLE Linija(
LinijaID int IDENTITY CONSTRAINT PK_Linija PRIMARY KEY,
DatumVrijeme_Polaska datetime NOT NULL,
DatumVrijeme_Dolaska datetime NOT NULL,
Polaziste_AerodromID int NOT NULL CONSTRAINT FK_Linija_AerodromPolaziste FOREIGN KEY REFERENCES Aerodrom(AerodromID),
Destinacija_AerodromID int NOT NULL CONSTRAINT FK_Linija_AerodromDestinacija FOREIGN KEY REFERENCES Aerodrom(AerodromID)
)

CREATE TABLE Klasa(
KlasaID int IDENTITY CONSTRAINT PK_Klasa PRIMARY KEY,
Naziv NVARCHAR(50) NOT NULL,
BrojKarata int NOT NULL
)



--CREATE TABLE Zaposlenik(
--ZaposlenikID int IDENTITY CONSTRAINT PK_Zaposlenik PRIMARY KEY,
--Ime NVARCHAR(20) NOT NULL,
--Prezime NVARCHAR(25) NOT NULL,
--JMBG NVARCHAR(20) NOT NULL,
--GradID int NOT NULL CONSTRAINT FK_Zaposlenik_Grad FOREIGN KEY REFERENCES Grad(GradID),
--Adresa NVARCHAR(30) NOT NULL
--)

CREATE TABLE Putnik(
PutnikID int IDENTITY CONSTRAINT PK_Putnik PRIMARY KEY,
Ime NVARCHAR(20) NOT NULL,
Prezime NVARCHAR(25) NOT NULL,
Spol NVARCHAR(1) NOT NULL,
Pasos_Broj NVARCHAR(20) NOT NULL,
GradID int NOT NULL CONSTRAINT FK_Putnik_Grad FOREIGN KEY REFERENCES Grad(GradID)
)

CREATE TABLE Karta(
KartaID int IDENTITY CONSTRAINT PK_Karta PRIMARY KEY,
DatumVrijeme_Kupovina datetime NOT NULL,
Iznos int NOT NULL,
PutnikID int NOT NULL CONSTRAINT FK_Karta_Putnik FOREIGN KEY REFERENCES Putnik(PutnikID),
KlasaID int NOT NULL CONSTRAINT FK_Karta_Klasa FOREIGN KEY REFERENCES Klasa(KlasaID),
LinijaID int NOT NULL CONSTRAINT FK_Cijena_Linija FOREIGN KEY REFERENCES Linija(LinijaID),
AvionID int NOT NULL CONSTRAINT FK_Karta_Avion FOREIGN KEY REFERENCES Avion(AvionID),
AvioKompanijaID int NOT NULL CONSTRAINT FK_Karta_AvioKompanija FOREIGN KEY REFERENCES AvioKompanija(AvioKompanijaID)
)

use AvioKompanija_Karte

select K.AvionID,K.DatumVrijeme_Kupovina,K.Iznos,K.KartaID,K.KlasaID,K.LinijaID,K.PutnikID,
K.AvioKompanijaID as AvioKompanijaID,L.Destinacija_AerodromID as PolazisteDestinacijaID,
 L.Polaziste_AerodromID as PolazisteAerodromID, P.GradID
from Karta as K JOIN Linija as L
on K.LinijaID=L.LinijaID join Putnik as P
on K.PutnikID=P.PutnikID


SELECT DatumVrijeme_Kupovina, DAY(DatumVrijeme_Kupovina) AS Dan, MONTH(DatumVrijeme_Kupovina) as Mjesec, YEAR(DatumVrijeme_Kupovina) as Godina, 
CASE WHEN MONTH(DatumVrijeme_Kupovina) IN (1,2,3) THEN 1 
WHEN  MONTH(DatumVrijeme_Kupovina) IN (4,5,6) THEN 2
WHEN MONTH(DatumVrijeme_Kupovina) IN (7,8,9) THEN 3
WHEN MONTH (DatumVrijeme_Kupovina) IN (10,11,12) THEN 4 
END as Kvartal
FROM Karta

--SELECT A.AvionID,A.Naziv,A.Registracija, T.Velicina
--FROM Avion as A JOIN Tip as T
--ON A.TipID=T.TipID
use AvioKompanija_Karte
select distinct * from Grad