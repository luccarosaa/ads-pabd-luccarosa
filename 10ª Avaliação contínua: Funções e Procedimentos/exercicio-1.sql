/*
Questão 01. Crie um procedimento denominado salaryHistogram, que distribua as frequências 
dos salários dos Professores em intervalos (Histograma).

O número de intervalos será calculado de acordo com o parâmetro de entrada do procedimento. 
Exemplo: EXEC dbo.salaryHistogram 5;
*/

CREATE PROCEDURE dbo.salaryHistogram
    @num_intervals INT
AS
BEGIN
    SET NOCOUNT ON;
    
    /* BLOQUEAR se for NULL */
    IF @num_intervals IS NULL
    BEGIN
        RAISERROR('ERRO: O número de intervalos é obrigatório. Informe um valor maior que 0.', 16, 1);
        RETURN;
    END
    
    /* Validar se é maior que 0 */
    IF @num_intervals <= 0
    BEGIN
        RAISERROR('ERRO: O número de intervalos deve ser maior que 0.', 16, 1);
        RETURN;
    END
    
    /* Verificar se existem professores */
    IF NOT EXISTS (SELECT 1 FROM dbo.instructor)
    BEGIN
        PRINT 'ATENÇÃO: Nenhum professor encontrado na tabela instructor.';
        RETURN;
    END
    
    
    DECLARE @min_salary NUMERIC(10,2);
    DECLARE @max_salary NUMERIC(10,2);
    DECLARE @total_professors INT;
    DECLARE @interval_size NUMERIC(10,2);
    
    SELECT 
        @min_salary = MIN(salary),
        @max_salary = MAX(salary),
        @total_professors = COUNT(*)
    FROM dbo.instructor;
    
    SET @interval_size = (@max_salary - @min_salary) / @num_intervals;
    
    SELECT 
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS classe,
        CAST(@min_salary + ((n-1) * @interval_size) AS INT) AS valorMinimo,
        CAST(CASE 
            WHEN n = @num_intervals THEN @max_salary
            ELSE @min_salary + (n * @interval_size) - 1
        END AS INT) AS valorMaximo,
        COUNT(i.salary) AS total
    FROM (
        SELECT TOP (@num_intervals) 
            ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
        FROM sys.objects a
        CROSS JOIN sys.objects b 
    ) AS classes
    LEFT JOIN dbo.instructor i ON i.salary >= @min_salary + ((n-1) * @interval_size)
        AND i.salary <= CASE 
            WHEN n = @num_intervals THEN @max_salary
            ELSE @min_salary + (n * @interval_size) - 1
        END
    GROUP BY n
    ORDER BY n;
END


/* Testando se deu certo */
EXEC dbo.salaryHistogram 8;
EXEC dbo.salaryHistogram 4;
EXEC dbo.salaryHistogram NULL;
EXEC dbo.salaryHistogram -3;
EXEC dbo.salaryHistogram 0;
