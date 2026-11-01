# SIMS — Student Information Management System

A Laravel-based web application for managing student records, subjects, and
subject enrollments, with role-based access control (Admin / Staff) and a REST
API for the Student resource.

## Tech Stack

| Component       | Version / Notes                                   |
|------------------|-----------------------------------------------------|
| PHP              | ^8.2                                                 |
| Laravel          | 12.70.2                                              |
| Database         | MySQL (MariaDB via XAMPP) — database name `sims_db`  |
| Auth scaffolding | Laravel Breeze (Blade stack) 2.4                     |
| CSS framework    | Bootstrap 5.3.3 (CDN) + Bootstrap Icons, custom theme (`public/css/custom.css`) — indigo/amber palette, Inter font, sidebar layout |
| API auth package | Laravel Sanctum (installed, not yet enforced on the Student API) |
| Testing          | PHPUnit (via `php artisan test`), SQLite in-memory for tests |

## Setup / Installation (from scratch)

```bash
# 1. Clone / extract the project, then move into its folder
cd "Student Management System"

# 2. Install PHP dependencies
composer install

# 3. Copy the environment file and set your DB credentials
cp .env.example .env
# Edit .env and confirm/set:
#   DB_CONNECTION=mysql
#   DB_HOST=127.0.0.1
#   DB_PORT=3306
#   DB_DATABASE=sims_db
#   DB_USERNAME=root
#   DB_PASSWORD=

# 4. Generate the application key
php artisan key:generate

# 5. Create the database (if it doesn't already exist)
#    e.g. via phpMyAdmin, or:
mysql -u root -e "CREATE DATABASE IF NOT EXISTS sims_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

# 6. Run migrations
php artisan migrate

#    OR, to restore the included data export instead of migrating fresh:
#    mysql -u root sims_db < database/sims_db.sql

# 7. Install front-end dependencies and build assets
npm install
npm run build

# 8. Start the MySQL/MariaDB server (e.g. via XAMPP Control Panel) and then
#    start the Laravel dev server
php artisan serve
```

The app will be available at `http://127.0.0.1:8000`.

### Default login credentials (for testing)

| Role  | Email            | Password   |
|-------|------------------|------------|
| Admin | admin@sims.com   | password   |
| Staff | staff@sims.com   | password   |

If you restored the database from `database/sims_db.sql`, these accounts
already exist. If you ran a fresh `migrate` instead, create them yourself,
e.g. via Tinker:

```bash
php artisan tinker --execute="App\Models\User::create(['name'=>'Admin User','email'=>'admin@sims.com','password'=>Hash::make('password'),'role'=>'admin']);"
php artisan tinker --execute="App\Models\User::create(['name'=>'Staff User','email'=>'staff@sims.com','password'=>Hash::make('password'),'role'=>'staff']);"
```

## Web Routes / Pages

All routes below (except `/`, `/login`, `/register`) require authentication.
Routes marked **Admin only** additionally require the `admin` middleware.

| Route                          | Method(s)      | Description                                               |
|---------------------------------|-----------------|-------------------------------------------------------------|
| `/`                              | GET             | Public welcome page (Laravel default)                      |
| `/login`, `/register`           | GET/POST        | Breeze authentication (login, registration)                 |
| `/dashboard`                     | GET             | Dashboard — summary stat cards (students/subjects/enrollments/users), students-by-course and enrollments-by-status breakdowns |
| `/profile`                       | GET/PATCH/DELETE| Breeze account profile (update info, change password, delete account) |
| `/students`                      | GET             | List all students                                            |
| `/students/create`               | GET             | Form to add a new student                                    |
| `/students` *(store)*            | POST            | Create a student (validated)                                  |
| `/students/{student}/edit`       | GET             | Form to edit an existing student (pre-filled)                 |
| `/students/{student}` *(update)* | PUT/PATCH       | Update a student (validated)                                  |
| `/students/{student}` *(destroy)*| DELETE          | Delete a student — **Admin only**                               |
| `/subjects`                      | GET             | List all subjects                                             |
| `/subjects/create`               | GET             | Form to add a new subject                                     |
| `/subjects` *(store)*            | POST            | Create a subject (validated)                                   |
| `/subjects/{subject}/edit`       | GET             | Form to edit an existing subject (pre-filled)                   |
| `/subjects/{subject}` *(update)* | PUT/PATCH       | Update a subject (validated)                                   |
| `/subjects/{subject}` *(destroy)*| DELETE          | Delete a subject — **Admin only**                               |
| `/enrollments`                   | GET             | List all enrollments (student, subject, term, status)          |
| `/enrollments/create`            | GET             | Form to enroll a student in a subject                          |
| `/enrollments` *(store)*         | POST            | Create an enrollment (validated, unique per student/subject/term) |
| `/enrollments/{enrollment}/edit` | GET             | Form to edit an existing enrollment (pre-filled)                |
| `/enrollments/{enrollment}` *(update)* | PUT/PATCH | Update an enrollment (validated)                                 |
| `/enrollments/{enrollment}` *(destroy)*| DELETE    | Delete an enrollment — **Admin only**                             |

