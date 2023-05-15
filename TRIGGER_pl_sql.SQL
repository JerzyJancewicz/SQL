-- WYZWALACZE

-- ZAD1
/*
CREATE OR REPLACE TRIGGER testTriger
BEFORE DELETE
ON EMP
BEGIN
     RAISE_APPLICATION_ERROR(-20001, 'Nie mozna usuwac rekordow z tabeli EMP');
end;
SAVEPOINT SAVE1;
SELECT * FROM EMP;
--DELETE FROM EMP;
ROLLBACK TO SAVEPOINT SAVE1;
*/

-- ZAD2

/*CREATE OR REPLACE TRIGGER triggerZad2
AFTER INSERT OR UPDATE
ON EMP
FOR EACH ROW
    BEGIN
        IF :NEW.SAL < 1000 THEN
            RAISE_APPLICATION_ERROR(-20001,'Pensja nie moze byc wieksza niz 1000');
        end if;
    end;*/

-- ZAD3

/*CREATE TABLE budzet (wartosc INT NOT NULL);
INSERT INTO budzet (wartosc) SELECT SUM(sal) FROM emp;
SELECT * FROM BUDZET;*/
/*

CREATE OR REPLACE TRIGGER triggerZad3
AFTER INSERT OR UPDATE OR DELETE
ON EMP
    BEGIN
        UPDATE BUDZET
        SET WARTOSC = (SELECT SUM(SAL) FROM EMP);
    end;

UPDATE EMP SET SAL = 5000 WHERE EMPNO = 7521;
*/

-- ZAD4
/*

CREATE OR REPLACE TRIGGER triggerZad4
AFTER DELETE OR UPDATE OR INSERT
ON EMP
    FOR EACH ROW
        BEGIN
            IF DELETING THEN
                IF :OLD.SAL > 0 THEN
                    RAISE_APPLICATION_ERROR(-20001, 'Nie mozna usunac pracownika ktora ma sal > 0');
                end if;
            end if;
            IF UPDATING THEN
                IF :OLD.ENAME != :NEW.ENAME THEN
                    RAISE_APPLICATION_ERROR(-20001, 'Nie mozna zmienic nazwiska');
                end if;
            end if;

            IF INSERTING THEN
                IF :OLD.ENAME = :NEW.ENAME THEN
                    RAISE_APPLICATION_ERROR(-20001, 'Pracownik juz istnieje');
                end if;
            end if;
        end;
*/

-- ZAD5
/*
CREATE OR REPLACE TRIGGER triggerZad5
AFTER UPDATE OR DELETE
ON EMP
    FOR EACH ROW
    BEGIN
        IF UPDATING THEN
            IF :NEW.SAL < :OLD.SAL THEN
                RAISE_APPLICATION_ERROR(-20001, 'Nie mozna zmniejszyc pensji');
            end if;
        end if;
        IF DELETING THEN
            RAISE_APPLICATION_ERROR(-20001, 'Nie mozna usuwac pracownikow');
        end if;
    end;
*/
