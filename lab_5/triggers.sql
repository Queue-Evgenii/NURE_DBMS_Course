-- This INSTEAD OF INSERT trigger enables insert operations on the Grant_Details_View,
-- which is a view that likely combines data from the Grants, Managers, Participants,
-- and Grants_Participants tables. When a new row is inserted into the view, the trigger
-- performs the following actions
CREATE OR REPLACE TRIGGER trg_insert_grant_details
INSTEAD OF INSERT ON Grant_Details_View
FOR EACH ROW
DECLARE
    v_manager_id NUMBER;
    v_participant_id NUMBER;
BEGIN
    SELECT manager_id INTO v_manager_id
    FROM Managers
    WHERE first_name || ' ' || last_name = :NEW.manager_name;

    SELECT participant_id INTO v_participant_id
    FROM Participants
    WHERE first_name || ' ' || last_name = :NEW.participant_name;

    INSERT INTO Grants (grant_id, start_date, end_date, funding_amount, scientific_field, manager_id)
    VALUES (:NEW.grant_id, :NEW.start_date, :NEW.end_date, :NEW.funding_amount, :NEW.scientific_field, v_manager_id);

    INSERT INTO Grants_Participants (grant_id, participant_id, role)
    VALUES (:NEW.grant_id, v_participant_id, :NEW.participant_role);
END;
