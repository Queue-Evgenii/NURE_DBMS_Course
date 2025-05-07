-- Complex Queries With Date Functions
-- 1. Find all participants who are older than 30 years at the start of grant 'GR004'.
SELECT p.first_name, p.last_name, p.birth_date, g.grant_id,
       TRUNC(MONTHS_BETWEEN(g.start_date, p.birth_date) / 12) AS age_at_start
FROM Participants p
JOIN Grants_Participants gp ON p.participant_id = gp.participant_id
JOIN Grants g ON gp.grant_id = g.grant_id
WHERE g.grant_id = 'GR004' AND 
      TRUNC(MONTHS_BETWEEN(g.start_date, p.birth_date) / 12) > 30;

-- 2. Find all grants that have an end date within the last 6 months.
SELECT grant_id, end_date
FROM Grants
WHERE end_date BETWEEN ADD_MONTHS(SYSDATE, -6) AND SYSDATE;

-- 3. Calculate the age of each manager in years.
SELECT first_name, last_name, birth_date,
       TRUNC(MONTHS_BETWEEN(SYSDATE, birth_date)) AS ageMonths,
       TRUNC(MONTHS_BETWEEN(SYSDATE, birth_date) / 12) AS age
FROM Managers;

-- 4. Find all participants and managers born in second half of the year.
SELECT first_name, last_name, birth_date
FROM Participants
WHERE EXTRACT(MONTH FROM birth_date) > 6
UNION
SELECT first_name, last_name, birth_date
FROM Managers
WHERE EXTRACT(MONTH FROM birth_date) > 6;

-- 5. Find all grants that started in a leap year.
SELECT grant_id, start_date
FROM Grants
WHERE TO_CHAR(start_date, 'YYYY') IN (
    SELECT year
    FROM (
        SELECT LEVEL + 1999 AS year
        FROM dual
        CONNECT BY LEVEL <= 50
    )
    WHERE MOD(year, 4) = 0 AND (MOD(year, 100) != 0 OR MOD(year, 400) = 0)
);


-- Complex Queries
-- 6. Find all participants who have the same last name as another participant.
SELECT last_name, COUNT(*) AS count_same_lastname
FROM Participants
GROUP BY last_name
HAVING COUNT(*) > 1;

-- 7. Find average number of participants in grants.
SELECT AVG(participant_count) AS avg_participants
FROM (
    SELECT COUNT(*) AS participant_count
    FROM Grants_Participants
    GROUP BY grant_id
);

-- 8. Find the maximum funding amount for each scientific field.
SELECT scientific_field, MAX(funding_amount) AS max_funding
FROM Grants
GROUP BY scientific_field;

-- 9. Find all participants and their roles in grants listed in a single row.
SELECT p.first_name, p.last_name,
       LISTAGG(gp.role, ', ') WITHIN GROUP (ORDER BY gp.role) AS roles
FROM Participants p
JOIN Grants_Participants gp ON p.participant_id = gp.participant_id
GROUP BY p.first_name, p.last_name;

-- 10. Find all managers who have managed more than one grant and the total funding they managed.
SELECT 
    m.manager_id,
    m.first_name || ' ' || m.last_name AS full_name,
    COUNT(g.grant_id) AS grants_count,
    SUM(g.funding_amount) AS total_funding
FROM Managers m
JOIN Grants g ON m.manager_id = g.manager_id
GROUP BY m.manager_id, m.first_name, m.last_name
HAVING COUNT(g.grant_id) > 1;