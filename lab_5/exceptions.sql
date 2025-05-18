-- Outputs all grants and roles for a participant identified by last name.
CREATE OR REPLACE PROCEDURE Get_Participant_Grants(p_last_name IN VARCHAR2) IS
    v_participant_id Participants.participant_id%TYPE;
    v_grant_id Grants_Participants.grant_id%TYPE;
    v_role Grants_Participants.role%TYPE;
BEGIN
    SELECT participant_id
    INTO v_participant_id
    FROM Participants
    WHERE last_name = p_last_name;

    DBMS_OUTPUT.PUT_LINE(p_last_name || ':');
    FOR rec IN (
        SELECT grant_id, role
        FROM Grants_Participants
        WHERE participant_id = v_participant_id
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Грант: ' || rec.grant_id || ', Роль: ' || rec.role);
    END LOOP;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Учасника з прізвищем "' || p_last_name || '" не знайдено.');
END;

-- Outputs a message indicating whether a participant is involved in a specific grant.
-- Raises an exception if the participant is not found in the grant.
CREATE OR REPLACE PROCEDURE Check_Participant_In_Grant(
    p_grant_id IN Grants.grant_id%TYPE,
    p_participant_id IN Participants.participant_id%TYPE
) IS
    ex_participant_not_found EXCEPTION;

    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM Grants_Participants
    WHERE grant_id = p_grant_id
      AND participant_id = p_participant_id;

    IF v_count = 0 THEN
        RAISE ex_participant_not_found;
    END IF;

    DBMS_OUTPUT.PUT_LINE('Учасник бере участь у гранті.');

EXCEPTION
    WHEN ex_participant_not_found THEN
        DBMS_OUTPUT.PUT_LINE('Учасник не бере участі у вказаному гранті.');
END;


-- Inserts a new grant into the Grants table.
-- Raises an exception if the manager ID does not exist in the Managers table.
CREATE OR REPLACE PROCEDURE Add_Grant_With_Manager(
    p_grant_id IN VARCHAR2,
    p_start_date IN DATE,
    p_end_date IN DATE,
    p_funding_amount IN NUMBER,
    p_scientific_field IN VARCHAR2,
    p_manager_id IN NUMBER
) IS
    invalid_manager EXCEPTION;
    PRAGMA EXCEPTION_INIT(invalid_manager, -2291);
BEGIN
    INSERT INTO Grants(grant_id, start_date, end_date, funding_amount, scientific_field, manager_id)
    VALUES (p_grant_id, p_start_date, p_end_date, p_funding_amount, p_scientific_field, p_manager_id);

    DBMS_OUTPUT.PUT_LINE('Грант успішно додано.');

EXCEPTION
    WHEN invalid_manager THEN
        DBMS_OUTPUT.PUT_LINE('Помилка: Менеджера з таким ID не існує (ORA-02291).');
END;