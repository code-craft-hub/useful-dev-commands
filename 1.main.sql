-- select * from user_referrals where user_id = '653de96b-129c-4bb5-9e38-9212f27d7438';

WITH user_uuid AS (
    SELECT '2c3cda2d-2d93-4ae8-ba91-5c305044df1c'::UUID AS id
)
SELECT 
    'users' AS table_name,
    COUNT(*) AS record_count,
    jsonb_agg(
        to_jsonb(u.*) ORDER BY u.created_at DESC NULLS LAST
    ) AS data
FROM users u, user_uuid
WHERE u.id = user_uuid.id
GROUP BY 1

UNION ALL


SELECT 
    'user_work_location_preferences' AS table_name,
    COUNT(*) AS record_count,
    jsonb_agg(
        to_jsonb(uwlp.*) ORDER BY uwlp.created_at DESC NULLS LAST
    ) AS data
FROM user_work_location_preferences uwlp, user_uuid
WHERE uwlp.user_id = user_uuid.id
GROUP BY 1

UNION ALL

SELECT 
    'employment_preference' AS table_name,
    COUNT(*) AS record_count,
    jsonb_agg(
        to_jsonb(empp.*) ORDER BY empp.created_at DESC NULLS LAST
    ) AS data
FROM user_employment_type_preferences empp, user_uuid
WHERE empp.user_id = user_uuid.id
GROUP BY 1

UNION ALL

SELECT 
    'user_discovery_sources' AS table_name,
    COUNT(*) AS record_count,
    jsonb_agg(
        to_jsonb(uds.*) ORDER BY uds.created_at DESC NULLS LAST
    ) AS data
FROM user_discovery_sources uds, user_uuid
WHERE uds.user_id = user_uuid.id
GROUP BY 1


UNION ALL



SELECT 
    'user_issues' AS table_name,
    COUNT(*) AS record_count,
    jsonb_agg(
        to_jsonb(uissu.*) ORDER BY uissu.created_at DESC NULLS LAST
    ) AS data
FROM user_issues uissu, user_uuid
WHERE uissu.user_id = user_uuid.id
GROUP BY 1


UNION ALL


SELECT 
    'user_profiles' AS table_name,
    COUNT(*) AS record_count,
    jsonb_agg(
        to_jsonb(up.*) ORDER BY up.updated_at DESC NULLS LAST
    ) AS data
FROM user_profiles up, user_uuid
WHERE up.user_id = user_uuid.id
GROUP BY 1

UNION ALL

SELECT 
    'user_contacts' AS table_name,
    COUNT(*) AS record_count,
    jsonb_agg(
        to_jsonb(uc.*) ORDER BY uc.created_at DESC NULLS LAST
    ) AS data
FROM user_contacts uc, user_uuid
WHERE uc.user_id = user_uuid.id
GROUP BY 1

UNION ALL

SELECT 
    'user_preferences' AS table_name,
    COUNT(*) AS record_count,
    jsonb_agg(
        to_jsonb(upref.*) ORDER BY upref.updated_at DESC NULLS LAST
    ) AS data
FROM user_preferences upref, user_uuid
WHERE upref.user_id = user_uuid.id
GROUP BY 1

UNION ALL

SELECT 
    'sessions' AS table_name,
    COUNT(*) AS record_count,
    jsonb_agg(
        to_jsonb(s.*) ORDER BY s.created_at DESC NULLS LAST
    ) AS data
FROM sessions s, user_uuid
WHERE s.user_id = user_uuid.id
GROUP BY 1

UNION ALL

SELECT 
    'user_sessions' AS table_name,
    COUNT(*) AS record_count,
    jsonb_agg(
        to_jsonb(us.*) ORDER BY us.created_at DESC NULLS LAST
    ) AS data
FROM user_sessions us, user_uuid
WHERE us.user_id = user_uuid.id
GROUP BY 1

UNION ALL

SELECT 
    'verification_tokens' AS table_name,
    COUNT(*) AS record_count,
    jsonb_agg(
        to_jsonb(vt.*) ORDER BY vt.created_at DESC NULLS LAST
    ) AS data
FROM verification_tokens vt, user_uuid
WHERE vt.user_id = user_uuid.id
GROUP BY 1

UNION ALL

SELECT 
    'work_experiences' AS table_name,
    COUNT(*) AS record_count,
    jsonb_agg(
        to_jsonb(we.*) ORDER BY we.start_date DESC NULLS LAST
    ) AS data
FROM work_experiences we, user_uuid
WHERE we.user_id = user_uuid.id
GROUP BY 1

UNION ALL

SELECT 
    'educations' AS table_name,
    COUNT(*) AS record_count,
    jsonb_agg(
        to_jsonb(e.*) ORDER BY e.start_date DESC NULLS LAST
    ) AS data
FROM educations e, user_uuid
WHERE e.user_id = user_uuid.id
GROUP BY 1

UNION ALL

SELECT 
    'certifications' AS table_name,
    COUNT(*) AS record_count,
    jsonb_agg(
        to_jsonb(c.*) ORDER BY c.issue_date DESC NULLS LAST
    ) AS data
FROM certifications c, user_uuid
WHERE c.user_id = user_uuid.id
GROUP BY 1

UNION ALL

SELECT 
    'projects' AS table_name,
    COUNT(*) AS record_count,
    jsonb_agg(
        to_jsonb(p.*) ORDER BY p.start_date DESC NULLS LAST
    ) AS data
FROM projects p, user_uuid
WHERE p.user_id = user_uuid.id
GROUP BY 1

UNION ALL

SELECT 
    'user_skills' AS table_name,
    COUNT(*) AS record_count,
    jsonb_agg(
        to_jsonb(usk.*) ORDER BY usk.created_at DESC NULLS LAST
    ) AS data
FROM user_skills usk, user_uuid
WHERE usk.user_id = user_uuid.id
GROUP BY 1

UNION ALL

SELECT 
    'resumes' AS table_name,
    COUNT(*) AS record_count,
    jsonb_agg(
        to_jsonb(r.*) ORDER BY r.created_at DESC NULLS LAST
    ) AS data
FROM resumes r, user_uuid
WHERE r.user_id = user_uuid.id
GROUP BY 1

UNION ALL

SELECT 
    'cover_letters' AS table_name,
    COUNT(*) AS record_count,
    jsonb_agg(
        to_jsonb(cl.*) ORDER BY cl.created_at DESC NULLS LAST
    ) AS data
