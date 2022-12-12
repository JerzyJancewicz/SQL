
-- KURSOR
-- CREATE DO DODANIA
-- ALTER DO UPDATOWANIA

/*-- zad 1, 2
ALTER PROCEDURE ProceduraZKursorem
AS
    BEGIN
        DECLARE NazwaCursora2 CURSOR FOR
    SELECT EMPNO, SAL
    FROM EMP
OPEN NazwaCursora2;
DECLARE @empno INT, @sal INT, @low INT, @high INT

FETCH NEXT FROM NazwaCursora2 INTO @empno, @sal
WHILE @@FETCH_STATUS = 0
    BEGIN
        IF @sal < @low
            BEGIN
                UPDATE EMP SET SAL = SAL + SAL*0.1;
            end
        IF @sal > @high
            BEGIN
                UPDATE EMP SET SAL = SAL - SAL*0.1;
            end
        PRINT CAST(@empno AS VARCHAR) + 'zarabia ' + CAST(@sal AS VARCHAR);
        FETCH NEXT FROM NazwaCursora2 INTO @empno, @sal
    END;

CLOSE NazwaCursora2;
DEALLOCATE NazwaCursora2;
END;

EXEC  ProceduraZKursorem;*/

-- zad3

/*ALTER PROCEDURE ProceduraZKursorem
AS
    BEGIN
        DECLARE NazwaCursora2 CURSOR FOR
    SELECT EMPNO, SAL, DEPTNO
    FROM EMP
OPEN NazwaCursora2;
DECLARE @empno INT, @sal INT, @name INT

FETCH NEXT FROM NazwaCursora2 INTO @empno, @sal, @name;
DECLARE @COUNT Int = (SELECT COUNT(*) FROM EMP), @sum INT;
WHILE @@FETCH_STATUS = 0
    BEGIN
        IF EXISTS (SELECT DEPTNO FROM DEPT WHERE DNAME = @name)
            BEGIN
                set @sum = @sum + @sal
            END;
        FETCH NEXT FROM NazwaCursora2 INTO @empno, @sal
    END;
PRINT 'srednia ' + CAST((@sum/@COUNT) AS VARCHAR);
CLOSE NazwaCursora2;
DEALLOCATE NazwaCursora2;
END;

EXEC  ProceduraZKursorem;*/

-- ZAD 4
/*
CREATE TABLE Magazyn (IdPozycji INT, Nazwa VARCHAR(200), Ilosc INT);

    INSERT INTO Magazyn VALUES (1, 'magazyn1', 20);
    INSERT INTO Magazyn VALUES (2, 'magazyn2', 200);
    INSERT INTO Magazyn VALUES (3, 'magazyn3', 5);
    INSERT INTO Magazyn VALUES (4, 'magazyn4', 3);
    INSERT INTO Magazyn VALUES (5, 'magazyn5', 26);

ALTER PROCEDURE ProceduraZKursorem
AS
    BEGIN
        DECLARE NazwaCursora2 CURSOR FOR
    SELECT EMPNO, SAL, DEPTNO
    FROM EMP
OPEN NazwaCursora2;
DECLARE @empno INT, @sal INT, @name INT

FETCH NEXT FROM NazwaCursora2 INTO @empno, @sal, @name;
DECLARE @COUNT Int = (SELECT COUNT(*) FROM EMP), @sum INT;
WHILE @@FETCH_STATUS = 0
    BEGIN
        IF EXISTS (SELECT DEPTNO FROM DEPT WHERE DNAME = @name)
            BEGIN
                set @sum = @sum + @sal
            END;
        FETCH NEXT FROM NazwaCursora2 INTO @empno, @sal
    END;
PRINT 'srednia ' + CAST((@sum/@COUNT) AS VARCHAR);
CLOSE NazwaCursora2;
DEALLOCATE NazwaCursora2;
END;

EXEC  ProceduraZKursorem;
*/
-- zad 5
/*
ALTER PROCEDURE ProceduraZKursorem
AS
    BEGIN
        DECLARE NazwaCursora2 CURSOR FOR
    SELECT EMPNO, SAL, DEPTNO
    FROM EMP
OPEN NazwaCursora2;
DECLARE @empno INT, @sal INT, @name INT

FETCH NEXT FROM NazwaCursora2 INTO @empno, @sal, @name;
DECLARE @COUNT Int = (SELECT COUNT(*) FROM EMP), @sum INT;
WHILE @@FETCH_STATUS = 0
    BEGIN
        IF EXISTS (SELECT DEPTNO FROM DEPT WHERE DNAME = @name)
            BEGIN
                set @sum = @sum + @sal
            END;
        FETCH NEXT FROM NazwaCursora2 INTO @empno, @sal
    END;
PRINT 'srednia ' + CAST((@sum/@COUNT) AS VARCHAR);
CLOSE NazwaCursora2;
DEALLOCATE NazwaCursora2;
END;

EXEC  ProceduraZKursorem;

*/