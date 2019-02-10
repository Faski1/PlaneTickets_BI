USE master
GO

CREATE DATABASE AvioKompanija_KarteDW
GO

USE AvioKompanija_KarteDW
GO

DROP DATABASE AvioKompanija_KarteDW

CREATE TABLE DimKlasa(
KlasaKey int NOT NULL,
Klasa nvarchar(20),
CONSTRAINT [PK_Klasa] PRIMARY KEY CLUSTERED (KlasaKey ASC)
)

CREATE TABLE DimLokacija(
LokacijaKey INT NOT NULL,
Drzava NVARCHAR(50),
Grad NVARCHAR(50),
CONSTRAINT [PK_Lokacija] PRIMARY KEY CLUSTERED (LokacijaKey ASC)
)

CREATE TABLE DimKupac(
KupacId INT NOT NULL,
Ime NVARCHAR(50),
Prezime NVARCHAR(50),
Spol NVARCHAR(1),
BrojPasosa NVARCHAR(30),
CONSTRAINT [PK_Kupac] PRIMARY KEY CLUSTERED (KupacId ASC)
)

--CREATE TABLE DimCijena(
--CijenaId Int NOT NULL IDENTITY (1,1),
--Cijena INT
--CONSTRAINT [PK_Cijena] PRIMARY KEY CLUSTERED (CijenaId ASC)
--)

CREATE TABLE DimVrijeme(
 VrijemeId int NOT NULL IDENTITY (1,1),
 Datum datetime NOT NULL,
 Godina int NOT NULL, 
 Mjesec int NOT NULL,
 Dan int NOT NULL,
 Kvartal int NOT NULL,
 CONSTRAINT [PK_Vrijeme] PRIMARY KEY CLUSTERED (VrijemeId)
)

CREATE TABLE DimAerodrom(
AerodromKey int NOT NULL,
Aerodrom nvarchar(20),
CONSTRAINT [PK_Aerodrom] PRIMARY KEY CLUSTERED (AerodromKey ASC)
)
CREATE TABLE DimKompanija(
KompanijaKey int NOT NULL,
Kompanija nvarchar(50) not null,
CONSTRAINT [PK_Kompanija] PRIMARY KEY CLUSTERED (KompanijaKey ASC)
)

CREATE TABLE DimAvion(
AvionId INT NOT NULL,
Naziv NVARCHAR(20),
Registracija NVARCHAR(15),
Velicina NVARCHAR(10),
CONSTRAINT [PK_Avion] PRIMARY KEY CLUSTERED (AvionId ASC)
)

CREATE TABLE FactKarta(
KartaId INT NOT NULL IDENTITY(1,1),
KlasaKey int,
KupacKey INT,
LokacijaKey INT,
VrijemeKey INT,
PolazakAerodromKey int,
DolazakAerodromKey int,
KompanijaKey int,
AvionKey INT,
Iznos INT,
CONSTRAINT [PK_Karta] PRIMARY KEY CLUSTERED (KartaId ASC),
CONSTRAINT FK_Karta_Klasa FOREIGN KEY (KlasaKey) REFERENCES dbo.DimKlasa(KlasaKey),
CONSTRAINT FK_Karta_Lokacija FOREIGN KEY (LokacijaKey) REFERENCES dbo.DimLokacija(LokacijaKey),
CONSTRAINT FK_Karta_Kupac FOREIGN KEY (KupacKey) REFERENCES dbo.DimKupac(KupacId),
CONSTRAINT FK_Karta_Vrijeme FOREIGN KEY (VrijemeKey) REFERENCES dbo.DimVrijeme(VrijemeId),
CONSTRAINT FK_Karta_PolazakAerodrom FOREIGN KEY (PolazakAerodromKey) REFERENCES dbo.DimAerodrom(AerodromKey),
CONSTRAINT FK_Karta_DolazakAerodrom FOREIGN KEY (DolazakAerodromKey) REFERENCES dbo.DimAerodrom(AerodromKey),
CONSTRAINT FK_Karta_Kompanija FOREIGN KEY (KompanijaKey) REFERENCES dbo.DimKompanija(KompanijaKey),
CONSTRAINT FK_Karta_Avion FOREIGN KEY (AvionKey) REFERENCES dbo.DimAvion(AvionId)
)
 use AvioKompanija_KarteDW

select * from FactKarta
where LokacijaKey=469



--USE AvioKompanija_Karte




select distinct * FROM FactKarta 