FROM cover_letters cl, user_uuid
WHERE cl.user_id = user_uuid.id
GROUP BY 1

UNION ALL

SELECT 
    'job_applications' AS table_name,
    COUNT(*) AS record_count,
    jsonb_agg(
        to_jsonb(ja.*) ORDER BY ja.created_at DESC NULLS LAST
    ) AS data
FROM job_applications ja, user_uuid
WHERE ja.user_id = user_uuid.id
GROUP BY 1


UNION ALL

SELECT 
    'bookmarked_jobs' AS table_name,
    COUNT(*) AS record_count,
    jsonb_agg(
        to_jsonb(bj.*) ORDER BY bj.created_at DESC NULLS LAST
    ) AS data
FROM bookmarked_jobs bj, user_uuid
WHERE bj.user_id = user_uuid.id
GROUP BY 1

UNION ALL

SELECT 
    'job_recommendations' AS table_name,
    COUNT(*) AS record_count,
    jsonb_agg(
        to_jsonb(jr.*) ORDER BY jr.created_at DESC NULLS LAST
    ) AS data
FROM job_recommendations jr, user_uuid
WHERE jr.user_id = user_uuid.id
GROUP BY 1

UNION ALL

SELECT 
    'job_clicks' AS table_name,
    COUNT(*) AS record_count,
    jsonb_agg(
        to_jsonb(jc.*) ORDER BY jc.created_at DESC NULLS LAST
    ) AS data
FROM job_clicks jc, user_uuid
WHERE jc.user_id = user_uuid.id
GROUP BY 1

UNION ALL

SELECT 
    'job_views' AS table_name,
    COUNT(*) AS record_count,
    jsonb_agg(
        to_jsonb(jv.*) ORDER BY jv.created_at DESC NULLS LAST
    ) AS data
FROM job_views jv, user_uuid
WHERE jv.user_id = user_uuid.id
GROUP BY 1

UNION ALL

SELECT 
    'ai_apply_settings' AS table_name,
    COUNT(*) AS record_count,
    jsonb_agg(
        to_jsonb(aas.*) ORDER BY aas.updated_at DESC NULLS LAST
    ) AS data
FROM ai_apply_settings aas, user_uuid
WHERE aas.user_id = user_uuid.id
GROUP BY 1

UNION ALL

SELECT 
    'chat_history' AS table_name,
    COUNT(*) AS record_count,
    jsonb_agg(
        to_jsonb(ch.*) ORDER BY ch.created_at DESC NULLS LAST
    ) AS data
FROM chat_history ch, user_uuid
WHERE ch.user_id = user_uuid.id
GROUP BY 1

UNION ALL

SELECT 
    'processing_queue' AS table_name,
    COUNT(*) AS record_count,
    jsonb_agg(
        to_jsonb(pq.*) ORDER BY pq.created_at DESC NULLS LAST
    ) AS data
FROM processing_queue pq, user_uuid
WHERE pq.user_id = user_uuid.id
GROUP BY 1

UNION ALL

SELECT 
    'user_subscriptions' AS table_name,
    COUNT(*) AS record_count,
    jsonb_agg(
        to_jsonb(usub.*) ORDER BY usub.created_at DESC NULLS LAST
    ) AS data
FROM user_subscriptions usub, user_uuid
WHERE usub.user_id = user_uuid.id
GROUP BY 1

UNION ALL

SELECT 
    'user_credits' AS table_name,
    COUNT(*) AS record_count,
    jsonb_agg(
        to_jsonb(ucr.*) ORDER BY ucr.created_at DESC NULLS LAST
    ) AS data
FROM user_credits ucr, user_uuid
WHERE ucr.user_id = user_uuid.id
GROUP BY 1

UNION ALL

SELECT 
    'credit_transactions' AS table_name,
    COUNT(*) AS record_count,
    jsonb_agg(
        to_jsonb(ct.*) ORDER BY ct.created_at DESC NULLS LAST
    ) AS data
FROM credit_transactions ct, user_uuid
WHERE ct.user_id = user_uuid.id
GROUP BY 1

UNION ALL

SELECT 
    'user_analytics' AS table_name,
    COUNT(*) AS record_count,
    jsonb_agg(
        to_jsonb(ua.*) ORDER BY ua.created_at DESC NULLS LAST
    ) AS data
FROM user_analytics ua, user_uuid
WHERE ua.user_id = user_uuid.id
GROUP BY 1

UNION ALL

SELECT 
    'user_engagement_metrics' AS table_name,
    COUNT(*) AS record_count,
    jsonb_agg(
        to_jsonb(uem.*) ORDER BY uem.created_at DESC NULLS LAST
    ) AS data
FROM user_engagement_metrics uem, user_uuid
WHERE uem.user_id = user_uuid.id
GROUP BY 1

UNION ALL

SELECT 
    'activity_log' AS table_name,
    COUNT(*) AS record_count,
    jsonb_agg(
        to_jsonb(al.*) ORDER BY al.created_at DESC NULLS LAST
    ) AS data
FROM activity_log al, user_uuid
WHERE al.user_id = user_uuid.id
GROUP BY 1

UNION ALL

SELECT 
    'user_onboardings' AS table_name,
    COUNT(*) AS record_count,
    jsonb_agg(
        to_jsonb(uo.*) ORDER BY uo.created_at DESC NULLS LAST
    ) AS data
FROM user_onboardings uo, user_uuid
WHERE uo.user_id = user_uuid.id
GROUP BY 1

UNION ALL

SELECT 
    'user_referrals' AS table_name,
    COUNT(*) AS record_count,
    jsonb_agg(
        to_jsonb(uref.*) ORDER BY uref.updated_at DESC NULLS LAST
    ) AS data
FROM user_referrals uref, user_uuid
WHERE uref.user_id = user_uuid.id 
GROUP BY 1

UNION ALL


SELECT 
    'recommendation_feedback' AS table_name,
    COUNT(*) AS record_count,
    jsonb_agg(
        to_jsonb(rf.*) ORDER BY rf.created_at DESC NULLS LAST
    ) AS data
FROM recommendation_feedback rf, user_uuid
WHERE rf.user_id = user_uuid.id
GROUP BY 1

UNION ALL

SELECT 
    'notifications' AS table_name,
    COUNT(*) AS record_count,
    jsonb_agg(
        to_jsonb(n.*) ORDER BY n.created_at DESC NULLS LAST
    ) AS data
