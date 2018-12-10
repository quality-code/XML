DECLARE @xmlData XML

SELECT @xmlData = Estructura FROM Maestras
WHERE Nombre = 'Tipo Documento'
/*
SELECT 
	d.value('.','VARCHAR(50)')
FROM @xmlData.nodes('/TiposDoc/TipoDoc')t(d)
*/
SELECT 
	Codigo = d.value('(Codigo)[1]','INT'),
	Nombre = d.value('(Nombre)[1]','VARCHAR(50)'),
	Personas = d.query('Personas')
FROM @xmlData.nodes('/TiposDoc/TipoDoc')t(d)
--WHERE d.value('(Nombre)[1]','VARCHAR(50)') Like '%Cedula%'
ORDER BY 1

