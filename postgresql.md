# PostgreSQL Commands Reference Guide

# Steps to clone Prod Database & data to Local Dev Database

1. Pull data from the prod db using: npx drizzle-kit introspect
2. Uncomment the migration
3. Add addition schema if you need in the schema file
4. If you add new schemas then run npx drizzle-kit generate then npx drizzle-kit migrate
5. Clone on data
   ```bash
   pg_dump "postgresql://neondb_owner:**********************************@ep-proud-cell-ad2hd9t7-pooler.c-2.us-east-1.aws.neon.tech/neondb?sslmode=require" \
   --data-only \
   --no-owner \
   --no-privileges \
   --column-inserts \
   --table=job_posts \
   --file=data_only.sql
   ```
6. Restore the data to your local database
   ```bash
    psql -h localhost -U postgres -d neondb -f data_only.sql
   ```

### Restart Postgres server

net stop postgresql-x64-17
net start postgresql-x64-17

## Understanding the Naming Convention

PostgreSQL's `psql` commands (meta-commands) start with backslash `\` and are named using mnemonics:

- **d** = describe/display
- **l** = list
- **c** = connect
- **+** (plus) = verbose/detailed output
- **S** = show system objects
- **t** = tuple/table-only mode

# Database Connection Commands

## command to run sql files

psql -U postgres -d referral_system -f database-schema-structure.sql

### Forcefully drop database by killing all connections and sessions:

SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = 'referral_system'
AND pid <> pg_backend_pid();

| Command            | What It Does                                   | Why Named This Way          |
| ------------------ | ---------------------------------------------- | --------------------------- |
| `\c [database]`    | **C**onnect to a different database            | **c** = connect             |
| `\conninfo`        | Display current **conn**ection **info**rmation | Abbreviated connection info |
| `\password [user]` | Change user password                           | Self-explanatory            |
| `\q`               | **Q**uit/exit psql                             | **q** = quit                |

## Listing & Discovery Commands

| Command         | What It Does                              | Why Named This Way                     |
| --------------- | ----------------------------------------- | -------------------------------------- |
| `\l` or `\list` | **L**ist all databases                    | **l** = list                           |
| `\l+`           | List databases with extra details         | **+** adds verbose info                |
| `\dt`           | **D**escribe **t**ables (list all tables) | **d** = describe, **t** = tables       |
| `\dt+`          | List tables with sizes and descriptions   | Verbose table listing                  |
| `\di`           | **D**escribe **i**ndexes                  | **i** = indexes                        |
| `\ds`           | **D**escribe **s**equences                | **s** = sequences                      |
| `\dv`           | **D**escribe **v**iews                    | **v** = views                          |
| `\dm`           | **D**escribe **m**aterialized views       | **m** = materialized views             |
| `\df`           | **D**escribe **f**unctions                | **f** = functions                      |
| `\dT`           | **D**escribe **T**ypes (data types)       | **T** = types (capital for user types) |
| `\dn`           | **D**escribe **n**amespaces (schemas)     | **n** = namespaces                     |
| `\du`           | **D**escribe **u**sers (roles)            | **u** = users                          |
| `\du+`          | List users with detailed attributes       | Verbose user info - **YOUR QUESTION!** |
| `\db`           | **D**escribe ta**b**lespaces              | **b** = tablespaces                    |
| `\dg`           | **D**escribe **g**roups (same as \du)     | **g** = groups                         |

## Schema & Table Details

| Command       | What It Does                                               | Why Named This Way                            |
| ------------- | ---------------------------------------------------------- | --------------------------------------------- |
| `\d [table]`  | **D**escribe table structure (columns, types, constraints) | **d** = describe                              |
| `\d+`         | Describe with storage and statistics                       | Verbose describe                              |
| `\dt *.*`     | List tables in all schemas                                 | _._ = all schemas                             |
| `\dtS`        | List system tables                                         | **S** = show system objects                   |
| `\dp [table]` | **D**escribe **p**rivileges (access permissions)           | **p** = privileges                            |
| `\ddp`        | List default privileges                                    | **d** = describe, **dp** = default privileges |
| `\dE`         | **D**escribe foreign tables                                | **E** = external tables                       |

# DROP TABLE OPERATIONS

### Drop only the foreign key

ALTER TABLE posts DROP CONSTRAINT posts_user_id_fkey;

Then drop the table:

DROP TABLE users;

