-- View test
SELECT * FROM Grant_Details_View;

-- Trigger test
INSERT INTO Grant_Details_View (
    grant_id,
    start_date,
    end_date,
    funding_amount,
    scientific_field,
    manager_name,
    participant_name,
    participant_role
) VALUES (
    'GR020',
    DATE '2025-06-01',
    DATE '2026-06-01',
    200000,
    'Математика',
    'Іван Ковальчук',
    'Олександр Кравець',
    'Аналітик'
);

COMMIT;



-- Exceptions test

BEGIN
    Get_Participant_Grants('Мельник');
    Get_Participant_Grants('Петренко');
END;


BEGIN
    Check_Participant_In_Grant('GR001', 1);
    Check_Participant_In_Grant('GR002', 3);
END;


BEGIN
    Add_Grant_With_Manager('GR999', DATE '2025-01-01', DATE '2026-01-01', 250000, 'Екологія', 999);
END;
