-- =============================================
-- Community Centre Booking System
-- MySQL Schema
-- Run this ONCE before starting the backend
-- =============================================

-- Create database
CREATE DATABASE IF NOT EXISTS community_center
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE community_centre;

-- =============================================
-- TABLE: rooms
-- =============================================
CREATE TABLE IF NOT EXISTS rooms (
  id        BIGINT AUTO_INCREMENT PRIMARY KEY,
  name      VARCHAR(100)  NOT NULL,
  type      VARCHAR(100)  NOT NULL,
  capacity  INT           NOT NULL,
  occupied  INT           NOT NULL DEFAULT 0
);

-- =============================================
-- TABLE: entry_logs
-- =============================================
CREATE TABLE IF NOT EXISTS entry_logs (
  id            BIGINT AUTO_INCREMENT PRIMARY KEY,
  room_id       BIGINT       NOT NULL,
  user_name     VARCHAR(100) NOT NULL,
  role          VARCHAR(20)  NOT NULL,           -- 'Student' or 'Professor'
  usn_or_dept   VARCHAR(100) NOT NULL,
  team_members  TEXT,
  purpose       VARCHAR(200) NOT NULL,
  people_count  INT          NOT NULL DEFAULT 1,
  entry_time    DATETIME     NOT NULL,
  exit_time     DATETIME,
  active        TINYINT(1)   NOT NULL DEFAULT 1,
  CONSTRAINT fk_entry_room FOREIGN KEY (room_id) REFERENCES rooms(id)
);

-- =============================================
-- Seed Rooms (Spring Boot also seeds on startup
-- if table is empty, so this is optional)
-- =============================================
INSERT IGNORE INTO rooms (id, name, type, capacity, occupied) VALUES
  (1,  'Cabin 1',              'Small Cabin',         6,  0),
  (2,  'Cabin 2',              'Small Cabin',         6,  0),
  (3,  'Cabin 3',              'Small Cabin',         6,  0),
  (4,  'Cabin 4',              'Small Cabin',         6,  0),
  (5,  'Project Room A',       'Project Room',       12,  0),
  (6,  'Project Room B',       'Project Room',       12,  0),
  (7,  'Top Floor Open Space', 'Open Space',         40,  0),
  (8,  'Main Hall',            'Ground Floor Hall',  80,  0),
  (9,  'Seminar Room',         'Seminar',            30,  0),
  (10, 'Discussion Room',      'Meeting',            10,  0);

-- =============================================
-- Useful queries for admin / debugging
-- =============================================

-- See all active bookings
-- SELECT e.*, r.name AS room_name
-- FROM entry_logs e
-- JOIN rooms r ON e.room_id = r.id
-- WHERE e.active = 1;

-- See room occupancy
-- SELECT id, name, type, capacity, occupied,
--        (capacity - occupied) AS available
-- FROM rooms;

-- Reset all occupancy (use carefully!)
-- UPDATE rooms SET occupied = 0;
-- UPDATE entry_logs SET active = 0, exit_time = NOW() WHERE active = 1;