FROM notifications n, user_uuid
WHERE n.user_id = user_uuid.id
GROUP BY 1

UNION ALL

SELECT 
    'interview_questions' AS table_name,
    COUNT(*) AS record_count,
    jsonb_agg(
        to_jsonb(iq.*) ORDER BY iq.created_at DESC NULLS LAST
    ) AS data
FROM interview_questions iq, user_uuid
WHERE iq.user_id = user_uuid.id
GROUP BY 1

ORDER BY table_name;


-- DO $$
-- DECLARE
--     user_uuid UUID := 'a5b3b12c-4aa8-431a-845a-555a698a2575';
-- BEGIN
--     -- Delete in order of foreign key dependencies
--     -- Start with tables that reference other user-related data
--     DELETE FROM job_applications WHERE user_id = user_uuid;
--     DELETE FROM applications WHERE user_id = user_uuid;
--     DELETE FROM job_clicks WHERE user_id = user_uuid;
--     DELETE FROM job_views WHERE user_id = user_uuid;
--     DELETE FROM job_recommendations WHERE user_id = user_uuid;
--     DELETE FROM recommendation_feedback WHERE user_id = user_uuid;
    
--     -- Delete resume-related data (depends on resumes)
--     DELETE FROM user_skills WHERE user_id = user_uuid;
--     DELETE FROM work_experiences WHERE user_id = user_uuid;
--     DELETE FROM certifications WHERE user_id = user_uuid;
--     DELETE FROM projects WHERE user_id = user_uuid;
--     DELETE FROM educations WHERE user_id = user_uuid;
--     DELETE FROM cover_letters WHERE user_id = user_uuid;
    
--     -- Now safe to delete resumes
--     DELETE FROM resumes WHERE user_id = user_uuid;
    
--     -- Delete user-related metadata
--     DELETE FROM user_contacts WHERE user_id = user_uuid;
--     DELETE FROM user_profiles WHERE user_id = user_uuid;
--     DELETE FROM user_subscriptions WHERE user_id = user_uuid;
--     DELETE FROM user_analytics WHERE user_id = user_uuid;
--     DELETE FROM user_preferences WHERE user_id = user_uuid;
--     DELETE FROM user_credits WHERE user_id = user_uuid;
--     DELETE FROM user_onboardings WHERE user_id = user_uuid;
--     DELETE FROM user_referrals WHERE user_id = user_uuid;
--     DELETE FROM ai_apply_settings WHERE user_id = user_uuid;
    
--     -- Delete interaction/activity data
--     DELETE FROM chat_history WHERE user_id = user_uuid;
--     DELETE FROM bookmarked_jobs WHERE user_id = user_uuid;
--     DELETE FROM processing_queue WHERE user_id = user_uuid;
--     DELETE FROM sessions WHERE user_id = user_uuid;
--     DELETE FROM credit_transactions WHERE user_id = user_uuid;
--     DELETE FROM user_sessions WHERE user_id = user_uuid;
--     DELETE FROM verification_tokens WHERE user_id = user_uuid;
--     DELETE FROM notifications WHERE user_id = user_uuid;
--     DELETE FROM user_engagement_metrics WHERE user_id = user_uuid;
--     DELETE FROM interview_questions WHERE user_id = user_uuid;
--     DELETE FROM activity_log WHERE user_id = user_uuid;
    
--     -- Delete referral data (references users table)
--     DELETE FROM referral_rewards WHERE referrer_id = user_uuid OR referred_user_id = user_uuid;
--     DELETE FROM user_referrals WHERE user_id = user_uuid OR referred_by = user_uuid;
    
--     -- Finally, delete the user
--     DELETE FROM users WHERE id = user_uuid;
    
--     RAISE NOTICE 'User % and all related records deleted successfully', user_uuid;
-- END $$;


-- DO $$
-- DECLARE
--     user_uuid UUID := 'a5b3b12c-4aa8-431a-845a-555a698a2575';
--     result RECORD;
-- BEGIN
--     FOR result IN
--         SELECT 
--             'users' AS table_name,
--             COUNT(*) AS record_count,
--             jsonb_agg(
--                 to_jsonb(u.*) ORDER BY u.created_at DESC NULLS LAST
--             ) AS data
--         FROM users u
--         WHERE u.id = user_uuid
--         GROUP BY 1

--         UNION ALL

--         SELECT 
--             'user_profiles' AS table_name,
--             COUNT(*) AS record_count,
--             jsonb_agg(
--                 to_jsonb(up.*) ORDER BY up.updated_at DESC NULLS LAST
--             ) AS data
--         FROM user_profiles up
--         WHERE up.user_id = user_uuid
--         GROUP BY 1

--         UNION ALL

--         SELECT 
--             'user_contacts' AS table_name,
--             COUNT(*) AS record_count,
--             jsonb_agg(
--                 to_jsonb(uc.*) ORDER BY uc.created_at DESC NULLS LAST
--             ) AS data
--         FROM user_contacts uc
--         WHERE uc.user_id = user_uuid
--         GROUP BY 1

--         UNION ALL

--         SELECT 
--             'user_preferences' AS table_name,
--             COUNT(*) AS record_count,
--             jsonb_agg(
--                 to_jsonb(upref.*) ORDER BY upref.updated_at DESC NULLS LAST
--             ) AS data
--         FROM user_preferences upref
--         WHERE upref.user_id = user_uuid
--         GROUP BY 1

--         UNION ALL

--         SELECT 
--             'sessions' AS table_name,
--             COUNT(*) AS record_count,
--             jsonb_agg(
--                 to_jsonb(s.*) ORDER BY s.created_at DESC NULLS LAST
--             ) AS data
--         FROM sessions s
--         WHERE s.user_id = user_uuid
--         GROUP BY 1

--         UNION ALL

--         SELECT 
--             'user_sessions' AS table_name,
--             COUNT(*) AS record_count,
--             jsonb_agg(
--                 to_jsonb(us.*) ORDER BY us.created_at DESC NULLS LAST
--             ) AS data
--         FROM user_sessions us
--         WHERE us.user_id = user_uuid
--         GROUP BY 1

--         UNION ALL

--         SELECT 
--             'verification_tokens' AS table_name,
--             COUNT(*) AS record_count,
--             jsonb_agg(
--                 to_jsonb(vt.*) ORDER BY vt.created_at DESC NULLS LAST
--             ) AS data
--         FROM verification_tokens vt
--         WHERE vt.user_id = user_uuid
--         GROUP BY 1

