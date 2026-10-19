
-- select * from job_recommendations jr
-- left join job_posts jp
-- on jr.job_id = jp.id
-- where jr.user_id = 'bc8a3426-8e08-49b6-80bc-427a5817bf6f' limit 5;

-- select distinct(user_id)  from job_recommendations;
select * from resumes where id = 'fa9e94c2-1957-4bd4-9d2d-a5fc453b8799'
-- select * from resumes 
-- join
-- user_skills
-- on resumes.user_id = user_skills.user_id
-- where resumes.user_id = 'bc8a3426-8e08-49b6-80bc-427a5817bf6f';

-- DO $$
-- DECLARE
--     r RECORD;
--     uid UUID := '1955cc52-c93f-4b6d-8214-918901683dc6';
-- BEGIN
--     FOR r IN
--         SELECT table_schema, table_name
--         FROM information_schema.columns
--         WHERE column_name = 'user_id'
--           AND table_schema = 'public'
--     LOOP
--         EXECUTE format(
--             'DELETE FROM %I.%I WHERE user_id = $1',
--             r.table_schema,
--             r.table_name
--         )
--         USING uid;
--     END LOOP;

--     DELETE FROM users WHERE id = uid;
-- END $$;


-- DO $$
-- DECLARE
--     r RECORD;
--     row_count INTEGER;
-- BEGIN
--     CREATE TEMP TABLE IF NOT EXISTS table_counts (
--         table_name TEXT,
--         status TEXT,
--         row_count INTEGER
--     );
    
--     TRUNCATE TABLE table_counts;
    
--     FOR r IN 
--         SELECT tablename 
--         FROM pg_tables 
--         WHERE schemaname = 'public'
--     LOOP
--         EXECUTE format('SELECT COUNT(*) FROM %I.%I', 'public', r.tablename) 
--         INTO row_count;
        
--         INSERT INTO table_counts 
--         VALUES (
--             r.tablename, 
--             CASE WHEN row_count = 0 THEN 'EMPTY' ELSE 'HAS DATA' END,
--             row_count
--         );
--     END LOOP;
    
--     RAISE NOTICE 'Table counts generated successfully';
-- END $$;


-- select * from table_counts

-- select * from user_employment_type_preferences

-- WITH user_uuid AS (
--     SELECT 'e1438325-81b1-4ab8-90e0-7d01c67e8036'::UUID AS id
-- )
-- SELECT 
--     'employment_preference' AS table_name,
--     COUNT(*) AS record_count,
--     jsonb_agg(
--         to_jsonb(empp.*) ORDER BY empp.created_at DESC NULLS LAST
--     ) AS data
-- FROM user_employment_type_preferences empp, user_uuid
-- WHERE empp.id = user_uuid.id
-- GROUP BY 1

-- select * from information_schema.referential_constraints

-- SELECT
--     schemaname,
--     relname AS table_name,
--     n_live_tup AS estimated_rows
-- FROM pg_stat_user_tables
-- ORDER BY n_live_tup DESC;

-- select tablename from pg_tables where schemaname = 'public';
-- select * from information_schema.columns