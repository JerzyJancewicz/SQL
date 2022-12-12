DECLARE @ILE INT =(SELECT COUNT(*) FROM EMP)
PRINT 'W tabeli jest ' + CAST(@ILE AS VARCHAR) + ' OSOB';
--2
DECLARE @INFO VARCHAR(50);
IF @ILE < 16
    BEGIN
        INSERT INTO EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
        VALUES (15,'KOWALSKI','CLERK',7902,SYSDATETIME(),800,NULL,20);
        SET @INFO = 'WSTAWIONO KOWALSKIEGO';
    end
ELSE
    SET @INFO = 'NIE WSTAWIONO DANYCH';
PRINT @INFO;

--3
CREATE PROCEDURE return_higher_than @val INT
AS
BEGIN
SELECT * FROM EMP
WHERE SAL>@VAL
END;
EXEC return_higher_than 1100;
--4
CREATE PROCEDURE add_dept
    @nr_dzialu INT, @nazwa varchar(50),@lokalizacja varchar(50)
AS
    BEGIN
        if exists(SELECT * from DEPT where DNAME = @nazwa OR LOC = @lokalizacja)
        print ('Podany dzial istnieje')
        else
            INSERT INTO DEPT(DEPTNO, DNAME, LOC)
            VALUES (@nr_dzialu,@nazwa,@lokalizacja)
    end;
EXEC add_dept 50,'IT','WARSAW';

--5
CREATE PROCEDURE add_emp
    @nazwisko varchar(50),@nr_dzialu INT
AS
    BEGIN
        DECLARE @min_sal INT = (SELECT MIN(SAL) FROM EMP WHERE DEPTNO = @nr_dzialu)
        DECLARE @NR_PRAC INT = (SELECT MAX(EMPNO) FROM EMP)+1
        IF NOT exists(SELECT * FROM DEPT WHERE DEPTNO = @nr_dzialu)
            print ('Podany dzial nie istnieje')
        ELSE
            INSERT INTO EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
            VALUES (@NR_PRAC,@nazwisko,'ZAD5','555',SYSDATETIME(),@min_sal,NULL,@nr_dzialu)
            print ('Minimalna pensja wynosi ' + cast(@min_sal AS VARCHAR))
    end;
EXEC ADD_EMP 'SERAFINSKI',50;