--         UNION ALL

--         SELECT 
--             'work_experiences' AS table_name,
--             COUNT(*) AS record_count,
--             jsonb_agg(
--                 to_jsonb(we.*) ORDER BY we.start_date DESC NULLS LAST
--             ) AS data
--         FROM work_experiences we
--         WHERE we.user_id = user_uuid
--         GROUP BY 1

--         UNION ALL

--         SELECT 
--             'educations' AS table_name,
--             COUNT(*) AS record_count,
--             jsonb_agg(
--                 to_jsonb(e.*) ORDER BY e.start_date DESC NULLS LAST
--             ) AS data
--         FROM educations e
--         WHERE e.user_id = user_uuid
--         GROUP BY 1

--         UNION ALL

--         SELECT 
--             'certifications' AS table_name,
--             COUNT(*) AS record_count,
--             jsonb_agg(
--                 to_jsonb(c.*) ORDER BY c.issue_date DESC NULLS LAST
--             ) AS data
--         FROM certifications c
--         WHERE c.user_id = user_uuid
--         GROUP BY 1

--         UNION ALL

--         SELECT 
--             'projects' AS table_name,
--             COUNT(*) AS record_count,
--             jsonb_agg(
--                 to_jsonb(p.*) ORDER BY p.start_date DESC NULLS LAST
--             ) AS data
--         FROM projects p
--         WHERE p.user_id = user_uuid
--         GROUP BY 1

--         UNION ALL

--         SELECT 
--             'user_skills' AS table_name,
--             COUNT(*) AS record_count,
--             jsonb_agg(
--                 to_jsonb(usk.*) ORDER BY usk.created_at DESC NULLS LAST
--             ) AS data
--         FROM user_skills usk
--         WHERE usk.user_id = user_uuid
--         GROUP BY 1

--         UNION ALL

--         SELECT 
--             'resumes' AS table_name,
--             COUNT(*) AS record_count,
--             jsonb_agg(
--                 to_jsonb(r.*) ORDER BY r.created_at DESC NULLS LAST
--             ) AS data
--         FROM resumes r
--         WHERE r.user_id = user_uuid
--         GROUP BY 1

--         UNION ALL

--         SELECT 
--             'cover_letters' AS table_name,
--             COUNT(*) AS record_count,
--             jsonb_agg(
--                 to_jsonb(cl.*) ORDER BY cl.created_at DESC NULLS LAST
--             ) AS data
--         FROM cover_letters cl
--         WHERE cl.user_id = user_uuid
--         GROUP BY 1

--         UNION ALL

--         SELECT 
--             'job_applications' AS table_name,
--             COUNT(*) AS record_count,
--             jsonb_agg(
--                 to_jsonb(ja.*) ORDER BY ja.created_at DESC NULLS LAST
--             ) AS data
--         FROM job_applications ja
--         WHERE ja.user_id = user_uuid
--         GROUP BY 1

--         UNION ALL

--         SELECT 
--             'applications' AS table_name,
--             COUNT(*) AS record_count,
--             jsonb_agg(
--                 to_jsonb(app.*) ORDER BY app.created_at DESC NULLS LAST
--             ) AS data
--         FROM applications app
--         WHERE app.user_id = user_uuid
--         GROUP BY 1

--         UNION ALL

--         SELECT 
--             'bookmarked_jobs' AS table_name,
--             COUNT(*) AS record_count,
--             jsonb_agg(
--                 to_jsonb(bj.*) ORDER BY bj.created_at DESC NULLS LAST
--             ) AS data
--         FROM bookmarked_jobs bj
--         WHERE bj.user_id = user_uuid
--         GROUP BY 1

--         UNION ALL

--         SELECT 
--             'job_recommendations' AS table_name,
--             COUNT(*) AS record_count,
--             jsonb_agg(
--                 to_jsonb(jr.*) ORDER BY jr.created_at DESC NULLS LAST
--             ) AS data
--         FROM job_recommendations jr
--         WHERE jr.user_id = user_uuid
--         GROUP BY 1

--         UNION ALL

--         SELECT 
--             'job_clicks' AS table_name,
--             COUNT(*) AS record_count,
--             jsonb_agg(
--                 to_jsonb(jc.*) ORDER BY jc.created_at DESC NULLS LAST
--             ) AS data
--         FROM job_clicks jc
--         WHERE jc.user_id = user_uuid
--         GROUP BY 1

--         UNION ALL

--         SELECT 
--             'job_views' AS table_name,
--             COUNT(*) AS record_count,
--             jsonb_agg(
--                 to_jsonb(jv.*) ORDER BY jv.created_at DESC NULLS LAST
--             ) AS data
--         FROM job_views jv
--         WHERE jv.user_id = user_uuid
--         GROUP BY 1

--         UNION ALL

--         SELECT 
--             'ai_apply_settings' AS table_name,
--             COUNT(*) AS record_count,
--             jsonb_agg(
--                 to_jsonb(aas.*) ORDER BY aas.updated_at DESC NULLS LAST
--             ) AS data
--         FROM ai_apply_settings aas
--         WHERE aas.user_id = user_uuid
--         GROUP BY 1

--         UNION ALL

--         SELECT 
--             'chat_history' AS table_name,
--             COUNT(*) AS record_count,
--             jsonb_agg(
--                 to_jsonb(ch.*) ORDER BY ch.created_at DESC NULLS LAST
--             ) AS data
--         FROM chat_history ch
--         WHERE ch.user_id = user_uuid
--         GROUP BY 1

--         UNION ALL

--         SELECT 
--             'processing_queue' AS table_name,
--             COUNT(*) AS record_count,
--             jsonb_agg(
--                 to_jsonb(pq.*) ORDER BY pq.created_at DESC NULLS LAST
--             ) AS data
--         FROM processing_queue pq
--         WHERE pq.user_id = user_uuid
--         GROUP BY 1

--         UNION ALL

--         SELECT 
--             'user_subscriptions' AS table_name,
--             COUNT(*) AS record_count,
--             jsonb_agg(
--                 to_jsonb(usub.*) ORDER BY usub.created_at DESC NULLS LAST
--             ) AS data
--         FROM user_subscriptions usub
--         WHERE usub.user_id = user_uuid
--         GROUP BY 1

--         UNION ALL

