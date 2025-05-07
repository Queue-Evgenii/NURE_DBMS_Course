-- Find the number of active grants for each manager

-- Function to get the number of active grants for a given manager
CREATE OR REPLACE FUNCTION GET_ACTIVE_GRANT_COUNT(
    p_manager_id IN Managers.manager_id%TYPE
) RETURN NUMBER
IS
    v_count NUMBER := 0;

    CURSOR cur IS
        SELECT *
        FROM Grants;

    grant_record cur%ROWTYPE;
BEGIN
    OPEN cur;
    LOOP
        FETCH cur INTO grant_record;
        EXIT WHEN cur%NOTFOUND;

        IF grant_record.manager_id = p_manager_id THEN
            IF SYSDATE BETWEEN grant_record.start_date AND grant_record.end_date THEN
                v_count := v_count + 1;
            END IF;
        END IF;
    END LOOP;

    CLOSE cur;
    RETURN v_count;
END;

-- Example usage of the function
SELECT manager_id, first_name, last_name, GET_ACTIVE_GRANT_COUNT(manager_id) as active_grants
FROM Managers;