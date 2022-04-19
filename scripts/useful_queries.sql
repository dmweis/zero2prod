-- scratchpad for exploring the database

-- Delete entries for postmark enabled address
BEGIN;
	DELETE FROM subscription_tokens WHERE subscriber_id IN (SELECT id FROM subscriptions WHERE email LIKE ('postmark%'));
	DELETE FROM subscriptions WHERE email LIKE ('postmark%');
COMMIT;


--  get postmark enabled addresses
SELECT * FROM subscription_tokens WHERE subscriber_id IN (SELECT id FROM subscriptions WHERE email LIKE ('postmark%'));
SELECT * FROM subscriptions WHERE email LIKE ('postmark%');


-- Delete confirmed users
BEGIN;
	DELETE FROM subscription_tokens WHERE subscriber_id IN (SELECT id FROM subscriptions WHERE status = ('confirmed'));
	DELETE FROM subscriptions WHERE status = ('confirmed');
COMMIT;


-- get all data
SELECT * FROM subscriptions ORDER BY subscriptions.subscribed_at ASC;
SELECT * FROM subscription_tokens;

-- Get uall users with status
SELECT subscriptions.name, subscriptions.email, subscription_tokens.subscription_token, subscriptions.status
FROM subscriptions
INNER JOIN subscription_tokens
ON subscriptions.id = subscription_tokens.subscriber_id
ORDER BY subscriptions.status ASC;

-- Get confirmed users
SELECT subscriptions.name, subscriptions.email, subscriptions.status
FROM subscriptions
INNER JOIN subscription_tokens
ON subscriptions.id = subscription_tokens.subscriber_id
WHERE subscriptions.status = ('confirmed');

-- Get unconfirmed users
SELECT subscriptions.name, subscriptions.email, subscription_tokens.subscription_token, subscriptions.status
FROM subscriptions
INNER JOIN subscription_tokens
ON subscriptions.id = subscription_tokens.subscriber_id
WHERE subscriptions.status = ('pending_confirmation');

-- Get all pending_confirmation tokens
SELECT subscription_tokens.subscription_token
FROM subscriptions
INNER JOIN subscription_tokens
ON subscriptions.id = subscription_tokens.subscriber_id
WHERE subscriptions.status = ('pending_confirmation');