--         SELECT 
--             'user_credits' AS table_name,
--             COUNT(*) AS record_count,
--             jsonb_agg(
--                 to_jsonb(ucr.*) ORDER BY ucr.created_at DESC NULLS LAST
--             ) AS data
--         FROM user_credits ucr
--         WHERE ucr.user_id = user_uuid
--         GROUP BY 1

--         UNION ALL

--         SELECT 
--             'credit_transactions' AS table_name,
--             COUNT(*) AS record_count,
--             jsonb_agg(
--                 to_jsonb(ct.*) ORDER BY ct.created_at DESC NULLS LAST
--             ) AS data
--         FROM credit_transactions ct
--         WHERE ct.user_id = user_uuid
--         GROUP BY 1

--         UNION ALL

--         SELECT 
--             'user_analytics' AS table_name,
--             COUNT(*) AS record_count,
--             jsonb_agg(
--                 to_jsonb(ua.*) ORDER BY ua.created_at DESC NULLS LAST
--             ) AS data
--         FROM user_analytics ua
--         WHERE ua.user_id = user_uuid
--         GROUP BY 1

--         UNION ALL

--         SELECT 
--             'user_engagement_metrics' AS table_name,
--             COUNT(*) AS record_count,
--             jsonb_agg(
--                 to_jsonb(uem.*) ORDER BY uem.created_at DESC NULLS LAST
--             ) AS data
--         FROM user_engagement_metrics uem
--         WHERE uem.user_id = user_uuid
--         GROUP BY 1

--         UNION ALL

--         SELECT 
--             'activity_log' AS table_name,
--             COUNT(*) AS record_count,
--             jsonb_agg(
--                 to_jsonb(al.*) ORDER BY al.created_at DESC NULLS LAST
--             ) AS data
--         FROM activity_log al
--         WHERE al.user_id = user_uuid
--         GROUP BY 1

--         UNION ALL

--         SELECT 
--             'user_onboardings' AS table_name,
--             COUNT(*) AS record_count,
--             jsonb_agg(
--                 to_jsonb(uo.*) ORDER BY uo.created_at DESC NULLS LAST
--             ) AS data
--         FROM user_onboardings uo
--         WHERE uo.user_id = user_uuid
--         GROUP BY 1

--         UNION ALL

--         SELECT 
--             'user_referrals' AS table_name,
--             COUNT(*) AS record_count,
--             jsonb_agg(
--                 to_jsonb(uref.*) ORDER BY uref.updated_at DESC NULLS LAST
--             ) AS data
--         FROM user_referrals uref
--         WHERE uref.user_id = user_uuid 
--         GROUP BY 1

--         UNION ALL

--         SELECT 
--             'referral_rewards' AS table_name,
--             COUNT(*) AS record_count,
--             jsonb_agg(
--                 to_jsonb(rr.*) ORDER BY rr.created_at DESC NULLS LAST
--             ) AS data
--         FROM referral_rewards rr
--         WHERE rr.referrer_id = user_uuid
--         GROUP BY 1

--         UNION ALL

--         SELECT 
--             'recommendation_feedback' AS table_name,
--             COUNT(*) AS record_count,
--             jsonb_agg(
--                 to_jsonb(rf.*) ORDER BY rf.created_at DESC NULLS LAST
--             ) AS data
--         FROM recommendation_feedback rf
--         WHERE rf.user_id = user_uuid
--         GROUP BY 1

--         UNION ALL

--         SELECT 
--             'notifications' AS table_name,
--             COUNT(*) AS record_count,
--             jsonb_agg(
--                 to_jsonb(n.*) ORDER BY n.created_at DESC NULLS LAST
--             ) AS data
--         FROM notifications n
--         WHERE n.user_id = user_uuid
--         GROUP BY 1

--         UNION ALL

--         SELECT 
--             'interview_questions' AS table_name,
--             COUNT(*) AS record_count,
--             jsonb_agg(
--                 to_jsonb(iq.*) ORDER BY iq.created_at DESC NULLS LAST
--             ) AS data
--         FROM interview_questions iq
--         WHERE iq.user_id = user_uuid
--         GROUP BY 1

--         ORDER BY table_name
--     LOOP
--         RAISE NOTICE 'Table: %, Count: %, Data: %', result.table_name, result.record_count, result.data;
--     END LOOP;
-- END $$;


-- SELECT 
--     'users' AS table_name,
--     COUNT(*) AS record_count,
--     jsonb_agg(
--         to_jsonb(u.*) ORDER BY u.created_at DESC NULLS LAST
--     ) AS data
-- FROM users u
-- WHERE u.id = 'a5b3b12c-4aa8-431a-845a-555a698a2575'
-- GROUP BY 1

-- UNION ALL

-- -- 2. User Profiles
-- SELECT 
--     'user_profiles' AS table_name,
--     COUNT(*) AS record_count,
--     jsonb_agg(
--         to_jsonb(up.*) ORDER BY up.updated_at DESC NULLS LAST
--     ) AS data
-- FROM user_profiles up
-- WHERE up.user_id = 'a5b3b12c-4aa8-431a-845a-555a698a2575'
-- GROUP BY 1

-- UNION ALL

-- -- 3. User Contacts
-- SELECT 
--     'user_contacts' AS table_name,
--     COUNT(*) AS record_count,
--     jsonb_agg(
--         to_jsonb(uc.*) ORDER BY uc.created_at DESC NULLS LAST
--     ) AS data
-- FROM user_contacts uc
-- WHERE uc.user_id = 'a5b3b12c-4aa8-431a-845a-555a698a2575'
-- GROUP BY 1

-- UNION ALL

-- -- 4. User Preferences
-- SELECT 
--     'user_preferences' AS table_name,
--     COUNT(*) AS record_count,
--     jsonb_agg(
--         to_jsonb(upref.*) ORDER BY upref.updated_at DESC NULLS LAST
--     ) AS data
-- FROM user_preferences upref
-- WHERE upref.user_id = 'a5b3b12c-4aa8-431a-845a-555a698a2575'
-- GROUP BY 1

-- UNION ALL


-- SELECT 
--     'sessions' AS table_name,
--     COUNT(*) AS record_count,
--     jsonb_agg(
--         to_jsonb(s.*) ORDER BY s.created_at DESC NULLS LAST
--     ) AS data
-- FROM sessions s
-- WHERE s.user_id = 'a5b3b12c-4aa8-431a-845a-555a698a2575'
-- GROUP BY 1