Role policy: **Staff** can view/create/edit Students, Subjects, and
Enrollments, but **cannot delete** any of them. **Admin** can do everything,
including delete. The Delete button is hidden in the UI for Staff, and the
underlying route is also protected server-side by the `admin` middleware
(`app/Http/Middleware/AdminMiddleware.php`) — so a Staff user cannot delete
even by hitting the URL directly (gets a `403 Forbidden`).

## REST API — Student Resource

Base URL: `http://127.0.0.1:8000/api`

> ⚠️ These endpoints are currently **open** (no authentication) for ease of
> testing during development. Before any real deployment, protect them with
> `->middleware('auth:sanctum')` and issue API tokens to clients.

### `GET /api/students` — list all students

**Request:** no body.

**Response `200 OK`:**
```json
[
    {
        "id": 2,
        "student_number": "2026-0001",
        "first_name": "Rexon",
        "last_name": "Timbal",
        "email": "rexon.timbal@sims.com",
        "course": "BSIT",
        "year_level": "4th Year",
        "created_at": "2026-10-31T23:28:50.000000Z",
        "updated_at": "2026-10-31T23:30:01.000000Z"
    }
]
```

### `GET /api/students/{id}` — get a single student

**Request:** no body.

**Response `200 OK`:**
```json
{
    "id": 2,
    "student_number": "2026-0001",
    "first_name": "Rexon",
    "last_name": "Timbal",
    "email": "rexon.timbal@sims.com",
    "course": "BSIT",
    "year_level": "4th Year",
    "created_at": "2026-10-31T23:28:50.000000Z",
    "updated_at": "2026-10-31T23:30:01.000000Z"
}
```

**Response `404 Not Found`** (unknown id):
```json
{
    "message": "No query results for model [App\\Models\\Student] 999"
}
```

### `POST /api/students` — create a student

**Request body** (`application/x-www-form-urlencoded` or `application/json`):
```json
{
    "student_number": "2026-0002",
    "first_name": "Maria",
    "last_name": "Santos",
    "email": "maria.santos@example.com",
    "course": "BSIT",
    "year_level": "1st Year"
}
```

**Response `201 Created`:**
```json
{
    "student_number": "2026-0002",
    "first_name": "Maria",
    "last_name": "Santos",
    "email": "maria.santos@example.com",
    "course": "BSIT",
    "year_level": "1st Year",
    "updated_at": "2026-11-01T07:37:22.000000Z",
    "created_at": "2026-11-01T07:37:22.000000Z",
    "id": 3
}
```

**Response `422 Unprocessable Content`** (validation failure):
```json
{
    "message": "The student number field is required. (and 5 more errors)",
    "errors": {
        "student_number": ["The student number field is required."],
        "first_name": ["The first name field is required."],
        "last_name": ["The last name field is required."],
        "email": ["The email field must be a valid email address."],
        "course": ["The course field is required."],
        "year_level": ["The year level field is required."]
    }
}
```

### `PUT /api/students/{id}` — update a student

**Request body:**
```json
{
    "student_number": "2026-0002",
    "first_name": "Maria",
    "last_name": "Santos-Reyes",
    "email": "maria.santos@example.com",
    "course": "BSIT",
    "year_level": "2nd Year"
}
```

**Response `200 OK`:**
```json
{
    "id": 3,
    "student_number": "2026-0002",
    "first_name": "Maria",
    "last_name": "Santos-Reyes",
    "email": "maria.santos@example.com",
    "course": "BSIT",
    "year_level": "2nd Year",
    "created_at": "2026-11-01T07:37:22.000000Z",
    "updated_at": "2026-11-01T07:38:10.000000Z"
}
```

### `DELETE /api/students/{id}` — delete a student

**Request:** no body.

**Response `200 OK`:**
```json
{
    "message": "Student deleted successfully."
}
```

A ready-to-import Postman collection with all 5 requests pre-configured is
included at [`SIMS.postman_collection.json`](SIMS.postman_collection.json).

## Running the Automated Tests

```bash
php artisan test
```

Tests run against an isolated **SQLite in-memory** database (configured in
`phpunit.xml`), so running them never touches your real `sims_db` MySQL
database. Current suite: 36 tests covering authentication, profile
management, and the Student module (listing, create/validation, admin
delete, staff delete → 403).

## Folder Structure Overview

```
app/
  Http/
    Controllers/        Web controllers (Student, Subject, Enrollment, Dashboard, Profile)
    Controllers/Api/     API controllers (Student) — separate from web controllers
    Middleware/          AdminMiddleware (role gate, alias "admin")
  Models/                Eloquent models: User, Student, Subject, Enrollment
database/
  migrations/            Schema for users, students, subjects, enrollments, etc.
  sims_db.sql            Full database export (schema + data) for this submission
resources/
  views/
    layouts/app.blade.php   Shared authenticated app shell (sidebar, header, flash messages)
    students/, subjects/, enrollments/   CRUD views per module (index/create/edit/_form)
    dashboard.blade.php     Dashboard with stat cards and breakdowns
public/
  css/custom.css           Custom Bootstrap-override theme (palette, sidebar, components)
routes/
  web.php                  All authenticated web routes (role-gated destroy routes)
  api.php                  REST API routes (Student resource)
tests/
  Feature/                 StudentTest, AuthTest, plus Breeze's default auth/profile tests
SIMS.postman_collection.json   Importable API test collection
```
