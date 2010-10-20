BEGIN;
SET client_min_messages TO 'warning';

TRUNCATE artist CASCADE;
TRUNCATE artist_credit CASCADE;
TRUNCATE artist_name CASCADE;
TRUNCATE recording CASCADE;
TRUNCATE track_name CASCADE;

INSERT INTO artist_name (id, name) VALUES (1, 'Name');

INSERT INTO artist (id, gid, name, sort_name)
    VALUES (1, '945c079d-374e-4436-9448-da92dedef3cf', 1, 1);

INSERT INTO track_name (id, name) VALUES (1, 'Rondo Acapricio');
INSERT INTO artist_credit (id, name, artist_count) VALUES (1, 1, 1);
INSERT INTO artist_credit_name (artist_credit, name, artist, position) VALUES (1, 1, 1, 1);
INSERT INTO recording (id, name, artist_credit, gid)
    VALUES (1, 1, 1, '945c079d-374e-4436-9448-da92dedef3cf');

COMMIT;