-- UNION ALL

-- SELECT 
--     'user_sessions' AS table_name,
--     COUNT(*) AS record_count,
--     jsonb_agg(
--         to_jsonb(us.*) ORDER BY us.created_at DESC NULLS LAST
--     ) AS data
-- FROM user_sessions us
-- WHERE us.user_id = 'a5b3b12c-4aa8-431a-845a-555a698a2575'
-- GROUP BY 1

-- UNION ALL

-- SELECT 
--     'verification_tokens' AS table_name,
--     COUNT(*) AS record_count,
--     jsonb_agg(
--         to_jsonb(vt.*) ORDER BY vt.created_at DESC NULLS LAST
--     ) AS data
-- FROM verification_tokens vt
-- WHERE vt.user_id = 'a5b3b12c-4aa8-431a-845a-555a698a2575'
-- GROUP BY 1

-- UNION ALL

-- SELECT 
--     'work_experiences' AS table_name,
--     COUNT(*) AS record_count,
--     jsonb_agg(
--         to_jsonb(we.*) ORDER BY we.start_date DESC NULLS LAST
--     ) AS data
-- FROM work_experiences we
-- WHERE we.user_id = 'a5b3b12c-4aa8-431a-845a-555a698a2575'
-- GROUP BY 1

-- UNION ALL

-- SELECT 
--     'educations' AS table_name,
--     COUNT(*) AS record_count,
--     jsonb_agg(
--         to_jsonb(e.*) ORDER BY e.start_date DESC NULLS LAST
--     ) AS data
-- FROM educations e
-- WHERE e.user_id = 'a5b3b12c-4aa8-431a-845a-555a698a2575'
-- GROUP BY 1

-- UNION ALL

-- SELECT 
--     'certifications' AS table_name,
--     COUNT(*) AS record_count,
--     jsonb_agg(
--         to_jsonb(c.*) ORDER BY c.issue_date DESC NULLS LAST
--     ) AS data
-- FROM certifications c
-- WHERE c.user_id = 'a5b3b12c-4aa8-431a-845a-555a698a2575'
-- GROUP BY 1

-- UNION ALL

-- SELECT 
--     'projects' AS table_name,
--     COUNT(*) AS record_count,
--     jsonb_agg(
--         to_jsonb(p.*) ORDER BY p.start_date DESC NULLS LAST
--     ) AS data
-- FROM projects p
-- WHERE p.user_id = 'a5b3b12c-4aa8-431a-845a-555a698a2575'
-- GROUP BY 1

-- UNION ALL

-- SELECT 
--     'user_skills' AS table_name,
--     COUNT(*) AS record_count,
--     jsonb_agg(
--         to_jsonb(usk.*) ORDER BY usk.created_at DESC NULLS LAST
--     ) AS data
-- FROM user_skills usk
-- WHERE usk.user_id = 'a5b3b12c-4aa8-431a-845a-555a698a2575'
-- GROUP BY 1

-- UNION ALL


-- SELECT 
--     'resumes' AS table_name,
--     COUNT(*) AS record_count,
--     jsonb_agg(
--         to_jsonb(r.*) ORDER BY r.created_at DESC NULLS LAST
--     ) AS data
-- FROM resumes r
-- WHERE r.user_id = 'a5b3b12c-4aa8-431a-845a-555a698a2575'
-- GROUP BY 1

-- UNION ALL

-- SELECT 
--     'cover_letters' AS table_name,
--     COUNT(*) AS record_count,
--     jsonb_agg(
--         to_jsonb(cl.*) ORDER BY cl.created_at DESC NULLS LAST
--     ) AS data
-- FROM cover_letters cl
-- WHERE cl.user_id = 'a5b3b12c-4aa8-431a-845a-555a698a2575'
-- GROUP BY 1

-- UNION ALL

-- SELECT 
--     'job_applications' AS table_name,
--     COUNT(*) AS record_count,
--     jsonb_agg(
--         to_jsonb(ja.*) ORDER BY ja.created_at DESC NULLS LAST
--     ) AS data
-- FROM job_applications ja
-- WHERE ja.user_id = 'a5b3b12c-4aa8-431a-845a-555a698a2575'
-- GROUP BY 1

-- UNION ALL

-- SELECT 
--     'applications' AS table_name,
--     COUNT(*) AS record_count,
--     jsonb_agg(
--         to_jsonb(app.*) ORDER BY app.created_at DESC NULLS LAST
--     ) AS data
-- FROM applications app
-- WHERE app.user_id = 'a5b3b12c-4aa8-431a-845a-555a698a2575'
-- GROUP BY 1

-- UNION ALL

-- SELECT 
--     'bookmarked_jobs' AS table_name,
--     COUNT(*) AS record_count,
--     jsonb_agg(
--         to_jsonb(bj.*) ORDER BY bj.created_at DESC NULLS LAST
--     ) AS data
-- FROM bookmarked_jobs bj
-- WHERE bj.user_id = 'a5b3b12c-4aa8-431a-845a-555a698a2575'
-- GROUP BY 1

-- UNION ALL

-- SELECT 
--     'job_recommendations' AS table_name,
--     COUNT(*) AS record_count,
--     jsonb_agg(
--         to_jsonb(jr.*) ORDER BY jr.created_at DESC NULLS LAST
--     ) AS data
-- FROM job_recommendations jr
-- WHERE jr.user_id = 'a5b3b12c-4aa8-431a-845a-555a698a2575'
-- GROUP BY 1

-- UNION ALL

-- SELECT 
--     'job_clicks' AS table_name,
--     COUNT(*) AS record_count,
--     jsonb_agg(
--         to_jsonb(jc.*) ORDER BY jc.created_at DESC NULLS LAST
--     ) AS data
-- FROM job_clicks jc
-- WHERE jc.user_id = 'a5b3b12c-4aa8-431a-845a-555a698a2575'
-- GROUP BY 1

-- UNION ALL

-- -- 22. Job Views
-- SELECT 
--     'job_views' AS table_name,
--     COUNT(*) AS record_count,
--     jsonb_agg(
--         to_jsonb(jv.*) ORDER BY jv.created_at DESC NULLS LAST
--     ) AS data
-- FROM job_views jv
-- WHERE jv.user_id = 'a5b3b12c-4aa8-431a-845a-555a698a2575'
-- GROUP BY 1

-- UNION ALL

