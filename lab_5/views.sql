-- This SQL script creates a view that combines information from multiple tables
-- to provide a comprehensive overview of grants, their managers, and participants.
CREATE VIEW Grant_Details_View AS
SELECT 
    g.grant_id,
    g.start_date,
    g.end_date,
    g.funding_amount,
    g.scientific_field,
    m.first_name || ' ' || m.last_name AS manager_name,
    p.first_name || ' ' || p.last_name AS participant_name,
    gp.role AS participant_role
FROM Grants g
JOIN Managers m ON g.manager_id = m.manager_id
JOIN Grants_Participants gp ON g.grant_id = gp.grant_id
JOIN Participants p ON gp.participant_id = p.participant_id;