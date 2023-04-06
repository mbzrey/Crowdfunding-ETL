-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 

select camp.cf_id, 
    camp.outcome, 
    camp.backers_count
from campaign as camp
where (camp.outcome = 'live')
order by camp.backers_count desc;

-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.

select back.cf_id, 
    count (back.backer_id)
from backers as back
group by back.cf_id
order by count (back.backer_id) desc;

-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 

select cont.first_name, 
    cont.last_name, 
    cont.email, 
    (camp.goal - camp.pledged) as remaining_goal_amount
into email_contacts_remaining_goal_amount
from contacts as cont
left join campaign as camp
    on cont.contact_id = camp.contact_id
where (camp.outcome = 'live')
order by remaining_goal_amount desc;

-- Check the table

select * from email_contacts_remaining_goal_amount;

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 

select back.email, 
    back.first_name, 
    back.last_name, 
    back.cf_id, 
    camp.company_name, 
    camp.description, 
    camp.end_date, 
    (camp.goal - camp.pledged) as left_of_goal
into email_backers_remaining_goal_amount
from backers as back
left join campaign as camp
    on back.cf_id = camp.cf_id
where (camp.outcome = 'live')
order by back.last_name asc, 
    back.first_name asc;

-- Check the table

select * from email_backers_remaining_goal_amount

