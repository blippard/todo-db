-- Removing tables --
DROP TABLE IF EXISTS "user";
DROP TABLE IF EXISTS "todo";

-- Tables --

-- Creating user table
CREATE TABLE "user"
(
    user_id     SERIAL NOT NULL PRIMARY KEY,
    name        VARCHAR(50) NOT NULL
);

-- Creating todos table
CREATE TABLE "todo"
(
    id          SERIAL NOT NULL PRIMARY KEY,
    task        VARCHAR(100) NOT NULL,
    user_id     INT NOT NULL,
    done        BOOLEAN NOT NULL
);

-- Removing foreign keys --

-- Remove FK user_id
ALTER TABLE ONLY "todo"
    DROP CONSTRAINT IF EXISTS user_id;

-- Adding foreign keys --

-- Connect 'todos.user_id' with 'user.id'
ALTER TABLE ONLY "todo"
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id)
        REFERENCES "user" (user_id) ON DELETE CASCADE;

    -- Filling tables --

-- Filling user table

INSERT INTO "user" (name) VALUES ('Dominic');
INSERT INTO "user" (name) VALUES ('Hamilton');
INSERT INTO "user" (name) VALUES ('Cassady');
INSERT INTO "user" (name) VALUES ('Jacob');
INSERT INTO "user" (name) VALUES ('Quinn');

-- Filling todos table

INSERT INTO "todo" (task,user_id,done) VALUES ('Take out the thrash',5,TRUE);
INSERT INTO "todo" (task,user_id,done) VALUES ('Buy eggs',1,FALSE);
INSERT INTO "todo" (task,user_id,done) VALUES ('50 pushups',2,TRUE);
INSERT INTO "todo" (task,user_id,done) VALUES ('Relax',5,FALSE);
INSERT INTO "todo" (task,user_id,done) VALUES ('Romantic dinner',5,TRUE);
INSERT INTO "todo" (task,user_id,done) VALUES ('Meeting at 3pm',2,TRUE);
INSERT INTO "todo" (task,user_id,done) VALUES ('Pick up mom at the airport',5,FALSE);
INSERT INTO "todo" (task,user_id,done) VALUES ('Talk with Jerry',1,TRUE);
INSERT INTO "todo" (task,user_id,done) VALUES ('Do the tax reports',4,TRUE);
INSERT INTO "todo" (task,user_id,done) VALUES ('Order pizza for twelve',1,FALSE);
INSERT INTO "todo" (task,user_id,done) VALUES ('Prepare for presentation',1,TRUE);

