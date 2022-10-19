-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 

SELECT cm.cf_id, cm.backers_count
FROM "Campaign" as cm
WHERE (cm.outcome = 'live')
ORDER By cm.backers_count DESC;


-- Or alternatively we can use the following code.

SELECT DISTINCT ON (cm.backers_count) cm.cf_id,
	cm.backers_count
FROM "Campaign" as cm
INNER JOIN backers as b
ON cm.cf_id = b.cf_id
ORDER By cm.backers_count DESC;

-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.

SELECT b.cf_id,
	COUNT(b.backer_id)
FROM backers as b
GROUP By b.cf_id
ORDER By count DESC;

-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 

SELECT cn.first_name,
	cn.last_name,
	cn.email,
	(cm.goal-cm.pledged) as "Remaining Goal Amount"
--INTO email_contacts_remaining_goal_amount
From contacts as cn
INNER JOIN "Campaign" as cm
ON cn.contact_id = cm.contact_id
WHERE (cm.outcome = 'live')
ORDER BY "Remaining Goal Amount" DESC;


-- Check the table

SELECT * FROM email_contacts_remaining_goal_amount;

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 

SELECT b.email,
	b.first_name,
	b.last_name,
	cm.cf_id,
	cm.company_name,
	cm.description,
	cm.end_date,
	(cm.goal-cm.pledged) as "Left of Goal"
INTO email_backers_remaining_goal_amount
From backers as b
INNER JOIN "Campaign" as cm
ON cm.cf_id = b.cf_id
WHERE (cm.outcome = 'live')
ORDER BY b.email DESC;

-- Check the table

SELECT * FROM email_backers_remaining_goal_amount;
