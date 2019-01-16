DECLARE @RowCount Integer
DECLARE @RowCountSobra Integer
DECLARE @ced_identidad Varchar ( 1000 )
DECLARE @n_item  int
declare @p2 int
set @p2=0

CREATE TABLE dbo.tmp_table ( ced_identidad Varchar ( 1000 ), n_item  int )
CREATE TABLE dbo.tmp_sobra ( ced_identidad Varchar ( 1000 ), n_item  int )

INSERT INTO dbo.tmp_table
SELECT p.per_DocIdentidad as ced_identidad, p.per_Item as n_item  FROM dbo.Supervision s, dbo.Persona p
WHERE p.per_Codigo = s.sup_PersonaSupervisada 

exec del_Supervision @Referencia=824,@ErrorCode=@p2 output
select @p2

SELECT TOP 1 @ced_identidad = ced_identidad
           , @n_item  = n_item
  FROM dbo.tmp_table

SET @RowCount = @@ROWCOUNT

WHILE @RowCount <> 0
  BEGIN

    DELETE FROM dbo.EvaluacionGest20102011
     WHERE ced_identidad = @ced_identidad
       AND n_item  = @n_item
	SET @RowCountSobra = @@ROWCOUNT 
	IF (@RowCountSobra <> 1)
	BEGIN
		INSERT INTO tmp_sobra (ced_identidad, n_item) VALUES (@ced_identidad,@n_item)
	END
	
    DELETE FROM dbo.tmp_table 
     WHERE ced_identidad = @ced_identidad
       AND n_item  = @n_item

    SELECT TOP 1 @ced_identidad = ced_identidad
				, @n_item  = n_item
	FROM dbo.tmp_table
	
    SET @RowCount = @@ROWCOUNT

  END

DROP TABLE dbo.tmp_table
