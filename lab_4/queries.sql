SELECT * FROM grants_log;


INSERT INTO Grants (grant_id, start_date, end_date, funding_amount, scientific_field)
VALUES ('25-01-00001', DATE '2025-01-01', DATE '2024-12-31', 150000, 'Computer Science');

INSERT INTO Grants (grant_id, start_date, end_date, funding_amount, scientific_field)
VALUES ('25-01-00002', DATE '2025-01-01', DATE '2026-01-01', 50000, 'Physics');

INSERT INTO Grants (grant_id, start_date, end_date, funding_amount, scientific_field)
VALUES ('23-01-00003', DATE '2025-01-01', DATE '2026-01-01', 150000, 'Math');

INSERT INTO Grants (grant_id, start_date, end_date, funding_amount, scientific_field)
VALUES ('25-01-00004', DATE '2025-01-01', DATE '2026-01-01', 150000, 'Biology');


INSERT INTO Participants (first_name, last_name, birth_date)
VALUES ('Ivan', 'Ivanov', DATE '1990-05-05');

UPDATE Participants
SET birth_date = DATE '1991-06-06'
WHERE participant_id = 1;

UPDATE Participants
SET first_name = 'Ihor'
WHERE participant_id = 1;

SELECT * FROM Authors_Archive
WHERE participant_id = 1;
