/*
KURSOR!!!!!!!!!!!!!!!!!!!!!!!

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

/*
TRIGGER!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

create TRIGGER PreventEmpNameChange
ON EMP
FOR DELETE, UPDATE, INSERT
AS
BEGIN
        IF EXISTS(SELECT SAL FROM EMP WHERE SAL > 0)
            BEGIN
                ROLLBACK
            end

            -- update jest wtedy kiedy jest insertted i deleted
            -- insert jest tylko jesli inserted
            -- delete jest tylko jesli deleted
        IF EXISTS(SELECT 1 FROM inserted) AND EXISTS(SELECT  1 FROM deleted)
            BEGIN
                ROLLBACK
            end

        DECLARE @previous VARCHAR(20) = (SELECT ENAME FROM inserted);
        DECLARE @current VARCHAR(20) = (SELECT ENAME FROM deleted);

        IF @previous != @current
            BEGIN
                ROLLBACK;
            end
    rollback
END
    SELECT * FROM EMP;
    DELETE FROM EMP WHERE ENAME = 'MILLER';
*/

/*
PROCEDURA!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

ALTER PROCEDURE make_reservation
    @rodzajSamochodu VARCHAR(255), @imie VARCHAR(255), @Nazwisko VARCHAR(255), @dataOd DATE, @dataDo DATE
    AS
    BEGIN
        IF EXISTS(SELECT Nazwa FROM Rodzaj WHERE Nazwa = @rodzajSamochodu)
            BEGIN
                IF EXISTS(SELECT * FROM Klient WHERE Imie = @imie AND Nazwisko = @Nazwisko)
                    BEGIN
                        DECLARE @idRezerwacja INT = (SELECT (MAX(ID)) FROM Rezerwacja) + 1;
                        DECLARE @idKlient INT = (SELECT ID FROM Klient WHERE Imie = @imie AND Nazwisko = @Nazwisko)
                        DECLARE @rodzaj INT = (SELECT MAX(Samochod.ID) FROM Samochod INNER JOIN Rodzaj R3 on R3.ID = Samochod.Rodzaj_ID
                                               WHERE R3.Nazwa = @rodzajSamochodu);

                        INSERT INTO Rezerwacja (ID, DataOd, DataDo, Zaplacona, Klient_ID, Samochod_ID)
                        VALUES (@idRezerwacja, @dataOd, @dataDo, 0, @idKlient, @rodzaj);
                    end
                ELSE
                    BEGIN
                        DECLARE @idKlient2 INT = (SELECT MAX(ID) + 1 FROM Klient)

                        INSERT INTO Klient (ID, Imie, Nazwisko)
                        VALUES (@idKlient2, @imie, @Nazwisko);

                        DECLARE @rodzaj2 INT = (SELECT MAX(Samochod.ID) FROM Samochod INNER JOIN Rodzaj R3 on R3.ID = Samochod.Rodzaj_ID
                                               WHERE R3.Nazwa = @rodzajSamochodu);

                        DECLARE @idRezerwacja2 INT = (SELECT (MAX(ID)) FROM Rezerwacja) + 1;

                        INSERT INTO Rezerwacja (ID, DataOd, DataDo, Zaplacona, Klient_ID, Samochod_ID)
                        VALUES (@idRezerwacja2, @dataOd, @dataDo, 0, @idKlient2, @rodzaj2);
                    END
            end
        ELSE
        BEGIN
            THROW 50001, 'Nie ma danego rodzaju samochodu', 2;
        end
    end

EXEC make_reservation 'SUV', 'ANNA', 'DUPA', '2022-07-01', '2022-07-01';
*/