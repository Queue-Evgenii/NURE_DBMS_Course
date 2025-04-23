INSERT INTO Managers (first_name, last_name, birth_date) VALUES ('Іван', 'Ковальчук', DATE '1975-05-20');
INSERT INTO Managers (first_name, last_name, birth_date) VALUES ('Олена', 'Бондаренко', DATE '1980-09-12');
INSERT INTO Managers (first_name, last_name, birth_date) VALUES ('Сергій', 'Ткаченко', DATE '1983-03-15');
INSERT INTO Managers (first_name, last_name, birth_date) VALUES ('Данило', 'Галицький', DATE '1993-07-16');

INSERT INTO Participants (first_name, last_name, birth_date) VALUES ('Андрій', 'Мельник', DATE '1990-04-11');
INSERT INTO Participants (first_name, last_name, birth_date) VALUES ('Ірина', 'Шевченко', DATE '1989-12-03');
INSERT INTO Participants (first_name, last_name, birth_date) VALUES ('Марина', 'Гончар', DATE '1993-07-08');
INSERT INTO Participants (first_name, last_name, birth_date) VALUES ('Олександр', 'Кравець', DATE '1995-01-25');
INSERT INTO Participants (first_name, last_name, birth_date) VALUES ('Ольга', 'Сидоренко', DATE '1987-10-14');
INSERT INTO Participants (first_name, last_name, birth_date) VALUES ('Дмитро', 'Поліщук', DATE '1991-06-30');
INSERT INTO Participants (first_name, last_name, birth_date) VALUES ('Катерина', 'Литвин', DATE '1994-02-19');
INSERT INTO Participants (first_name, last_name, birth_date) VALUES ('Олександр', 'Литвин', DATE '1999-12-11');

INSERT INTO Grants (grant_id, start_date, end_date, funding_amount, scientific_field, manager_id) VALUES ('GR001', DATE '2022-01-01', DATE '2023-12-31', 150000.00, 'Біотехнології', 1);
INSERT INTO Grants (grant_id, start_date, end_date, funding_amount, scientific_field, manager_id) VALUES ('GR002', DATE '2023-05-15', DATE '2024-05-14', 300000.00, 'Інформатика', 2);
INSERT INTO Grants (grant_id, start_date, end_date, funding_amount, scientific_field, manager_id) VALUES ('GR003', DATE '2021-09-01', DATE '2022-08-31', 120000.00, 'Хімія', 3);
INSERT INTO Grants (grant_id, start_date, end_date, funding_amount, scientific_field, manager_id) VALUES ('GR004', DATE '2024-03-01', DATE '2025-03-01', 500000.00, 'Фізика', 1);
INSERT INTO Grants (grant_id, start_date, end_date, funding_amount, scientific_field, manager_id) VALUES ('GR005', DATE '2020-06-01', DATE '2021-06-01', 100000.00, 'Медицина', 2);

INSERT INTO Grants_Participants (grant_id, participant_id, role) VALUES ('GR001', 1, 'Дослідник');
INSERT INTO Grants_Participants (grant_id, participant_id, role) VALUES ('GR001', 2, 'Асистент');
INSERT INTO Grants_Participants (grant_id, participant_id, role) VALUES ('GR001', 3, 'Аналітик');
INSERT INTO Grants_Participants (grant_id, participant_id, role) VALUES ('GR002', 2, 'Координатор');
INSERT INTO Grants_Participants (grant_id, participant_id, role) VALUES ('GR002', 4, 'Дослідник');
INSERT INTO Grants_Participants (grant_id, participant_id, role) VALUES ('GR002', 5, 'Дослідник');
INSERT INTO Grants_Participants (grant_id, participant_id, role) VALUES ('GR003', 1, 'Асистент');
INSERT INTO Grants_Participants (grant_id, participant_id, role) VALUES ('GR003', 6, 'Дослідник');
INSERT INTO Grants_Participants (grant_id, participant_id, role) VALUES ('GR003', 3, 'Координатор');
INSERT INTO Grants_Participants (grant_id, participant_id, role) VALUES ('GR004', 4, 'Аналітик');
INSERT INTO Grants_Participants (grant_id, participant_id, role) VALUES ('GR004', 5, 'Дослідник');
INSERT INTO Grants_Participants (grant_id, participant_id, role) VALUES ('GR004', 1, 'Дослідник');
INSERT INTO Grants_Participants (grant_id, participant_id, role) VALUES ('GR004', 7, 'Аналітик');
INSERT INTO Grants_Participants (grant_id, participant_id, role) VALUES ('GR004', 6, 'Координатор');
INSERT INTO Grants_Participants (grant_id, participant_id, role) VALUES ('GR005', 7, 'Асистент');

INSERT INTO Authors_Archive (participant_id, first_name, last_name, birth_date) VALUES (1, 'Андрій', 'Мельник', DATE '1990-04-11');
INSERT INTO Authors_Archive (participant_id, first_name, last_name, birth_date) VALUES (2, 'Ірина', 'Шевченко', DATE '1989-12-03');
INSERT INTO Authors_Archive (participant_id, first_name, last_name, birth_date) VALUES (3, 'Марина', 'Гончар', DATE '1993-07-08');

COMMIT;