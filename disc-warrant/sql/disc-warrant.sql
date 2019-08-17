CREATE TABLE IF NOT EXISTS warrants
(
    id                BIGINT UNSIGNED AUTO_INCREMENT,
    identifier        TEXT              NULL,
    crime_decription TEXT              NULL,
    char_decription  TEXT              NULL,
    active            TINYINT DEFAULT 1 NULL,
    code              VARCHAR(10)       NOT NULL,
    CONSTRAINT id
        UNIQUE (id)
);

ALTER TABLE warrants
    ADD PRIMARY KEY (id);