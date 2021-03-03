CREATE DATABASE trigger_exercise;

CREATE TABLE users(
    user_id SERIAL NOT NULL PRIMARY KEY,
    user_username VARCHAR(32) NOT NULL
);

CREATE TABLE history(
    old_id SERIAL NOT NULL PRIMARY KEY,
    old_username VARCHAR(32) NOT NULL
);

-- Create Trigger
CREATE FUNCTION delete_user() RETURNS TRIGGER LANGUAGE PLPGSQL AS $ $ BEGIN
INSERT INTO
    history(old_username)
VALUES
    (OLD.user_username);

RETURN NEW;

END $ $;

-- Triggering
CREATE TRIGGER delete_user
AFTER
    DELETE ON users FOR EACH ROW EXECUTE PROCEDURE delete_user();

delete from
    users
where
    user_username = 'usmon';