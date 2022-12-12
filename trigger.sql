-- zad 1
alter TRIGGER PreventEmpNameChange
ON EMP
FOR DELETE
AS
BEGIN
    rollback
END
    SELECT * FROM EMP;
    DELETE FROM EMP WHERE ENAME = 'MILLER';
    INSERT INTO EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO) VALUES(7901, 'MILLER', 'CLERK', 7982, 1981-06-23, 2300,NULL, 20);

-- zad 2
alter TRIGGER PreventEmpNameChange
ON EMP
FOR DELETE
AS
BEGIN
    IF EXISTS(SELECT 1 FROM inserted WHERE COMM IS NULL)
        BEGIN
            UPDATE EMP
            SET COMM = 0
            WHERE EMPNO = (SELECT EMPNO FROM inserted)
        end
    rollback
END

-- zad 3

alter TRIGGER PreventEmpNameChange
ON EMP
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS(SELECT 1 FROM inserted WHERE SAL < 1000)
        BEGIN
            THROW 50001, 'Niedopuszczalna wartosc', 2;
        end
END

-- zad 4

CREATE TABLE budzet (wartosc INT NOT NULL)
INSERT INTO budzet (wartosc)
SELECT SUM(sal) FROM emp

alter TRIGGER PreventEmpNameChange
ON EMP
FOR INSERT, UPDATE, DELETE
AS
BEGIN
    UPDATE budzet SET wartosc = (SELECT SUM(SAL) FROM EMP);
END

UPDATE EMP SET SAL = 1000 WHERE ENAME = 'SMITH'

-- zad 5

alter TRIGGER PreventEmpNameChange
ON DEPT
FOR UPDATE
AS
BEGIN
    DECLARE @previous VARCHAR(20) = (SELECT DNAME FROM inserted);
    DECLARE @current VARCHAR(20) = (SELECT DNAME FROM deleted);

    IF @previous = @current
        BEGIN
            THROW 50002, 'niedopuszczalna wartosc', 2;
        end
END

-- zad 6
    alter TRIGGER PreventEmpNameChange
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

-- zad 7

alter TRIGGER PreventEmpNameChange
ON EMP
FOR UPDATE, DELETE
AS
BEGIN
    DECLARE @previous INTEGER = (SELECT SAL FROM inserted);
    DECLARE @current INTEGER = (SELECT SAL FROM deleted);

    IF @previous < @current
        BEGIN
            ROLLBACK
        end

    IF EXISTS(SELECT 1 FROM deleted) AND NOT EXISTS(SELECT 1 FROM inserted)
        BEGIN
            ROLLBACK
        end
END