### Drop the users table and all dependent objects

This will drop users AND automatically drop the foreign key in the posts table:

DROP TABLE users CASCADE;

ALTER TABLE <table_name> DROP CONSTRAINT <constraint_name>;

SELECT \*
FROM pg_catalog.pg_constraint
WHERE confrelid = 'users'::regclass;

## SQL Execution & Files

| Command          | What It Does                                | Why Named This Way              |
| ---------------- | ------------------------------------------- | ------------------------------- |
| `\i [file]`      | Execute SQL from **i**nput file             | **i** = input                   |
| `\ir [file]`     | Execute file **r**elative to current script | **i** = input, **r** = relative |
| `\o [file]`      | Send query results to **o**utput file       | **o** = output                  |
| `\o`             | Stop writing to file (back to screen)       | Toggle output                   |
| `\w [file]`      | **W**rite query buffer to file              | **w** = write                   |
| `\e`             | **E**dit query in external editor           | **e** = edit                    |
| `\ef [function]` | **E**dit **f**unction definition            | **e** = edit, **f** = function  |

## Display & Formatting

| Command          | What It Does                               | Why Named This Way  |
| ---------------- | ------------------------------------------ | ------------------- |
| `\x`             | Toggle e**x**panded/vertical display mode  | **x** = expanded    |
| `\a`             | Toggle **a**ligned/unaligned output        | **a** = aligned     |
| `\t`             | Toggle **t**uples-only mode (hide headers) | **t** = tuples only |
| `\pset [option]` | Set output formatting options              | **p** = print set   |
| `\H`             | Toggle **H**TML output                     | **H** = HTML        |
| `\timing`        | Toggle query execution timing              | Self-explanatory    |

## Query Buffer Management

| Command     | What It Does                           | Why Named This Way           |
| ----------- | -------------------------------------- | ---------------------------- |
| `\p`        | **P**rint current query buffer         | **p** = print                |
| `\r`        | **R**eset (clear) query buffer         | **r** = reset                |
| `\s [file]` | Display or **s**ave command history    | **s** = show/save history    |
| `\g`        | Execute current query (like semicolon) | **g** = go                   |
| `\gx`       | Execute and display results expanded   | **g** = go, **x** = expanded |

## Variables & Settings

| Command              | What It Does          | Why Named This Way   |
| -------------------- | --------------------- | -------------------- |
| `\set [var] [value]` | Set psql variable     | Self-explanatory     |
| `\unset [var]`       | Remove variable       | Self-explanatory     |
| `\echo [text]`       | Print text to screen  | Self-explanatory     |
| `\! [command]`       | Execute shell command | **!** = shell escape |

## Help Commands

| Command            | What It Does                | Why Named This Way                  |
| ------------------ | --------------------------- | ----------------------------------- |
| `\?`               | Show help on psql commands  | **?** = help (universal convention) |
| `\h [SQL command]` | Show **h**elp on SQL syntax | **h** = help                        |
| `\h`               | List all SQL commands       | Help overview                       |

## Common Combinations

| Command         | What It Does                             |
| --------------- | ---------------------------------------- |
| `\dt+ schema.*` | List all tables in schema with sizes     |
| `\d+ tablename` | Full table description with storage info |
| `\du+ postgres` | Detailed info about specific user        |
| `\dn+`          | List schemas with permissions and sizes  |

## Pro Tips

1. **Adding `+` to most commands gives verbose output** - more columns, descriptions, sizes
2. **Adding `S` shows system objects** (e.g., `\dtS` shows system tables)
3. **Pattern matching works**: `\dt user*` lists tables starting with "user"
4. **Use `\?` anytime** you forget commands - it's your quick reference
5. **Case matters**: `\dT` (types) is different from `\dt` (tables)

## Your Specific Question: `\du+`

**`\du+`** = **D**escribe **U**sers with **+** verbose details

This shows:

- Role names
- Member of (role memberships)
- Attributes (SUPERUSER, LOGIN, CREATEDB, etc.)
- Description (if any)

Without `+`, you just get role name and attributes. With `+`, you get the full picture including role memberships and descriptions.

### FTS

- SELECT to_tsvector('english', 'Senior Python Developer remote job');
- SELECT to_tsquery('english', 'python & senior');
- SELECT to_tsvector('english', 'Senior Python Developer')
-        @@ to_tsquery('python & senior');

### FTS search

