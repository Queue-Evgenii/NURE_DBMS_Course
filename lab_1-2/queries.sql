-- This SQL script contains various queries to analyze the database.

-- 1. Find all participants who have received more than one grant.
SELECT p.first_name, p.last_name, COUNT(*) AS grants_count
FROM Participants p
JOIN Grants_Participants gp ON p.participant_id = gp.participant_id
GROUP BY p.first_name, p.last_name
HAVING COUNT(*) > 1;

-- 2. Find all grant with funding amount greater than the average funding amount.
SELECT *
FROM Grants
WHERE funding_amount > (SELECT AVG(funding_amount) FROM Grants);


-- 3. Find all grant with funding amount greater than the average funding amount
SELECT scientific_field, COUNT(*) AS total
FROM Grants
GROUP BY scientific_field;

-- 4. Find all participants who are not involved in any grant.
SELECT m.first_name, m.last_name
FROM Managers m
LEFT JOIN Grants g ON m.manager_id = g.manager_id
WHERE g.manager_id IS NULL;

-- 5. Find all grants that are ending this year.
SELECT *
FROM Grants
WHERE EXTRACT(YEAR FROM end_date) = EXTRACT(YEAR FROM SYSDATE);

-- 6. Find all participants and the number of roles they have had.
SELECT p.first_name, p.last_name, COUNT(DISTINCT gp.role) AS role_count
FROM Participants p
JOIN Grants_Participants gp ON p.participant_id = gp.participant_id
GROUP BY p.first_name, p.last_name;

-- 7. The most expensive grant in each scientific field.
SELECT scientific_field, MAX(funding_amount) AS max_funding
FROM Grants
GROUP BY scientific_field;

-- 8. Find list of participants who participated in at least 3 grants.
SELECT p.first_name, p.last_name
FROM Participants p
JOIN Grants_Participants gp ON p.participant_id = gp.participant_id
GROUP BY p.first_name, p.last_name
HAVING COUNT(gp.grant_id) >= 3;

-- 9. Find all grants that have a duration of more than 12 months.
SELECT *
FROM Grants
WHERE MONTHS_BETWEEN(end_date, start_date) > 12;

-- 10. Find all participants who have the same first name or last name as another participant.
SELECT *
FROM Participants
WHERE first_name IN (
    SELECT first_name
    FROM Participants
    GROUP BY first_name
    HAVING COUNT(*) > 1
)
OR last_name IN (
    SELECT last_name
    FROM Participants
    GROUP BY last_name
    HAVING COUNT(*) > 1
);

-- 11. Find all grants that started in the first half of the year.
SELECT *
FROM Grants
WHERE EXTRACT(MONTH FROM start_date) <= 6;

-- 12. Find all participants who updated the archive during the last 30 days.
SELECT *
FROM Authors_Archive
WHERE update_date >= SYSDATE - 30;

-- 13. Rating of managers by the total amount of funding they have managed.
SELECT m.first_name, m.last_name, SUM(g.funding_amount) AS total_funding
FROM Managers m
JOIN Grants g ON m.manager_id = g.manager_id
GROUP BY m.first_name, m.last_name
ORDER BY total_funding DESC;

-- 14. Find all participants who did not participate in any grant.
SELECT p.first_name, p.last_name
FROM Participants p
WHERE NOT EXISTS (
    SELECT 1 FROM Grants_Participants gp
    WHERE gp.participant_id = p.participant_id
);

-- 15. Amount of participants in each grant.
SELECT g.grant_id, COUNT(gp.participant_id) AS participant_count
FROM Grants g
LEFT JOIN Grants_Participants gp ON g.grant_id = gp.grant_id
GROUP BY g.grant_id;

-- 16. Find youngest participant in participants.
SELECT first_name, last_name, birth_date
FROM Participants
WHERE birth_date = (SELECT MAX(birth_date) FROM Participants);

-- 17. Find all grants that have more than 5 and more participants.
SELECT g.grant_id
FROM Grants g
JOIN Grants_Participants gp ON g.grant_id = gp.grant_id
GROUP BY g.grant_id
HAVING COUNT(gp.participant_id) >= 5;

-- 18. Find average number of participants in grants.
SELECT AVG(participant_count) AS avg_participants
FROM (
    SELECT COUNT(*) AS participant_count
    FROM Grants_Participants
    GROUP BY grant_id
);

-- 19. Find all participants ever worked in different roles.
SELECT p.participant_id, p.first_name, p.last_name, p.birth_date
FROM Participants p
WHERE p.participant_id IN (
    SELECT participant_id 
    FROM Grants_Participants 
    GROUP BY participant_id 
    HAVING COUNT(DISTINCT role) > 1
);

-- 20. Find all managers who have managed more than one grant and the total funding they managed.
SELECT 
    m.manager_id,
    m.first_name || ' ' || m.last_name AS full_name,
    COUNT(g.grant_id) AS grants_count,
    SUM(g.funding_amount) AS total_funding
FROM Managers m
JOIN Grants g ON m.manager_id = g.manager_id
GROUP BY m.manager_id, m.first_name, m.last_name
HAVING COUNT(g.grant_id) > 1;