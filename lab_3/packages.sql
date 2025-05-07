CREATE OR REPLACE PACKAGE GRANT_PACKAGE IS
    FUNCTION GET_ACTIVE_GRANT_COUNT(p_manager_id IN Managers.manager_id%TYPE)
    RETURN NUMBER;

    PROCEDURE LIST_RECENT_GRANTS;
END GRANT_PACKAGE;

CREATE OR REPLACE PACKAGE BODY GRANT_PACKAGE IS
  FUNCTION GET_ACTIVE_GRANT_COUNT(
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

  PROCEDURE LIST_RECENT_GRANTS IS
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
END grant_package;


EXEC GRANT_PACKAGE.LIST_RECENT_GRANTS;
SELECT manager_id, first_name, last_name, GRANT_PACKAGE.GET_ACTIVE_GRANT_COUNT(manager_id) as active_grants
FROM Managers;