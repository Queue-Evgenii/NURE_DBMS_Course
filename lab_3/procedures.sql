-- Find all grants that have been completed in the last 12 months

-- Procedure definition
CREATE OR REPLACE PROCEDURE LIST_RECENT_GRANTS IS
    CURSOR cur IS
        SELECT 
            g.grant_id,
            g.scientific_field,
            g.end_date,
            m.first_name || ' ' || m.last_name AS manager_name
        FROM Grants g
        JOIN Managers m ON g.manager_id = m.manager_id;

    v_grant_id       Grants.grant_id%TYPE;
    v_field          Grants.scientific_field%TYPE;
    v_end_date       Grants.end_date%TYPE;
    v_manager_name   VARCHAR2(100);
BEGIN
    OPEN cur;

    LOOP
        FETCH cur INTO v_grant_id, v_field, v_end_date, v_manager_name;
        EXIT WHEN cur%NOTFOUND;

        IF v_end_date BETWEEN ADD_MONTHS(SYSDATE, -12) AND SYSDATE
          THEN DBMS_OUTPUT.PUT_LINE(
            'Грант: ' || v_grant_id || 
            ', Галузь: ' || v_field || 
            ', Завершено: ' || TO_CHAR(v_end_date, 'YYYY-MM-DD') || 
          ', Менеджер: ' || v_manager_name
          );
        END IF;
    END LOOP;

    CLOSE cur;
END;

-- Procedure call
EXEC LIST_RECENT_GRANTS;