select location, title, description_text from job_posts where to_tsvector('english', description_text) @@ to_tsquery('english', 'software <2> engineer') limit 100;

### FTS INDEXING

```bash

CREATE INDEX job_posts_search_idx
ON job_posts USING GIN (to_tsvector('english', description_text));

CREATE INDEX job_posts_search_idx
ON job_posts USING GIN (
    to_tsvector(
        'english',
        coalesce(title, '') || ' ' || coalesce(description_text, '')
    )
);




SELECT
    company_name,
    ts_rank(fts, query,32) AS rank
FROM
    job_posts,
    websearch_to_tsquery('english', 'python engineer') query
WHERE
    fts @@ query
ORDER BY
    rank DESC;


SELECT
  company_name,
  ts_rank(
    setweight(to_tsvector('english', coalesce(title, '')), 'A') ||
    setweight(to_tsvector('english', coalesce(description_text, '')), 'B'),
    query,
    32
  ) AS rank
FROM job_posts,
     websearch_to_tsquery('english', 'python engineer') query
WHERE fts @@ query
ORDER BY rank DESC;


SELECT
    id,
    title,
    company_name,
    ts_rank_cd(fts, query) AS rank
FROM
    job_posts,
    websearch_to_tsquery('english', 'senior python engineer') query
WHERE
    fts @@ query
ORDER BY
    rank DESC
LIMIT 20;

-- Normalize by document length
ts_rank(fts, query, 1)  -- Divides rank by 1 + log(document length)
ts_rank(fts, query, 2)  -- Divides by document length
ts_rank(fts, query, 4)  -- Divides by mean harmonic distance
ts_rank(fts, query, 8)  -- Divides by number of unique words
ts_rank(fts, query, 16) -- Divides by 1 + log(unique words)
ts_rank(fts, query, 32) -- Divides by rank itself + 1

-- Combine multiple normalizations
ts_rank(fts, query, 1|2|8)  -- Apply normalizations 1, 2, and 8


ALTER TABLE job_posts DROP COLUMN fts;

ALTER TABLE job_posts ADD COLUMN fts tsvector
GENERATED ALWAYS AS (
    setweight(to_tsvector('english', COALESCE(title, '')), 'A') ||
    setweight(to_tsvector('english', COALESCE(job_function, '')), 'B') ||
    setweight(to_tsvector('english', COALESCE(company_name, '')), 'B') ||
    setweight(to_tsvector('english', COALESCE(description_text, '')), 'C')
) STORED;


CREATE INDEX job_posts_fts_idx ON job_posts USING gin(fts);


SELECT
    id,
    title,
    ts_rank(fts, query) AS rank  -- Automatically uses weights!
FROM
    job_posts,
    websearch_to_tsquery('english', 'python developer') query
WHERE
    fts @@ query
ORDER BY
    rank DESC;
```

# ⭐ PG_DUMP COMPLETE CHEAT SHEET

## 1. Basic Full Database Backup

Backup schema + data of the whole database:

pg_dump -U postgres -d dbname > backup.sql

2. Backup With Compression

Compress using gzip:

pg_dump -U postgres -d dbname | gzip > backup.sql.gz

Restore:

gunzip backup.sql.gz
psql -U postgres -d dbname < backup.sql

## 3. Schema-Only Dump (structure only)

No data — only CREATE TABLE, CREATE INDEX, constraints:

pg_dump -U postgres -d dbname --schema-only > schema.sql

## 4. Data-Only Dump

No table structure — just the INSERT statements:

pg_dump -U postgres -d dbname --data-only > data.sql

## 5. Dump a Single Table

Schema + data:

pg_dump -U postgres -d dbname -t table_name > table.sql

Schema-only for that table:

pg_dump -U postgres -d dbname -t table_name --schema-only > table_schema.sql

## 6. Dump Multiple Tables

pg_dump -U postgres -d dbname -t users -t posts -t comments > partial.sql

## 7. Exclude Tables

pg_dump -U postgres -d dbname --exclude-table=logs > no_logs.sql

Multiple exclusions:

pg*dump -U postgres -d dbname \
 --exclude-table=temp*\* \
 --exclude-table=logs \

> filtered.sql

## 8. Dump Only a Schema

Example: dump only the public schema:

pg_dump -U postgres -d dbname -n public > public_schema.sql

Exclude a schema:

