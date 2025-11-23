-- Удаление назначений ревьюеров
DELETE FROM pr_reviewers WHERE pull_request_id IN (
    'pr-101', 'pr-102', 'pr-103', 'pr-104', 'pr-105',
    'pr-106', 'pr-107', 'pr-108', 'pr-109'
);

-- Удаление Pull Requests
DELETE FROM pull_requests WHERE id IN (
    'pr-101', 'pr-102', 'pr-103', 'pr-104', 'pr-105',
    'pr-106', 'pr-107', 'pr-108', 'pr-109'
);

-- Удаление пользователей
DELETE FROM users WHERE id IN (
    'qa-anna', 'qa-igor', 'qa-olga',
    'sec-dmitry', 'sec-elena', 'sec-roman',
    'an-mikhail', 'an-vera',
    'ml-artem', 'ml-yulia', 'ml-sergey',
    'infra-alex', 'infra-tanya'
);

-- Удаление команд
DELETE FROM teams WHERE name IN (
    'qa', 'security', 'analytics', 'ml-platform', 'infra'
);