-- -- 23. AI Apply Settings
-- SELECT 
--     'ai_apply_settings' AS table_name,
--     COUNT(*) AS record_count,
--     jsonb_agg(
--         to_jsonb(aas.*) ORDER BY aas.updated_at DESC NULLS LAST
--     ) AS data
-- FROM ai_apply_settings aas
-- WHERE aas.user_id = 'a5b3b12c-4aa8-431a-845a-555a698a2575'
-- GROUP BY 1

-- UNION ALL

-- SELECT 
--     'chat_history' AS table_name,
--     COUNT(*) AS record_count,
--     jsonb_agg(
--         to_jsonb(ch.*) ORDER BY ch.created_at DESC NULLS LAST
--     ) AS data
-- FROM chat_history ch
-- WHERE ch.user_id = 'a5b3b12c-4aa8-431a-845a-555a698a2575'
-- GROUP BY 1

-- UNION ALL

-- SELECT 
--     'processing_queue' AS table_name,
--     COUNT(*) AS record_count,
--     jsonb_agg(
--         to_jsonb(pq.*) ORDER BY pq.created_at DESC NULLS LAST
--     ) AS data
-- FROM processing_queue pq
-- WHERE pq.user_id = 'a5b3b12c-4aa8-431a-845a-555a698a2575'
-- GROUP BY 1

-- UNION ALL

-- SELECT 
--     'user_subscriptions' AS table_name,
--     COUNT(*) AS record_count,
--     jsonb_agg(
--         to_jsonb(usub.*) ORDER BY usub.created_at DESC NULLS LAST
--     ) AS data
-- FROM user_subscriptions usub
-- WHERE usub.user_id = 'a5b3b12c-4aa8-431a-845a-555a698a2575'
-- GROUP BY 1

-- UNION ALL

-- SELECT 
--     'user_credits' AS table_name,
--     COUNT(*) AS record_count,
--     jsonb_agg(
--         to_jsonb(ucr.*) ORDER BY ucr.created_at DESC NULLS LAST
--     ) AS data
-- FROM user_credits ucr
-- WHERE ucr.user_id = 'a5b3b12c-4aa8-431a-845a-555a698a2575'
-- GROUP BY 1

-- UNION ALL

-- SELECT 
--     'credit_transactions' AS table_name,
--     COUNT(*) AS record_count,
--     jsonb_agg(
--         to_jsonb(ct.*) ORDER BY ct.created_at DESC NULLS LAST
--     ) AS data
-- FROM credit_transactions ct
-- WHERE ct.user_id = 'a5b3b12c-4aa8-431a-845a-555a698a2575'
-- GROUP BY 1

-- UNION ALL

-- SELECT 
--     'user_analytics' AS table_name,
--     COUNT(*) AS record_count,
--     jsonb_agg(
--         to_jsonb(ua.*) ORDER BY ua.created_at DESC NULLS LAST
--     ) AS data
-- FROM user_analytics ua
-- WHERE ua.user_id = 'a5b3b12c-4aa8-431a-845a-555a698a2575'
-- GROUP BY 1

-- UNION ALL

-- SELECT 
--     'user_engagement_metrics' AS table_name,
--     COUNT(*) AS record_count,
--     jsonb_agg(
--         to_jsonb(uem.*) ORDER BY uem.created_at DESC NULLS LAST
--     ) AS data
-- FROM user_engagement_metrics uem
-- WHERE uem.user_id = 'a5b3b12c-4aa8-431a-845a-555a698a2575'
-- GROUP BY 1

-- UNION ALL

-- SELECT 
--     'activity_log' AS table_name,
--     COUNT(*) AS record_count,
--     jsonb_agg(
--         to_jsonb(al.*) ORDER BY al.created_at DESC NULLS LAST
--     ) AS data
-- FROM activity_log al
-- WHERE al.user_id = 'a5b3b12c-4aa8-431a-845a-555a698a2575'
-- GROUP BY 1

-- UNION ALL

-- SELECT 
--     'user_onboardings' AS table_name,
--     COUNT(*) AS record_count,
--     jsonb_agg(
--         to_jsonb(uo.*) ORDER BY uo.created_at DESC NULLS LAST
--     ) AS data
-- FROM user_onboardings uo
-- WHERE uo.user_id = 'a5b3b12c-4aa8-431a-845a-555a698a2575'
-- GROUP BY 1

-- UNION ALL

-- SELECT 
--     'user_referrals' AS table_name,
--     COUNT(*) AS record_count,
--     jsonb_agg(
--         to_jsonb(uref.*) ORDER BY uref.created_at DESC NULLS LAST
--     ) AS data
-- FROM user_referrals uref
-- WHERE uref.user_id = 'a5b3b12c-4aa8-431a-845a-555a698a2575' 
-- GROUP BY 1

-- UNION ALL

-- SELECT 
--     'referral_rewards' AS table_name,
--     COUNT(*) AS record_count,
--     jsonb_agg(
--         to_jsonb(rr.*) ORDER BY rr.created_at DESC NULLS LAST
--     ) AS data
-- FROM referral_rewards rr
-- WHERE rr.referrer_id = 'a5b3b12c-4aa8-431a-845a-555a698a2575'
-- GROUP BY 1

-- UNION ALL

-- SELECT 
--     'recommendation_feedback' AS table_name,
--     COUNT(*) AS record_count,
--     jsonb_agg(
--         to_jsonb(rf.*) ORDER BY rf.created_at DESC NULLS LAST
--     ) AS data
-- FROM recommendation_feedback rf
-- WHERE rf.user_id = 'a5b3b12c-4aa8-431a-845a-555a698a2575'
-- GROUP BY 1

-- UNION ALL

-- SELECT 
--     'notifications' AS table_name,
--     COUNT(*) AS record_count,
--     jsonb_agg(
--         to_jsonb(n.*) ORDER BY n.created_at DESC NULLS LAST
--     ) AS data
-- FROM notifications n
-- WHERE n.user_id = 'a5b3b12c-4aa8-431a-845a-555a698a2575'
-- GROUP BY 1

-- UNION ALL

-- SELECT 
--     'interview_questions' AS table_name,
--     COUNT(*) AS record_count,
--     jsonb_agg(
--         to_jsonb(iq.*) ORDER BY iq.created_at DESC NULLS LAST
--     ) AS data
-- FROM interview_questions iq
-- WHERE iq.user_id = 'a5b3b12c-4aa8-431a-845a-555a698a2575'
-- GROUP BY 1

