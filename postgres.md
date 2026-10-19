In `psql`:

```sql
\dn
```

Lists all schemas.

```sql
\dt schema_name.*
```

Lists all tables inside a specific schema.

Examples:

```sql
\dt public.*
\dt identity.*
```

To list tables across all schemas:

```sql
\dt *.*
```

For detailed table information:

```sql
\d+ schema_name.table_name
```

For table statistics such as row counts and tuple activity:

```sql
SELECT schemaname, relname AS table_name, n_live_tup, n_dead_tup, n_tup_ins, n_tup_upd, n_tup_del FROM pg_stat_user_tables ORDER BY schemaname, relname;
```

For one schema:

```sql
SELECT *
FROM pg_stat_user_tables
WHERE schemaname = 'public';
```

Useful `psql` commands:

```psql
\d+ schema_name.table_name
```

Shows a table’s columns, indexes, size, and metadata.

```psql
\dn+
```

Shows schemas and their descriptions/permissions.

```psql
\dt+ schema_name.*
```

Lists tables in a schema, including their sizes.

`n_live_tup` and `n_dead_tup` are estimates maintained by PostgreSQL’s statistics collector, not exact row counts.

Use:

```psql
\dt *.*
```

This lists every table with its schema:

```text
 Schema |      Name       | Type  | Owner
--------+----------------+-------+-------
 public | users          | table | ...
 auth   | sessions       | table | ...
```

For tables in one schema:

```psql
\dt schema_name.*
```

PostgreSQL does not have a single `\dn` command that nests tables beneath each schema; `\dt *.*` is the closest built-in command.

