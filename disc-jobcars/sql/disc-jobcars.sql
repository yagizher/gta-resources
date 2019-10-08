CREATE TABLE IF NOT EXISTS job_cars
(
    id     BIGINT UNSIGNED AUTO_INCREMENT,
    owner  TEXT                 NOT NULL,
    plate  TEXT                 NOT NULL,
    props  LONGTEXT             NULL,
    `stored` BOOLEAN DEFAULT TRUE NULL,
    model TEXT NOT NULL,
    job TEXT NOT NULL,
    CONSTRAINT id
        UNIQUE (id)
);

ALTER TABLE job_cars
    ADD PRIMARY KEY (id);