-- ORDER BY table_name;




-- select
--   schemaname,
--   tablename
-- from pg_tables
-- where schemaname = 'public'
-- order by schemaname, tablename;


-- select
--   schemaname,
--   relname as table_name,
--   n_live_tup as estimated_rows
-- from pg_stat_user_tables
-- order by estimated_rows desc;

-- select
--   relname as table_name,
--   pg_size_pretty(pg_total_relation_size(relid)) as total_size
-- from pg_catalog.pg_statio_user_tables
-- order by pg_total_relation_size(relid) desc;


-- select
--   u.id,
--   u.email,
--   u.created_at,

--   -- 1-to-1 tables
--   up   as user_profile,
--   ua   as user_analytics,
--   pref as user_preferences,
--   uc   as user_credits,
--   uo   as user_onboarding,
--   uca  as user_contacts,
--   usub as user_subscriptions,
--   ar   as ai_apply_settings,
--   ref  as user_referrals,

--   -- 1-to-many tables (aggregated)
--   coalesce(skills.skills, '[]')                 as skills,
--   coalesce(work_exps.work_experiences, '[]')    as work_experiences,
--   coalesce(educ.educations, '[]')               as educations,
--   coalesce(proj.projects, '[]')                 as projects,
--   coalesce(cert.certifications, '[]')           as certifications,
--   coalesce(res.resumes, '[]')                   as resumes,
--   coalesce(apps.applications, '[]')             as applications,
--   coalesce(japps.job_applications, '[]')        as job_applications,
--   coalesce(chat.chat_history, '[]')             as chat_history,
--   coalesce(book.bookmarked_jobs, '[]')          as bookmarked_jobs,
--   coalesce(rec.job_recommendations, '[]')       as job_recommendations

-- from users u

-- -- 1-to-1 joins
-- left join user_profiles       up   on up.user_id   = u.id
-- left join user_analytics      ua   on ua.user_id   = u.id
-- left join user_contacts       uca  on uca.user_id  = u.id
-- left join user_preferences    pref on pref.user_id = u.id
-- left join user_credits        uc   on uc.user_id   = u.id
-- left join user_onboardings    uo   on uo.user_id   = u.id
-- left join user_subscriptions  usub on usub.user_id = u.id
-- left join ai_apply_settings   ar   on ar.user_id   = u.id
-- left join user_referrals      ref  on ref.user_id  = u.id

-- -- skills (user_skills → skills)
-- left join lateral (
--   select jsonb_agg(
--     jsonb_build_object(
--       'id', s.id,
--       'name', s.name,
--       'proficiency', us.proficiency_level
--     )
--   ) as skills
--   from user_skills us
--   join skills s on s.id = us.skill_id
--   where us.user_id = u.id
-- ) skills on true

-- -- work experiences
-- left join lateral (
--   select jsonb_agg(we.*) as work_experiences
--   from work_experiences we
--   where we.user_id = u.id
-- ) work_exps on true

-- -- educations
-- left join lateral (
--   select jsonb_agg(e.*) as educations
--   from educations e
--   where e.user_id = u.id
-- ) educ on true

-- -- projects
-- left join lateral (
--   select jsonb_agg(p.*) as projects
--   from projects p
--   where p.user_id = u.id
-- ) proj on true

-- -- certifications
-- left join lateral (
--   select jsonb_agg(c.*) as certifications
--   from certifications c
--   where c.user_id = u.id
-- ) cert on true

-- -- resumes
-- left join lateral (
--   select jsonb_agg(r.*) as resumes
--   from resumes r
--   where r.user_id = u.id
-- ) res on true

-- -- applications
-- left join lateral (
--   select jsonb_agg(a.*) as applications
--   from applications a
--   where a.user_id = u.id
-- ) apps on true

-- -- job applications
-- left join lateral (
--   select jsonb_agg(ja.*) as job_applications
--   from job_applications ja
--   where ja.user_id = u.id
-- ) japps on true

-- -- chat history
-- left join lateral (
--   select jsonb_agg(ch.*) as chat_history
--   from chat_history ch
--   where ch.user_id = u.id
-- ) chat on true

-- -- bookmarked jobs
-- left join lateral (
--   select jsonb_agg(bj.*) as bookmarked_jobs
--   from bookmarked_jobs bj
--   where bj.user_id = u.id
-- ) book on true

-- -- job recommendations
-- left join lateral (
--   select jsonb_agg(jr.*) as job_recommendations
--   from job_recommendations jr
--   where jr.user_id = u.id
-- ) rec on true

-- where u.id = 'a5b3b12c-4aa8-431a-845a-555a698a2575';


-- select * from users where email = 'onlinehassle1234@gmail.com';














-- select * from information_schema.columns;



-- select *  from skills;


-- skills, skill_categories, user_skills

-- SELECT 
--     table_schema,
--     table_name,
--     table_type
-- FROM information_schema.tables
-- WHERE table_schema = 'public'
-- -- WHERE table_schema NOT IN ('information_schema', 'pg_catalog')
-- ORDER BY table_schema, table_name;

-- SELECT 
--     column_name,
--     data_type,
--     character_maximum_length,
--     is_nullable,
--     column_default,
--     ordinal_position
-- FROM information_schema.columns
-- WHERE table_schema = 'public'
--     AND table_name = 'users'
-- ORDER BY ordinal_position;

-- SELECT
--     schemaname,
--     relname AS table_name,
--     n_live_tup AS estimated_rows
-- FROM pg_stat_user_tables
-- ORDER BY n_live_tup DESC;




-- select * from information_schema


-- DO $$
-- DECLARE
--     r RECORD;
-- BEGIN
--     FOR r IN
--         SELECT schemaname, tablename
--         FROM pg_tables
--         WHERE schemaname = 'public'
--           AND tablename <> 'job_posts'
--     LOOP
--         EXECUTE format(
--             'DROP TABLE %I.%I CASCADE;',
--             r.schemaname,
--             r.tablename
--         );
--     END LOOP;
-- END $$;




































-- DO $$
-- DECLARE
--     r RECORD;
-- BEGIN
--     FOR r IN
--         SELECT tablename
--         FROM pg_tables
--         WHERE schemaname = 'public'
--           AND tablename <> 'job_posts'
--     LOOP
--         EXECUTE format('DROP TABLE IF EXISTS public.%I CASCADE;', r.tablename);
--     END LOOP;
-- END $$;
