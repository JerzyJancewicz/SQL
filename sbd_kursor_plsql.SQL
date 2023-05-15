-- ZAD 1
/*
DECLARE
    v_empno EMP.EMPNO%TYPE;
    v_sal EMP.SAL%TYPE;
    CURSOR my_cursor IS
    SELECT EMPNO, SAL FROM EMP;
BEGIN
    OPEN my_cursor;
    LOOP
        FETCH my_cursor INTO v_empno, v_sal;
        EXIT WHEN my_cursor%notfound;
            IF (v_sal < 1000) THEN
                UPDATE EMP SET SAL = v_sal + v_sal*0.1
                WHERE EMPNO = v_empno;
            ELSIF (v_sal > 1500) THEN
                UPDATE EMP SET SAL = v_sal - v_sal*0.1
                WHERE EMPNO = v_empno;
            END IF;
        DBMS_OUTPUT.PUT_LINE(v_empno || ' ' ||v_sal);
    end loop;
    close my_cursor;
end;
*/

-- ZAD2
/*
CREATE OR REPLACE PROCEDURE my_procedure(v_min NUMBER, v_max NUMBER)
IS
BEGIN
DECLARE
    v_empno EMP.EMPNO%TYPE;
    v_sal EMP.SAL%TYPE;
    CURSOR my_cursor IS
    SELECT EMPNO, SAL FROM EMP;
BEGIN
    OPEN my_cursor;
    LOOP
        FETCH my_cursor INTO v_empno, v_sal;
        EXIT WHEN my_cursor%notfound;
            IF v_sal < v_min THEN
                UPDATE EMP SET SAL = v_sal + v_sal*0.1
                WHERE EMPNO = v_empno;
            ELSIF v_sal > v_max THEN
                UPDATE EMP SET SAL = v_sal - v_sal*0.1
                WHERE EMPNO = v_empno;
            END IF;
        DBMS_OUTPUT.PUT_LINE(v_empno || ' ' ||v_sal);
    end loop;
    close my_cursor;
end;
end;

    CALL my_procedure(1000, 1500);
*/

-- ZAD 3
/*

CREATE OR REPLACE PROCEDURE my_procedure2(v_deptno INT)
IS
    v_avg NUMBER;
    v_count INT;
BEGIN
DECLARE
    v_empno EMP.EMPNO%TYPE;
    v_sal EMP.SAL%TYPE;
    CURSOR my_cursor IS
    SELECT EMPNO, SAL FROM EMP;
BEGIN
    SELECT AVG(SAL) INTO v_avg FROM EMP WHERE DEPTNO = v_deptno;
    SELECT COUNT(*) INTO v_count FROM EMP WHERE DEPTNO = v_deptno;
    OPEN my_cursor;
    LOOP
        FETCH my_cursor INTO v_empno, v_sal;
        EXIT WHEN my_cursor%notfound;
        BEGIN
        end;
            IF v_count < 0 THEN
                IF v_sal < v_avg THEN
                    UPDATE EMP SET SAL = v_sal + v_sal*0.05
                    WHERE EMPNO = v_empno;
                end if;
            END IF;
        DBMS_OUTPUT.PUT_LINE(v_empno || ' ' ||v_sal);
    end loop;
    close my_cursor;
end;
end;
*/
    CALL my_procedure2(20);

-- ZAD 4
CREATE TABLE MAGAZYN(IdPozycji INT, Nazwa VARCHAR(25), Ilosc INT);
INSERT INTO MAGAZYN(IdPozycji, Nazwa, Ilosc) VALUES (1, 'COS', 100);
INSERT INTO MAGAZYN(IdPozycji, Nazwa, Ilosc) VALUES (1, 'COS1', 3);
INSERT INTO MAGAZYN(IdPozycji, Nazwa, Ilosc) VALUES (1, 'COS2', 50);
INSERT INTO MAGAZYN(IdPozycji, Nazwa, Ilosc) VALUES (1, 'COS3', 20);
INSERT INTO MAGAZYN(IdPozycji, Nazwa, Ilosc) VALUES (1, 'COS4', 200);
INSERT INTO MAGAZYN(IdPozycji, Nazwa, Ilosc) VALUES (1, 'COS5', 300);
INSERT INTO MAGAZYN(IdPozycji, Nazwa, Ilosc) VALUES (1, 'COS6', 3);


DECLARE
    v_id INT;
    v_max NUMBER;
    v_name VARCHAR(25);
BEGIN
    SELECT MAX(ILOSC) INTO v_max FROM MAGAZYN;
    SELECT IDPOZYCJI INTO v_id FROM MAGAZYN WHERE ILOSC = v_max;
    SELECT NAZWA INTO v_name FROM MAGAZYN;

    IF v_max <= 5 THEN
        BEGIN
            RAISE_APPLICATION_ERROR(-20250,'Blad');
        END;
    ELSE
        BEGIN
            UPDATE MAGAZYN SET ILOSC = ILOSC-5 WHERE IDPOZYCJI = v_id;
        END;
    END IF;
END;

-- zad 5
CREATE OR REPLACE PROCEDURE my_procedure4(v_ilosc INT) IS
    v_id INT;
    v_max INT;
BEGIN
    SELECT MAX(ILOSC) INTO v_max FROM MAGAZYN;
    SELECT IDPOZYCJI INTO v_id FROM MAGAZYN WHERE ILOSC = v_max;

    IF v_max <= v_ilosc THEN
        BEGIN
            RAISE_APPLICATION_ERROR(-20250,'Blad');
        END;
    ELSE
        BEGIN
            UPDATE MAGAZYN SET ILOSC = ILOSC-v_ilosc WHERE IDPOZYCJI = v_id;
        END;
    END IF;
END;

CALL my_procedure4();
COMMIT;