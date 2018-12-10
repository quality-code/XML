CREATE TABLE Maestras
(
	Id INT IDENTITY PRIMARY KEY,
	Nombre VARCHAR(50),
	Estructura XML
)

-- INSERT INICIAL
INSERT Maestras (Nombre,Estructura) VALUES ('Tipo Documento','<TiposDoc />')
INSERT Maestras (Nombre,Estructura) VALUES ('Paises','<Paises />')
INSERT Maestras (Nombre,Estructura) VALUES ('Ciudades','<Ciudades />')

-- INSERT
DECLARE @Codigo INT,@Nombre VARCHAR(50)
SET @Codigo = 5
SET @Nombre = 'Pasaporte'
UPDATE Maestras
SET Estructura.modify('insert 
	<TipoDoc>
		<Codigo>{sql:variable("@Codigo")}</Codigo>
		<Nombre>{sql:variable("@Nombre")}</Nombre></TipoDoc>
	into
	(/TiposDoc)[1]')
WHERE Nombre = 'Tipo Documento'

-- UPDATE
DECLARE @Codigo INT,@Nombre VARCHAR(50)
SET @Codigo = 4
SET @Nombre = 'CE'

UPDATE Maestras
SET Estructura.modify('replace value of
	(/TiposDoc/TipoDoc[Codigo=(sql:variable("@Codigo"))]/Nombre/text())[1]
	with
	(sql:variable("@Nombre"))')
WHERE Nombre = 'Tipo Documento'

-- DELETE
DECLARE @Codigo INT
SET @Codigo = 4
UPDATE Maestras
SET Estructura.modify('delete
	(/TiposDoc/TipoDoc[Codigo=(sql:variable("@Codigo"))])[1]')
WHERE Nombre = 'Tipo Documento'

SELECT * FROM Maestras
