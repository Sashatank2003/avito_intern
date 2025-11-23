-- Создание команд
INSERT INTO teams (name) VALUES
    ('qa'),
    ('security'),
    ('analytics'),
    ('ml-platform'),
    ('infra')
ON CONFLICT (name) DO NOTHING;

-- Пользователи команды qa
INSERT INTO users (id, username, team_name, is_active) VALUES
    ('qa-anna', 'Anna Petrova', 'qa', true),
    ('qa-igor', 'Igor Sokolov', 'qa', true),
    ('qa-olga', 'Olga Fedorova', 'qa', false)
ON CONFLICT (id) DO NOTHING;

-- Пользователи команды security
INSERT INTO users (id, username, team_name, is_active) VALUES
    ('sec-dmitry', 'Dmitry Orlov', 'security', true),
    ('sec-elena', 'Elena Morozova', 'security', true),
    ('sec-roman', 'Roman Volkov', 'security', true)
ON CONFLICT (id) DO NOTHING;

-- Пользователи команды analytics
INSERT INTO users (id, username, team_name, is_active) VALUES
    ('an-mikhail', 'Mikhail Kuznetsov', 'analytics', true),
    ('an-vera', 'Vera Smirnova', 'analytics', true)
ON CONFLICT (id) DO NOTHING;

-- Пользователи команды ml-platform
INSERT INTO users (id, username, team_name, is_active) VALUES
    ('ml-artem', 'Artem Popov', 'ml-platform', true),
    ('ml-yulia', 'Yulia Lebedeva', 'ml-platform', true),
    ('ml-sergey', 'Sergey Gromov', 'ml-platform', false)
ON CONFLICT (id) DO NOTHING;

-- Пользователи команды infra
INSERT INTO users (id, username, team_name, is_active) VALUES
    ('infra-alex', 'Alexey Ivanov', 'infra', true),
    ('infra-tanya', 'Tatiana Belova', 'infra', true)
ON CONFLICT (id) DO NOTHING;

-- Создание Pull Requests
INSERT INTO pull_requests (id, name, author_id, status, created_at) VALUES
    ('pr-101', 'Add e2e auth tests', 'qa-anna', 'OPEN', NOW() - INTERVAL '1 day'),
    ('pr-102', 'Fix flaky UI test', 'qa-igor', 'MERGED', NOW() - INTERVAL '3 days'),
    ('pr-103', 'Audit RBAC policies', 'sec-dmitry', 'OPEN', NOW() - INTERVAL '5 hours'),
    ('pr-104', 'Add rate limiting to /login', 'sec-elena', 'OPEN', NOW() - INTERVAL '12 hours'),
    ('pr-105', 'Daily retention dashboard', 'an-mikhail', 'MERGED', NOW() - INTERVAL '9 days'),
    ('pr-106', 'Feature store integration', 'ml-artem', 'OPEN', NOW() - INTERVAL '2 days'),
    ('pr-107', 'Fix model versioning bug', 'ml-yulia', 'MERGED', NOW() - INTERVAL '4 days'),
    ('pr-108', 'K8s node autoscaler config', 'infra-alex', 'OPEN', NOW() - INTERVAL '7 hours'),
    ('pr-109', 'Add Grafana alerts', 'infra-tanya', 'OPEN', NOW() - INTERVAL '22 hours')
ON CONFLICT (id) DO NOTHING;

-- Обновление merged_at для смерженных PR
UPDATE pull_requests 
SET merged_at = created_at + INTERVAL '1 day 4 hours' 
WHERE status = 'MERGED' AND merged_at IS NULL;

-- Назначение ревьюеров
INSERT INTO pr_reviewers (pull_request_id, reviewer_id, assigned_at) VALUES
    -- qa PRs
    ('pr-101', 'qa-igor', NOW() - INTERVAL '1 day'),
    ('pr-102', 'qa-anna', NOW() - INTERVAL '3 days'),
    
    -- security PRs
    ('pr-103', 'sec-elena', NOW() - INTERVAL '5 hours'),
    ('pr-103', 'sec-roman', NOW() - INTERVAL '5 hours'),
    ('pr-104', 'sec-dmitry', NOW() - INTERVAL '12 hours'),
    ('pr-104', 'sec-roman', NOW() - INTERVAL '12 hours'),
    
    -- analytics PR
    ('pr-105', 'an-vera', NOW() - INTERVAL '9 days'),
    
    -- ml-platform PRs
    ('pr-106', 'ml-yulia', NOW() - INTERVAL '2 days'),
    ('pr-107', 'ml-artem', NOW() - INTERVAL '4 days'),
    
    -- infra PRs
    ('pr-108', 'infra-tanya', NOW() - INTERVAL '7 hours'),
    ('pr-109', 'infra-alex', NOW() - INTERVAL '22 hours')
ON CONFLICT (pull_request_id, reviewer_id) DO NOTHING;