pg_dump -U postgres -d dbname -N test_schema > no_test_schema.sql

## 9. Dump With Roles and Ownership

Useful for migrating servers:

pg_dump -U postgres -d dbname --create --clean > full_with_roles.sql

--create adds CREATE DATABASE

--clean adds DROP DATABASE, DROP TABLE, etc.

## 10. Parallel Dumping (FASTEST)

This produces the directory format, required for parallel jobs:

pg_dump -U postgres -d dbname -j 4 -F d -f dump_dir

Restore:

pg_restore -U postgres -d dbname -j 4 dump_dir

## 11. Custom Format Dump

Custom binary dump (best for large DBs):

pg_dump -U postgres -d dbname -F c -f backup.dump

Restore:

pg_restore -U postgres -d newdb backup.dump

## 12. Directory Format Dump

Great for huge databases:

pg_dump -U postgres -d dbname -F d -f backup_dir

## 13. Dump Specific Data Using a Query

pg_dump -U postgres -d dbname --table=users --where="is_active = true" > active_users.sql

## 14. Dump Without Privileges / Grants

pg_dump -U postgres -d dbname --no-privileges > no_privs.sql

## 15. Dump Without Ownership Statements

Useful when restoring to a different user:

pg_dump -U postgres -d dbname --no-owner > backup.sql

## 16. Dump Only Table Definitions (no indexes)

pg_dump -U postgres -d dbname --section=pre-data > only_defs.sql

Dump only indexes & constraints:

pg_dump -U postgres -d dbname --section=post-data > only_indexes.sql

Dump only data:

pg_dump -U postgres -d dbname --section=data > data_only.sql

## 17. Dump Without Comments

pg_dump -U postgres -d dbname --no-comments > clean.sql

## 18. Dump Large Objects (BLOBs)

Enabled by default, but you can explicitly include them:

pg_dump -U postgres -d dbname --blobs > blob_dump.sql

## 19. Dump Only BLOBs

pg_dump -U postgres -d dbname --section=blobs > only_blobs.sql

## 20. Show Help (All Options)

pg_dump --help

# To Understand the Database Structure before running pg_dump or drizzle-kit introspect run the command below

First, connect to your Neon database and run these queries to understand what you're working with:

### 1. Check Database Owner and Basic Info

```bash
-- Get database information
SELECT
    datname as database_name,
    pg_catalog.pg_get_userbyid(datdba) as owner,
    encoding,
    datcollate as collation,
    datctype as ctype
FROM pg_catalog.pg_database
WHERE datname = 'neondb';
```

### 2. List All Roles/Users

```bash
-- Get all roles and their attributes
SELECT
    rolname as role_name,
    rolsuper as is_superuser,
    rolinherit as can_inherit,
    rolcreaterole as can_create_role,
    rolcreatedb as can_create_db,
    rolcanlogin as can_login,
    rolreplication as is_replication_role
FROM pg_catalog.pg_roles
ORDER BY rolname;
```

### 3. Check Schema Ownership

```bash
-- Get schema owners
SELECT
    schema_name,
    schema_owner
FROM information_schema.schemata
WHERE schema_name NOT IN ('pg_catalog', 'information_schema')
ORDER BY schema_name;
```

### 4. Check Table Ownership and Privileges

```bash
-- Get table ownership and privileges
SELECT
    schemaname,
    tablename,
    tableowner,
    pg_catalog.array_to_string(ARRAY(
        SELECT privilege_type
        FROM information_schema.table_privileges tp
        WHERE tp.table_schema = schemaname
        AND tp.table_name = tablename
    ), ', ') as privileges
FROM pg_catalog.pg_tables
WHERE schemaname NOT IN ('pg_catalog', 'information_schema')
ORDER BY schemaname, tablename;
```

### 5. Check Extensions

```bash
-- List installed extensions
SELECT
    extname as extension_name,
    extversion as version,
    nspname as schema
FROM pg_extension e
JOIN pg_namespace n ON e.extnamespace = n.oid
ORDER BY extname;
```

### 6. Check Role Memberships

```bash
-- Get role memberships (which roles belong to which groups)
SELECT
    r.rolname as role,
    m.rolname as member_of
FROM pg_catalog.pg_roles r
JOIN pg_catalog.pg_auth_members am ON r.oid = am.member
JOIN pg_catalog.pg_roles m ON am.roleid = m.oid
ORDER BY r.rolname;
```
