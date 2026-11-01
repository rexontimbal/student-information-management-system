-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: 127.0.0.1    Database: sims_db
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_locks_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enrollments`
--

DROP TABLE IF EXISTS `enrollments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enrollments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `student_id` bigint(20) unsigned NOT NULL,
  `subject_id` bigint(20) unsigned NOT NULL,
  `school_year` varchar(255) NOT NULL,
  `semester` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'enrolled',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `enrollments_student_subject_term_unique` (`student_id`,`subject_id`,`school_year`,`semester`),
  KEY `enrollments_subject_id_foreign` (`subject_id`),
  CONSTRAINT `enrollments_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE,
  CONSTRAINT `enrollments_subject_id_foreign` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollments`
--

LOCK TABLES `enrollments` WRITE;
/*!40000 ALTER TABLE `enrollments` DISABLE KEYS */;
INSERT INTO `enrollments` VALUES (3,2,1,'2025-2026','1st Semester','enrolled','2026-10-31 23:30:18','2026-10-31 23:30:18');
/*!40000 ALTER TABLE `enrollments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2026_11_01_065543_add_role_to_users_table',2),(5,'2026_11_01_070653_create_students_table',3),(6,'2026_11_01_072151_create_subjects_table',4),(7,'2026_11_01_072546_create_enrollments_table',5),(8,'2026_11_01_073551_create_personal_access_tokens_table',6);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  KEY `personal_access_tokens_expires_at_index` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('9aW0wyoxqYTgZjGIZtW5mn40q6ow6PYGgqkY4Sx4',1,'127.0.0.1','curl/8.16.0','YTo3OntzOjY6Il90b2tlbiI7czo0MDoiajJZaG1oMEs5TTVDNXRrZTlMdTJScWR3UkJQU3hGdkZnMTFLYzUxNiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly8xMjcuMC4wLjE6ODEyNC9zdHVkZW50cy8xL2VkaXQiO3M6NToicm91dGUiO3M6MTM6InN0dWRlbnRzLmVkaXQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YToyOntpOjA7czoxMDoiX29sZF9pbnB1dCI7aToxO3M6NjoiZXJyb3JzIjt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO3M6MTc6InBhc3N3b3JkX2hhc2hfd2ViIjtzOjY0OiI0ZmJmNWI4NTQ1MzA3NjExOWM3NDYwMmU3YWNkNjU0YTA3OTFkN2QyNTVjZDhmZmI2ZjJiNDE3ZGE3MzExMTU2IjtzOjEwOiJfb2xkX2lucHV0IjthOjA6e31zOjY6ImVycm9ycyI7TzozMToiSWxsdW1pbmF0ZVxTdXBwb3J0XFZpZXdFcnJvckJhZyI6MTp7czo3OiIAKgBiYWdzIjthOjE6e3M6NzoiZGVmYXVsdCI7TzoyOToiSWxsdW1pbmF0ZVxTdXBwb3J0XE1lc3NhZ2VCYWciOjI6e3M6MTE6IgAqAG1lc3NhZ2VzIjthOjY6e3M6MTQ6InN0dWRlbnRfbnVtYmVyIjthOjE6e2k6MDtzOjM3OiJUaGUgc3R1ZGVudCBudW1iZXIgZmllbGQgaXMgcmVxdWlyZWQuIjt9czoxMDoiZmlyc3RfbmFtZSI7YToxOntpOjA7czozMzoiVGhlIGZpcnN0IG5hbWUgZmllbGQgaXMgcmVxdWlyZWQuIjt9czo5OiJsYXN0X25hbWUiO2E6MTp7aTowO3M6MzI6IlRoZSBsYXN0IG5hbWUgZmllbGQgaXMgcmVxdWlyZWQuIjt9czo1OiJlbWFpbCI7YToxOntpOjA7czoyODoiVGhlIGVtYWlsIGZpZWxkIGlzIHJlcXVpcmVkLiI7fXM6NjoiY291cnNlIjthOjE6e2k6MDtzOjI5OiJUaGUgY291cnNlIGZpZWxkIGlzIHJlcXVpcmVkLiI7fXM6MTA6InllYXJfbGV2ZWwiO2E6MTp7aTowO3M6MzM6IlRoZSB5ZWFyIGxldmVsIGZpZWxkIGlzIHJlcXVpcmVkLiI7fX1zOjk6IgAqAGZvcm1hdCI7czo4OiI6bWVzc2FnZSI7fX19fQ==',1793517215),('bTJzB9QtgnMOnGuwOYh8PxhDn9Qyrd2DpLmjbt2p',1,'127.0.0.1','curl/8.16.0','YTo3OntzOjY6Il90b2tlbiI7czo0MDoiQmNDRzNoa3NucVhpRkUyMnNNaFgzbFdHQ2NYMFFBWjZOZ3VMUGFlYyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly8xMjcuMC4wLjE6ODEyNC9zdHVkZW50cy9jcmVhdGUiO3M6NToicm91dGUiO3M6MTU6InN0dWRlbnRzLmNyZWF0ZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjI6e2k6MDtzOjEwOiJfb2xkX2lucHV0IjtpOjE7czo2OiJlcnJvcnMiO31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjQ6IjRmYmY1Yjg1NDUzMDc2MTE5Yzc0NjAyZTdhY2Q2NTRhMDc5MWQ3ZDI1NWNkOGZmYjZmMmI0MTdkYTczMTExNTYiO3M6MTA6Il9vbGRfaW5wdXQiO2E6Njp7czoxNDoic3R1ZGVudF9udW1iZXIiO3M6OToiMjAyNi0wMDAxIjtzOjEwOiJmaXJzdF9uYW1lIjtzOjM6IkR1cCI7czo5OiJsYXN0X25hbWUiO3M6NjoiTGljYXRlIjtzOjU6ImVtYWlsIjtzOjE1OiJkdXBAZXhhbXBsZS5jb20iO3M6NjoiY291cnNlIjtzOjQ6IkJTSVQiO3M6MTA6InllYXJfbGV2ZWwiO3M6ODoiMXN0IFllYXIiO31zOjY6ImVycm9ycyI7TzozMToiSWxsdW1pbmF0ZVxTdXBwb3J0XFZpZXdFcnJvckJhZyI6MTp7czo3OiIAKgBiYWdzIjthOjE6e3M6NzoiZGVmYXVsdCI7TzoyOToiSWxsdW1pbmF0ZVxTdXBwb3J0XE1lc3NhZ2VCYWciOjI6e3M6MTE6IgAqAG1lc3NhZ2VzIjthOjE6e3M6MTQ6InN0dWRlbnRfbnVtYmVyIjthOjE6e2k6MDtzOjQyOiJUaGUgc3R1ZGVudCBudW1iZXIgaGFzIGFscmVhZHkgYmVlbiB0YWtlbi4iO319czo5OiIAKgBmb3JtYXQiO3M6ODoiOm1lc3NhZ2UiO319fX0=',1793517187),('cQFW7vqc0KdPxYOMlIxOs2r8UVmJWj5WJakO9Sr7',1,'127.0.0.1','curl/8.16.0','YTo3OntzOjY6Il90b2tlbiI7czo0MDoia3lDMmJQNlNPRmFLdFBiY2o3bjZRTG11VkN6YjBiWWEzaU9rZWt0NCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly8xMjcuMC4wLjE6ODEyNC9zdHVkZW50cy9jcmVhdGUiO3M6NToicm91dGUiO3M6MTU6InN0dWRlbnRzLmNyZWF0ZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjI6e2k6MDtzOjEwOiJfb2xkX2lucHV0IjtpOjE7czo2OiJlcnJvcnMiO31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjQ6IjRmYmY1Yjg1NDUzMDc2MTE5Yzc0NjAyZTdhY2Q2NTRhMDc5MWQ3ZDI1NWNkOGZmYjZmMmI0MTdkYTczMTExNTYiO3M6MTA6Il9vbGRfaW5wdXQiO2E6MDp7fXM6NjoiZXJyb3JzIjtPOjMxOiJJbGx1bWluYXRlXFN1cHBvcnRcVmlld0Vycm9yQmFnIjoxOntzOjc6IgAqAGJhZ3MiO2E6MTp7czo3OiJkZWZhdWx0IjtPOjI5OiJJbGx1bWluYXRlXFN1cHBvcnRcTWVzc2FnZUJhZyI6Mjp7czoxMToiACoAbWVzc2FnZXMiO2E6Njp7czoxNDoic3R1ZGVudF9udW1iZXIiO2E6MTp7aTowO3M6Mzc6IlRoZSBzdHVkZW50IG51bWJlciBmaWVsZCBpcyByZXF1aXJlZC4iO31zOjEwOiJmaXJzdF9uYW1lIjthOjE6e2k6MDtzOjMzOiJUaGUgZmlyc3QgbmFtZSBmaWVsZCBpcyByZXF1aXJlZC4iO31zOjk6Imxhc3RfbmFtZSI7YToxOntpOjA7czozMjoiVGhlIGxhc3QgbmFtZSBmaWVsZCBpcyByZXF1aXJlZC4iO31zOjU6ImVtYWlsIjthOjE6e2k6MDtzOjI4OiJUaGUgZW1haWwgZmllbGQgaXMgcmVxdWlyZWQuIjt9czo2OiJjb3Vyc2UiO2E6MTp7aTowO3M6Mjk6IlRoZSBjb3Vyc2UgZmllbGQgaXMgcmVxdWlyZWQuIjt9czoxMDoieWVhcl9sZXZlbCI7YToxOntpOjA7czozMzoiVGhlIHllYXIgbGV2ZWwgZmllbGQgaXMgcmVxdWlyZWQuIjt9fXM6OToiACoAZm9ybWF0IjtzOjg6IjptZXNzYWdlIjt9fX19',1793517251),('d2vjbuOfLnPXhF6lAJtNATaUlTAX5bRWIMDRAOVG',2,'127.0.0.1','curl/8.16.0','YTo1OntzOjY6Il90b2tlbiI7czo0MDoiTnd1SU5pcmZtSTczaXF2YTd4QzU3V2x3T2o1dnZqdXNCS2dJQ1hQUSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODEyOS9zdHVkZW50cyI7czo1OiJyb3V0ZSI7czoxNDoic3R1ZGVudHMuaW5kZXgiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToyO3M6MTc6InBhc3N3b3JkX2hhc2hfd2ViIjtzOjY0OiIyZjY1Mjk4NDczYWUwNjFlNDQyMDU2YTczNDg3NjY4N2UyODljMTk3NGE1NDIzY2ZiODYwYmVjYmFiOTFiMzJkIjt9',1793518891),('D5bkU9VUrKbLBgG3b1TXiPVhi8L4zoLxpEKnjR6b',1,'127.0.0.1','curl/8.16.0','YTo1OntzOjY6Il90b2tlbiI7czo0MDoiOHoxa3V0bGphMldObExub3lwNTVSNmFscHRvTDRtSlJaaHFsb3ZDMyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODEyNi9lbnJvbGxtZW50cyI7czo1OiJyb3V0ZSI7czoxNzoiZW5yb2xsbWVudHMuaW5kZXgiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO3M6MTc6InBhc3N3b3JkX2hhc2hfd2ViIjtzOjY0OiI0ZmJmNWI4NTQ1MzA3NjExOWM3NDYwMmU3YWNkNjU0YTA3OTFkN2QyNTVjZDhmZmI2ZjJiNDE3ZGE3MzExMTU2Ijt9',1793518093),('DCoO89Sd10Wj1qY6NnzIsW5aSjkMcHzVTSMSb9qs',1,'127.0.0.1','curl/8.16.0','YTo1OntzOjY6Il90b2tlbiI7czo0MDoiaDB2cGViTHNIeDZDckJWakNLRWtuZHdaQzVsVk03cXFKeHRXbXJSciI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODEyNy9kYXNoYm9hcmQiO3M6NToicm91dGUiO3M6OToiZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTtzOjE3OiJwYXNzd29yZF9oYXNoX3dlYiI7czo2NDoiNGZiZjViODU0NTMwNzYxMTljNzQ2MDJlN2FjZDY1NGEwNzkxZDdkMjU1Y2Q4ZmZiNmYyYjQxN2RhNzMxMTE1NiI7fQ==',1793518350),('dCuGemENOhkwsFjDXKv0t7KYJr2IYtfTAPu4TpiJ',1,'127.0.0.1','curl/8.16.0','YTo1OntzOjY6Il90b2tlbiI7czo0MDoiYXkwR0tSYkFRd2JzaDZEZW9CZ3daUXRvczBBcmNheDk2STRCZXNRNSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODEyNi9lbnJvbGxtZW50cyI7czo1OiJyb3V0ZSI7czoxNzoiZW5yb2xsbWVudHMuaW5kZXgiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO3M6MTc6InBhc3N3b3JkX2hhc2hfd2ViIjtzOjY0OiI0ZmJmNWI4NTQ1MzA3NjExOWM3NDYwMmU3YWNkNjU0YTA3OTFkN2QyNTVjZDhmZmI2ZjJiNDE3ZGE3MzExMTU2Ijt9',1793518112),('eonIqz8ri5bl0TjYic4HKiLXfuLMUw1eL2p5kEWr',1,'127.0.0.1','curl/8.16.0','YTo2OntzOjY6Il90b2tlbiI7czo0MDoidm1ZYkRjMGJTbnJjeVJkSVBzWlVDb1d4YkJPaHpqSnNZNWIzRDA4ZyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly8xMjcuMC4wLjE6ODEyNC9zdHVkZW50cy9jcmVhdGUiO3M6NToicm91dGUiO3M6MTU6InN0dWRlbnRzLmNyZWF0ZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjE6e2k6MDtzOjc6InN1Y2Nlc3MiO31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjQ6IjRmYmY1Yjg1NDUzMDc2MTE5Yzc0NjAyZTdhY2Q2NTRhMDc5MWQ3ZDI1NWNkOGZmYjZmMmI0MTdkYTczMTExNTYiO3M6Nzoic3VjY2VzcyI7czoyNzoiU3R1ZGVudCBhZGRlZCBzdWNjZXNzZnVsbHkuIjt9',1793517141),('iEE2tRsXUUp4mqvbGjGQOB5SqDSKDj1Qj2sK9rUw',1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Claude/4.4212.0 Chrome/152.0.7977.167 Safari/537.36 MSIX','YTo1OntzOjY6Il90b2tlbiI7czo0MDoiR1dRNHc2S2xBYXU1YjRueEU5c1pDakVoNXNLSktSeHlJckFITEJCWSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwNC9kYXNoYm9hcmQiO3M6NToicm91dGUiO3M6OToiZGFzaGJvYXJkIjt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTtzOjE3OiJwYXNzd29yZF9oYXNoX3dlYiI7czo2NDoiNGZiZjViODU0NTMwNzYxMTljNzQ2MDJlN2FjZDY1NGEwNzkxZDdkMjU1Y2Q4ZmZiNmYyYjQxN2RhNzMxMTE1NiI7fQ==',1793519072),('JCthUQUB3w0nuttDUJ0TXN0P8reFFVzJLYvo30Ck',1,'127.0.0.1','curl/8.16.0','YTo1OntzOjY6Il90b2tlbiI7czo0MDoiUkZESElUY012MHRVbHF3YkhtNzYzSWxaeEJtYWNtQ1RXVEtDa09WViI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODEyNC9zdHVkZW50cyI7czo1OiJyb3V0ZSI7czoxNDoic3R1ZGVudHMuaW5kZXgiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO3M6MTc6InBhc3N3b3JkX2hhc2hfd2ViIjtzOjY0OiI0ZmJmNWI4NTQ1MzA3NjExOWM3NDYwMmU3YWNkNjU0YTA3OTFkN2QyNTVjZDhmZmI2ZjJiNDE3ZGE3MzExMTU2Ijt9',1793517329),('LrKHc9UsFvXJhWe0EpTtL0GB9d3k7Y0SWCXYfrYx',1,'127.0.0.1','curl/8.16.0','YTo1OntzOjY6Il90b2tlbiI7czo0MDoiTDkzeWNocmtTdW5FWmpIWFh0YmFVUlVEbnpzVm9SVXdEVGZzMldacCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODEyNC9zdHVkZW50cyI7czo1OiJyb3V0ZSI7czoxNDoic3R1ZGVudHMuaW5kZXgiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO3M6MTc6InBhc3N3b3JkX2hhc2hfd2ViIjtzOjY0OiI0ZmJmNWI4NTQ1MzA3NjExOWM3NDYwMmU3YWNkNjU0YTA3OTFkN2QyNTVjZDhmZmI2ZjJiNDE3ZGE3MzExMTU2Ijt9',1793517154),('mNoMUJ2GFtqlVbH5vmnwbWcpQsQsepZYbYveWvcU',1,'127.0.0.1','curl/8.16.0','YTo1OntzOjY6Il90b2tlbiI7czo0MDoiUXFLTnlOQmhLU3NndGpxdnFWa2dQWkNiV09IZlExc0R0ZnZjMk5uViI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODEyNS9zdWJqZWN0cyI7czo1OiJyb3V0ZSI7czoxNDoic3ViamVjdHMuaW5kZXgiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO3M6MTc6InBhc3N3b3JkX2hhc2hfd2ViIjtzOjY0OiI0ZmJmNWI4NTQ1MzA3NjExOWM3NDYwMmU3YWNkNjU0YTA3OTFkN2QyNTVjZDhmZmI2ZjJiNDE3ZGE3MzExMTU2Ijt9',1793517824),('O9vYYSXHYiJa2vkRzHk6Z1SaLfGtKAWYfeiuYB6P',NULL,'127.0.0.1','curl/8.16.0','YTo0OntzOjY6Il90b2tlbiI7czo0MDoiSE5LZVhPNnhUVFduYmRVTHh4OEZxRzduSjNMaDN5ell0QXdHSUxJZiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjk6Imh0dHA6Ly8xMjcuMC4wLjE6ODEyMy9wcm9maWxlIjtzOjU6InJvdXRlIjtzOjEyOiJwcm9maWxlLmVkaXQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjM6InVybCI7YToxOntzOjg6ImludGVuZGVkIjtzOjI5OiJodHRwOi8vMTI3LjAuMC4xOjgxMjMvcHJvZmlsZSI7fX0=',1793516642),('OUxo2eOlZ42N0FydD7BNUop5NFUqk28AVHhJIEad',1,'127.0.0.1','curl/8.16.0','YTo3OntzOjY6Il90b2tlbiI7czo0MDoiQkpMRlZhbklSS3BKR3pSYjJ2dktpeUlzTFdhaHZFcUlLYUtoRXBBeSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly8xMjcuMC4wLjE6ODEyNC9zdHVkZW50cy9jcmVhdGUiO3M6NToicm91dGUiO3M6MTU6InN0dWRlbnRzLmNyZWF0ZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjI6e2k6MDtzOjEwOiJfb2xkX2lucHV0IjtpOjE7czo2OiJlcnJvcnMiO31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjQ6IjRmYmY1Yjg1NDUzMDc2MTE5Yzc0NjAyZTdhY2Q2NTRhMDc5MWQ3ZDI1NWNkOGZmYjZmMmI0MTdkYTczMTExNTYiO3M6MTA6Il9vbGRfaW5wdXQiO2E6Njp7czoxNDoic3R1ZGVudF9udW1iZXIiO3M6OToiMjAyNi0wMDAxIjtzOjEwOiJmaXJzdF9uYW1lIjtzOjQ6Ikp1YW4iO3M6OToibGFzdF9uYW1lIjtzOjk6IkRlbGEgQ3J1eiI7czo1OiJlbWFpbCI7czoxNjoianVhbkBleGFtcGxlLmNvbSI7czo2OiJjb3Vyc2UiO3M6MTk6IkJTIENvbXB1dGVyIFNjaWVuY2UiO3M6MTA6InllYXJfbGV2ZWwiO3M6ODoiMm5kIFllYXIiO31zOjY6ImVycm9ycyI7TzozMToiSWxsdW1pbmF0ZVxTdXBwb3J0XFZpZXdFcnJvckJhZyI6MTp7czo3OiIAKgBiYWdzIjthOjE6e3M6NzoiZGVmYXVsdCI7TzoyOToiSWxsdW1pbmF0ZVxTdXBwb3J0XE1lc3NhZ2VCYWciOjI6e3M6MTE6IgAqAG1lc3NhZ2VzIjthOjI6e3M6MTQ6InN0dWRlbnRfbnVtYmVyIjthOjE6e2k6MDtzOjQyOiJUaGUgc3R1ZGVudCBudW1iZXIgaGFzIGFscmVhZHkgYmVlbiB0YWtlbi4iO31zOjU6ImVtYWlsIjthOjE6e2k6MDtzOjMzOiJUaGUgZW1haWwgaGFzIGFscmVhZHkgYmVlbiB0YWtlbi4iO319czo5OiIAKgBmb3JtYXQiO3M6ODoiOm1lc3NhZ2UiO319fX0=',1793517065),('QNd5GyNr6tWolpf9MmtWZDUD8Kt8bhjyyosd1veX',1,'127.0.0.1','curl/8.16.0','YTo1OntzOjY6Il90b2tlbiI7czo0MDoiWkpiM2ZqWUVJQWhxdEQ3cUdRUzhmVVR0RjZRdEZoU3dvckdIVEhqdyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODEyNC9zdHVkZW50cyI7czo1OiJyb3V0ZSI7czoxNDoic3R1ZGVudHMuaW5kZXgiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO3M6MTc6InBhc3N3b3JkX2hhc2hfd2ViIjtzOjY0OiI0ZmJmNWI4NTQ1MzA3NjExOWM3NDYwMmU3YWNkNjU0YTA3OTFkN2QyNTVjZDhmZmI2ZjJiNDE3ZGE3MzExMTU2Ijt9',1793517040),('quAtHU2PX8DUlUiuyYP9AAjsE5dfvIhr8GXNBFmm',1,'127.0.0.1','curl/8.16.0','YTo1OntzOjY6Il90b2tlbiI7czo0MDoiNVV3dkoxUkN3V3JiNXFVZUZaN2hJUnVabjY3dGdSVzdQMUtRVjVDRSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjk6Imh0dHA6Ly8xMjcuMC4wLjE6ODEyMy9wcm9maWxlIjtzOjU6InJvdXRlIjtzOjEyOiJwcm9maWxlLmVkaXQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO3M6MTc6InBhc3N3b3JkX2hhc2hfd2ViIjtzOjY0OiI0ZmJmNWI4NTQ1MzA3NjExOWM3NDYwMmU3YWNkNjU0YTA3OTFkN2QyNTVjZDhmZmI2ZjJiNDE3ZGE3MzExMTU2Ijt9',1793516656),('rpaoiAsYcJJdJpLSaprPoDeQiLgHUAN8LtcLWv3z',1,'127.0.0.1','curl/8.16.0','YTo2OntzOjY6Il90b2tlbiI7czo0MDoiWGx2cUd4aWJmbU8yN0VUVHdzRnE5QVROaFVMcjNZWnNaMGFISkY3NyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly8xMjcuMC4wLjE6ODEyNC9zdHVkZW50cy9jcmVhdGUiO3M6NToicm91dGUiO3M6MTU6InN0dWRlbnRzLmNyZWF0ZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjE6e2k6MDtzOjc6InN1Y2Nlc3MiO31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjQ6IjRmYmY1Yjg1NDUzMDc2MTE5Yzc0NjAyZTdhY2Q2NTRhMDc5MWQ3ZDI1NWNkOGZmYjZmMmI0MTdkYTczMTExNTYiO3M6Nzoic3VjY2VzcyI7czoyNzoiU3R1ZGVudCBhZGRlZCBzdWNjZXNzZnVsbHkuIjt9',1793517235),('tFli7dwJk1SY7PcKKxDC2zXp9rAax29zpjpMucBE',1,'127.0.0.1','curl/8.16.0','YTo3OntzOjY6Il90b2tlbiI7czo0MDoiNnI1VlRCZTBydzJTWXRIN0dPd1lzRE9tbzFYWVBGWFk2aEtud09FNCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly8xMjcuMC4wLjE6ODEyNC9zdHVkZW50cy9jcmVhdGUiO3M6NToicm91dGUiO3M6MTU6InN0dWRlbnRzLmNyZWF0ZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjI6e2k6MDtzOjEwOiJfb2xkX2lucHV0IjtpOjE7czo2OiJlcnJvcnMiO31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjQ6IjRmYmY1Yjg1NDUzMDc2MTE5Yzc0NjAyZTdhY2Q2NTRhMDc5MWQ3ZDI1NWNkOGZmYjZmMmI0MTdkYTczMTExNTYiO3M6MTA6Il9vbGRfaW5wdXQiO2E6Njp7czoxNDoic3R1ZGVudF9udW1iZXIiO3M6OToiMjAyNi0wMDAxIjtzOjEwOiJmaXJzdF9uYW1lIjtzOjQ6Ikp1YW4iO3M6OToibGFzdF9uYW1lIjtzOjk6IkRlbGEgQ3J1eiI7czo1OiJlbWFpbCI7czoxNjoianVhbkBleGFtcGxlLmNvbSI7czo2OiJjb3Vyc2UiO3M6MTk6IkJTIENvbXB1dGVyIFNjaWVuY2UiO3M6MTA6InllYXJfbGV2ZWwiO3M6ODoiMm5kIFllYXIiO31zOjY6ImVycm9ycyI7TzozMToiSWxsdW1pbmF0ZVxTdXBwb3J0XFZpZXdFcnJvckJhZyI6MTp7czo3OiIAKgBiYWdzIjthOjE6e3M6NzoiZGVmYXVsdCI7TzoyOToiSWxsdW1pbmF0ZVxTdXBwb3J0XE1lc3NhZ2VCYWciOjI6e3M6MTE6IgAqAG1lc3NhZ2VzIjthOjI6e3M6MTQ6InN0dWRlbnRfbnVtYmVyIjthOjE6e2k6MDtzOjQyOiJUaGUgc3R1ZGVudCBudW1iZXIgaGFzIGFscmVhZHkgYmVlbiB0YWtlbi4iO31zOjU6ImVtYWlsIjthOjE6e2k6MDtzOjMzOiJUaGUgZW1haWwgaGFzIGFscmVhZHkgYmVlbiB0YWtlbi4iO319czo5OiIAKgBmb3JtYXQiO3M6ODoiOm1lc3NhZ2UiO319fX0=',1793517083),('TM7j4Af2niaz4Bm1P2etUxQ2QNotoAtp4E3v2GkX',2,'127.0.0.1','curl/8.16.0','YTo1OntzOjY6Il90b2tlbiI7czo0MDoiUkFBQVRhdE1uVWVPUE40eU5PT1h2QURyTEh4Tk1nT1JSbVBmV2MzNyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODEyOS9zdHVkZW50cyI7czo1OiJyb3V0ZSI7czoxNDoic3R1ZGVudHMuaW5kZXgiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToyO3M6MTc6InBhc3N3b3JkX2hhc2hfd2ViIjtzOjY0OiIyZjY1Mjk4NDczYWUwNjFlNDQyMDU2YTczNDg3NjY4N2UyODljMTk3NGE1NDIzY2ZiODYwYmVjYmFiOTFiMzJkIjt9',1793518877),('YXoRp5T6YqfkvpKpHxOWsVn5Bvy9SnjimI4uIsb0',1,'127.0.0.1','curl/8.16.0','YTo2OntzOjY6Il90b2tlbiI7czo0MDoiMnI5cGdlT1lvdzUwUVVDUGJlZkRWVlNVeGFVOFZnR3ZMTjRJUlBRaiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly8xMjcuMC4wLjE6ODEyOS9zdHVkZW50cy9jcmVhdGUiO3M6NToicm91dGUiO3M6MTU6InN0dWRlbnRzLmNyZWF0ZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjE6e2k6MDtzOjc6InN1Y2Nlc3MiO31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjQ6IjRmYmY1Yjg1NDUzMDc2MTE5Yzc0NjAyZTdhY2Q2NTRhMDc5MWQ3ZDI1NWNkOGZmYjZmMmI0MTdkYTczMTExNTYiO3M6Nzoic3VjY2VzcyI7czoyOToiU3R1ZGVudCBkZWxldGVkIHN1Y2Nlc3NmdWxseS4iO30=',1793518910);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `students` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `student_number` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `course` varchar(255) NOT NULL,
  `year_level` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `students_student_number_unique` (`student_number`),
  UNIQUE KEY `students_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (2,'2026-0001','Rexon','Timbal','rexon.timbal@sims.com','BSIT','4th Year','2026-10-31 23:28:50','2026-10-31 23:30:01');
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subjects`
--

DROP TABLE IF EXISTS `subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subjects` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `subject_code` varchar(255) NOT NULL,
  `subject_name` varchar(255) NOT NULL,
  `units` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `subjects_subject_code_unique` (`subject_code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subjects`
--

LOCK TABLES `subjects` WRITE;
/*!40000 ALTER TABLE `subjects` DISABLE KEYS */;
INSERT INTO `subjects` VALUES (1,'IT101','Introduction to Programming',3,'2026-10-31 23:24:40','2026-10-31 23:24:40');
/*!40000 ALTER TABLE `subjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL DEFAULT 'staff',
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Admin User','admin@sims.com',NULL,'$2y$12$UHUG0vHknDzHCQW3iBhb7eKDyeFJlhgklXc2KKNgcgX/eCci.NWLK','admin',NULL,'2026-10-31 22:56:25','2026-10-31 22:56:25'),(2,'Staff User','staff@sims.com',NULL,'$2y$12$FQG5xzGZU4wnF/9EsbTidOu2D2L2718OpPb9o5eZ8z3lKhzg5mfeq','staff',NULL,'2026-10-31 23:41:00','2026-10-31 23:41:00');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'sims_db'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-01 15:57:21
