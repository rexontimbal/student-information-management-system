# Deploying SIMS Live (Free) — Render + Clever Cloud MySQL

This deploys the app using Docker on Render (free web service) with a free MySQL
database on Clever Cloud, as described in `docker/` and the project `Dockerfile`.

**Heads up on the free tiers:**
- Render's free web service **sleeps after ~15 minutes of no traffic** and takes
  ~30–60s to wake back up on the next request. Expected — not a bug.
- Clever Cloud's free `DEV` MySQL plan is for testing only (low performance, no
  backups, no SLA). Fine for a class demo; don't rely on it for real data.

---

## 1. Create the free MySQL database (Clever Cloud)

1. Go to <https://www.clever-cloud.com/> and sign up (free, no card required for
   the DEV plan).
2. In the console, click **Create** → **an add-on** → **MySQL**.
3. Pick the **DEV** plan (free) and create it.
4. Open the add-on → **Information** tab. Note down:
   - Host
   - Port
   - Database name
   - User
   - Password
   (Clever Cloud shows these as a single `mysql://user:pass@host:port/db` URL too —
   either form works, you'll split it into the variables below.)

## 2. Push this repo to GitHub

Already done — <https://github.com/rexontimbal/student-information-management-system>.
Render deploys straight from the GitHub repo, so just make sure your latest
commit (with `Dockerfile` and `docker/`) is pushed.

## 3. Generate a production APP_KEY

Run this locally and copy the output (starts with `base64:`):

```bash
php artisan key:generate --show
```

Don't reuse your local `.env`'s key for anything sensitive beyond this project —
treat it as the production secret from here on.

## 4. Create the Web Service on Render

1. Go to <https://dashboard.render.com/> and sign up (free, no card required for
   the free web service tier).
2. **New** → **Web Service** → connect your GitHub account → pick
   `student-information-management-system`.
3. Render will detect the `Dockerfile` automatically. Set:
   - **Name:** `sims` (or whatever you like — becomes part of the URL)
   - **Region:** closest to you
   - **Branch:** `main`
   - **Instance Type:** **Free**
4. Under **Environment Variables**, add:

   | Key | Value |
   |---|---|
   | `APP_NAME` | `SIMS` |
   | `APP_ENV` | `production` |
   | `APP_DEBUG` | `false` |
   | `APP_KEY` | *(the `base64:...` value from step 3)* |
   | `APP_URL` | `https://<your-render-service-name>.onrender.com` |
   | `DB_CONNECTION` | `mysql` |
   | `DB_HOST` | *(Clever Cloud host)* |
   | `DB_PORT` | *(Clever Cloud port, usually 3306)* |
   | `DB_DATABASE` | *(Clever Cloud database name)* |
   | `DB_USERNAME` | *(Clever Cloud user)* |
   | `DB_PASSWORD` | *(Clever Cloud password)* |
   | `SESSION_DRIVER` | `database` |
   | `CACHE_STORE` | `database` |
   | `QUEUE_CONNECTION` | `database` |
   | `LOG_CHANNEL` | `stderr` |

   (You can leave `APP_URL` blank on the very first deploy and come back to set
   it once Render assigns your `.onrender.com` subdomain — then redeploy.)

5. Click **Create Web Service**. Render will build the Docker image and deploy.
   First build takes a few minutes (installing PHP extensions + Composer deps).

## 5. What happens automatically on every deploy

`docker/deploy.sh` runs before the app starts and:
- Caches config/routes/views
- Runs `php artisan migrate --force` against your Clever Cloud database

So your `students`, `subjects`, `enrollments`, `users`, `cache`, `sessions`
tables etc. get created automatically on first boot — no manual `artisan
migrate` needed.

## 6. Seed an admin user (one-time)

Render's free plan doesn't give you persistent shell access the same way a paid
plan does, so the simplest one-time way to get your first admin account is to
**temporarily** add a `php artisan tinker`-equivalent route, or just register a
normal account through `/register` on the live site and then promote it:

- Easiest: open the Clever Cloud MySQL console (phpMyAdmin-style access or the
  `mysql` CLI via the connection info from step 1) and run:
  ```sql
  UPDATE users SET role = 'admin' WHERE email = 'you@example.com';
  ```
  after registering that account through the live site's `/register` page.

## 7. Verify it's live

- Visit `https://<your-service-name>.onrender.com`
- Register → promote yourself to admin (step 6) → log back in
- Confirm Students/Subjects/Enrollments CRUD and the REST API
  (`/api/students`) work against the live Clever Cloud database

## 8. For your submission

Put the live URL in your `README.md` and mention it in `REFLECTION.pdf` /
during the oral defense — this satisfies the rubric's **Deployment (+2 bonus)**
criterion ("Successfully deployed online").
