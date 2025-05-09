-- This script creates a triggers for the Grants table

-- Trigger handles the following events:
-- 1. Insert: Before a new grant is added.
-- 2. Update: Before an existing grant is updated.
-- 3. Delete: Before a grant is deleted.
-- The trigger logs the actions performed on the Grants table.
CREATE OR REPLACE TRIGGER grants_trigger
BEFORE INSERT OR UPDATE OR DELETE ON Grants
FOR EACH ROW
BEGIN
  -- On insert event
  IF INSERTING THEN
    DBMS_OUTPUT.PUT_LINE('Attempting to insert a new GRANT: ' || :NEW.grant_id);
  
  -- On update event
  ELSIF UPDATING THEN
    DBMS_OUTPUT.PUT_LINE('Attempting to update GRANT with id: ' || :OLD.grant_id);

  -- On delete event
  ELSIF DELETING THEN
    DBMS_OUTPUT.PUT_LINE('Attempting to delete GRANT with id: ' || :OLD.grant_id);
  END IF;
END;

-- Trigger handles the following events:
-- 1. Insert: Before a new grant is added.
-- 2. Update: Before an existing grant is updated.
-- 3. Delete: Before a grant is deleted.
-- The trigger adds logs into grants_log.
CREATE OR REPLACE TRIGGER grants_trigger_after
AFTER INSERT OR UPDATE OR DELETE ON Grants
FOR EACH ROW
DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  -- On insert event
  IF INSERTING THEN
    INSERT INTO grants_log (action, grant_id)
    VALUES ('INSERT', :NEW.grant_id);

  -- On update event
  ELSIF UPDATING THEN
    INSERT INTO grants_log (action, grant_id)
    VALUES ('UPDATE', :OLD.grant_id);

  -- On delete event
  ELSIF DELETING THEN
    INSERT INTO grants_log (action, grant_id)
    VALUES ('DELETE', :OLD.grant_id);
  END IF;

  COMMIT;
END;