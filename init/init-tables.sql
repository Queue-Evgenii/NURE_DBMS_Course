CREATE TABLE Managers (
    manager_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    first_name VARCHAR2(100) NOT NULL,
    last_name VARCHAR2(100) NOT NULL,
    birth_date DATE NOT NULL
);

CREATE TABLE Participants (
    participant_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    first_name VARCHAR2(100) NOT NULL,
    last_name VARCHAR2(100) NOT NULL,
    birth_date DATE NOT NULL
);

CREATE TABLE Grants (
    grant_id VARCHAR2(20) PRIMARY KEY,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    funding_amount NUMBER(15, 2) CHECK (funding_amount >= 100000),
    scientific_field VARCHAR2(255) NOT NULL,
    manager_id NUMBER,
    FOREIGN KEY (manager_id) REFERENCES Managers(manager_id)
);

CREATE TABLE Grants_Participants (
    grant_id VARCHAR2(20),
    participant_id NUMBER,
    role VARCHAR2(50),
    PRIMARY KEY (grant_id, participant_id),
    FOREIGN KEY (grant_id) REFERENCES Grants(grant_id),
    FOREIGN KEY (participant_id) REFERENCES Participants(participant_id)
);

CREATE TABLE Authors_Archive (
    archive_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    participant_id NUMBER,
    first_name VARCHAR2(100),
    last_name VARCHAR2(100),
    birth_date DATE,
    update_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (participant_id) REFERENCES Participants(participant_id)
);

COMMIT;