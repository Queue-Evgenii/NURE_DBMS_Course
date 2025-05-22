CREATE OR REPLACE TRIGGER trg_grants_before_ins_upd
BEFORE INSERT OR UPDATE ON Grants
FOR EACH ROW
BEGIN
  IF :NEW.start_date >= :NEW.end_date THEN
    RAISE_APPLICATION_ERROR(-20001, 'Дата початку має бути меншою за дату завершення.');
  END IF;

  IF :NEW.funding_amount < 100000 THEN
    RAISE_APPLICATION_ERROR(-20002, 'Сума фінансування повинна бути не менше 100000.');
  END IF;

  DECLARE
    grant_prefix VARCHAR2(2);
    year_suffix VARCHAR2(2);
  BEGIN
    grant_prefix := SUBSTR(:NEW.grant_id, 1, 2);
    year_suffix := TO_CHAR(:NEW.start_date, 'YY');

    IF grant_prefix != year_suffix THEN
      RAISE_APPLICATION_ERROR(-20003, 'Перші дві цифри ID гранту повинні відповідати останнім цифрам року початку.');
    END IF;
  END;

END;


CREATE OR REPLACE TRIGGER trg_participants_after_update
AFTER UPDATE ON Participants
FOR EACH ROW
BEGIN
  IF :OLD.birth_date != :NEW.birth_date THEN
    RAISE_APPLICATION_ERROR(-20004, 'Зміна дати народження заборонена.');
  END IF;

  IF :OLD.first_name != :NEW.first_name OR
     :OLD.last_name  != :NEW.last_name THEN
    INSERT INTO Authors_Archive (participant_id, first_name, last_name, birth_date)
    VALUES (:OLD.participant_id, :OLD.first_name, :OLD.last_name, :OLD.birth_date);
  END IF;
END;
