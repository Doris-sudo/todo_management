-- ============================================
-- TODO MANAGEMENT SYSTEM
-- Database Assessment
-- ============================================

-- 1. Create database
CREATE DATABASE todo_management;

-- Connect to the database before running
-- \c todo_management


-- ============================================
-- 2. USERS TABLE
-- ============================================

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- ============================================
-- 3. TODOS TABLE
-- ============================================

CREATE TABLE todos (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    completed BOOLEAN DEFAULT FALSE,
    user_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE,

    CONSTRAINT title_not_empty
        CHECK (LENGTH(TRIM(title)) > 0)
);


-- ============================================
-- 4. SAMPLE USERS
-- ============================================

INSERT INTO users (name, email, password)
VALUES
    ('Doris', 'doris@example.com', 'password123'),
    ('John', 'john@example.com', 'password456'),
    ('Sarah', 'sarah@example.com', 'password789');


-- ============================================
-- 5. SAMPLE TODOS
-- ============================================

INSERT INTO todos (title, description, user_id)
VALUES
    ('Learn PostgreSQL Basics',
     'Practice creating databases, tables, and relationships.',
     1),

    ('Complete assignment',
     'Finish the database assessment.',
     2),

    ('Read a book',
     'Read at least one chapter today.',
     3),

    ('Practice SQL',
     'Write and practice basic SQL queries.',
     1),

    ('Review database notes',
     'Go through the notes from the database lesson.',
     2),

    ('Complete reading',
     'Finish reading the assigned material.',
     3),

    ('Build a Todo API',
     'Create a simple backend for managing Todos.',
     1);


-- ============================================
-- 6. BASIC USER OPERATIONS
-- ============================================

-- Insert a new user
INSERT INTO users (name, email, password)
VALUES ('Michael', 'michael@example.com', 'password000');

-- View all users
SELECT * FROM users;

-- View user by ID
SELECT * FROM users
WHERE id = 1;

-- Update user information
UPDATE users
SET name = 'Michael Smith'
WHERE id = 4;

-- Delete user
DELETE FROM users
WHERE id = 4;


-- ============================================
-- 7. BASIC TODO OPERATIONS
-- ============================================

-- Insert a new Todo
INSERT INTO todos (title, description, user_id)
VALUES (
    'Learn JOINs',
    'Practice joining users and todos tables.',
    1
);

-- View all Todos
SELECT * FROM todos;

-- View Todo by ID
SELECT * FROM todos
WHERE id = 1;

-- Update Todo
UPDATE todos
SET title = 'Learn PostgreSQL Basics'
WHERE id = 1;

-- Mark Todo as completed
UPDATE todos
SET completed = TRUE
WHERE id = 1;

-- Delete Todo
DELETE FROM todos
WHERE id = 8;


-- ============================================
-- 8. RELATIONSHIPS AND JOINS
-- ============================================

-- Get all Todos for a specific user
SELECT * FROM todos
WHERE user_id = 1;

-- Get all Todos with user name
SELECT
    todos.id,
    todos.title,
    todos.description,
    todos.completed,
    users.name
FROM todos
JOIN users ON todos.user_id = users.id;

-- Get all users and their Todos
SELECT
    users.id,
    users.name,
    todos.title,
    todos.completed
FROM users
LEFT JOIN todos ON users.id = todos.user_id
ORDER BY users.id;


-- ============================================
-- 9. FILTERING
-- ============================================

-- Completed Todos
SELECT * FROM todos
WHERE completed = TRUE;

-- Incomplete Todos
SELECT * FROM todos
WHERE completed = FALSE;

-- Todos belonging to a specific user
SELECT * FROM todos
WHERE user_id = 2;


-- ============================================
-- 10. SORTING
-- ============================================

-- Newest to oldest
SELECT * FROM todos
ORDER BY created_at DESC;

-- Oldest to newest
SELECT * FROM todos
ORDER BY created_at ASC;