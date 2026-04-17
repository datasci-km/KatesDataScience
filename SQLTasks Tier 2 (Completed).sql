/* Welcome to the SQL mini project. You will carry out this project partly in
the PHPMyAdmin interface, and partly in Jupyter via a Python connection.

This is Tier 2 of the case study, which means that there'll be less guidance for you about how to setup
your local SQLite connection in PART 2 of the case study. This will make the case study more challenging for you: 
you might need to do some digging, aand revise the Working with Relational Databases in Python chapter in the previous resource.

Otherwise, the questions in the case study are exactly the same as with Tier 1. 

PART 1: PHPMyAdmin
You will complete questions 1-9 below in the PHPMyAdmin interface. 
Log in by pasting the following URL into your browser, and
using the following Username and Password:

URL: https://sql.springboard.com/
Username: student
Password: learn_sql@springboard

The data you need is in the "country_club" database. This database
contains 3 tables:
    i) the "Bookings" table,
    ii) the "Facilities" table, and
    iii) the "Members" table.

In this case study, you'll be asked a series of questions. You can
solve them using the platform, but for the final deliverable,
paste the code for each solution into this script, and upload it
to your GitHub.

Before starting with the questions, feel free to take your time,
exploring the data, and getting acquainted with the 3 tables. */


/* QUESTIONS 
/* Q1: Some of the facilities charge a fee to members, but some do not.
Write a SQL query to produce a list of the names of the facilities that do. */

Select name
From 'Facilities
Where membercost = 0;

/* Q2: How many facilities do not charge a fee to members? */

4 facilities: The Badminton Court, Table Tennis, Snooker Table, and Pool Table

/* Q3: Write an SQL query to show a list of facilities that charge a fee to members,
where the fee is less than 20% of the facility's monthly maintenance cost.
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */

SELECT facid, name, membercost, monthlymaintenance
FROM Facilities
WHERE membercost > 0
AND membercost < 0.20 * monthlymaintenance;

0 Tennis Court 1 5.0 200
1 Tennis Court 2 5.0 200
4 Massage Room 1 9.9 3000
5 Massage Room 2 9.9 3000
6 Squash Court  3.5 80

/* Q4: Write an SQL query to retrieve the details of facilities with ID 1 and 5.
Try writing the query without using the OR operator. */

SELECT *
FROM Facilities
Where facid IN (1,5);

1 Tennis Court 2 5.0 25 8000 200
5 Massage Room 2 9.9 80 4000 3000

/* Q5: Produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100. Return the name and monthly maintenance of the facilities
in question. */

SELECT name, monthlymaintenance,
CASE
WHEN monthlymaintenance > 100 THEN 'Expensive'
WHEN monthlymaintenance < 100 THEN 'Cheap'
ELSE 'Medium'
END AS cost_category
FROM Facilities;

Tennis Court 1
200
Expensive
Tennis Court 2
200
Expensive
Badminton Court
50
Cheap
Table Tennis
10
Cheap
Massage Room 1
3000
Expensive
Massage Room 2
3000
Expensive
Squash Court
80
Cheap
Snooker Table
15
Cheap
Pool Table
15
Cheap



/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Try not to use the LIMIT clause for your solution. */

SELECT firstname, surname
FROM Members 
WHERE joindate = (
    SELECT MAX(joindate)
    FROM Members);

Darren Smith


/* Q7: Produce a list of all members who have used a tennis court.
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */

SELECT DISTINCT
	CONCAT(m.firstname, '', m.surname,'-',f.name) AS member_and_court
    FROM Bookings b
    JOIN Members m USING (memid)
    JOIN Facilities f USING (facid)
    WHERE f.name LIKE '%Tennis Court%'
    ORDER BY m.surname, m.firstname;

member_and_court
FlorenceBader-Tennis Court 2
FlorenceBader-Tennis Court 1
AnneBaker-Tennis Court 2
AnneBaker-Tennis Court 1
TimothyBaker-Tennis Court 2
TimothyBaker-Tennis Court 1
TimBoothe-Tennis Court 2
TimBoothe-Tennis Court 1
GeraldButters-Tennis Court 1
GeraldButters-Tennis Court 2
JoanCoplin-Tennis Court 1
EricaCrumpet-Tennis Court 1
NancyDare-Tennis Court 2
NancyDare-Tennis Court 1
DavidFarrell-Tennis Court 2
DavidFarrell-Tennis Court 1
JemimaFarrell-Tennis Court 1
JemimaFarrell-Tennis Court 2
MatthewGenting-Tennis Court 1
GUESTGUEST-Tennis Court 2
GUESTGUEST-Tennis Court 1
JohnHunt-Tennis Court 1
JohnHunt-Tennis Court 2
DavidJones-Tennis Court 2
DavidJones-Tennis Court 1
DouglasJones-Tennis Court 1
JaniceJoplette-Tennis Court 1
JaniceJoplette-Tennis Court 2
CharlesOwen-Tennis Court 1
CharlesOwen-Tennis Court 2
DavidPinker-Tennis Court 1
MillicentPurview-Tennis Court 2
TimRownam-Tennis Court 2
TimRownam-Tennis Court 1
HenriettaRumney-Tennis Court 2
RamnareshSarwin-Tennis Court 1
RamnareshSarwin-Tennis Court 2
DarrenSmith-Tennis Court 2
JackSmith-Tennis Court 1
JackSmith-Tennis Court 2
TracySmith-Tennis Court 1
TracySmith-Tennis Court 2
PonderStibbons-Tennis Court 2
PonderStibbons-Tennis Court 1
BurtonTracy-Tennis Court 2
BurtonTracy-Tennis Court 1



/* Q8: Produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30. Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */

JOIN Members m USING (memid)
JOIN Facilities f USING (facid)
WHERE DATE(b.starttime) = '2012-09-14'
  AND (
        CASE 
            WHEN b.memid = 0 THEN b.slots * f.guestcost
            ELSE b.slots * f.membercost
        END
      ) > 30
ORDER BY cost DESC;


facility
member_name
cost Descending 1
Massage Room 2
GUEST GUEST
320.0
Massage Room 1
GUEST GUEST
160.0
Massage Room 1
GUEST GUEST
160.0
Massage Room 1
GUEST GUEST
160.0
Tennis Court 2
GUEST GUEST
150.0
Tennis Court 1
GUEST GUEST
75.0
Tennis Court 1
GUEST GUEST
75.0
Tennis Court 2
GUEST GUEST
75.0
Squash Court
GUEST GUEST
70.0
Massage Room 1
Jemima Farrell
39.6
Squash Court
GUEST GUEST
35.0
Squash Court
GUEST GUEST
35.0



/* Q9: This time, produce the same result as in Q8, but using a subquery. */
SELECT 
    facility,
    member_name,
    cost
FROM (
    SELECT
        f.name AS facility,
        CONCAT(m.firstname, ' ', m.surname) AS member_name,
        CASE 
            WHEN b.memid = 0 THEN b.slots * f.guestcost
            ELSE b.slots * f.membercost
        END AS cost,
        b.starttime
    FROM Bookings b
    JOIN Members m USING (memid)
    JOIN Facilities f USING (facid)
) AS sub
WHERE DATE(starttime) = '2012-09-14'
  AND cost > 30
ORDER BY cost DESC;


facility
member_name
cost Descending 1
Massage Room 2
GUEST GUEST
320.0
Massage Room 1
GUEST GUEST
160.0
Massage Room 1
GUEST GUEST
160.0
Massage Room 1
GUEST GUEST
160.0
Tennis Court 2
GUEST GUEST
150.0
Tennis Court 1
GUEST GUEST
75.0
Tennis Court 2
GUEST GUEST
75.0
Tennis Court 1
GUEST GUEST
75.0
Squash Court
GUEST GUEST
70.0
Massage Room 1
Jemima Farrell
39.6
Squash Court
GUEST GUEST
35.0
Squash Court
GUEST GUEST
35.0


/* PART 2: SQLite

Export the country club data from PHPMyAdmin, and connect to a local SQLite instance from Jupyter notebook 
for the following questions.  

QUESTIONS:
/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */

SELECT f.name,
       SUM(
           CASE
               WHEN b.memid = 0 THEN f.guestcost * b.slots
               ELSE f.membercost * b.slots
           END
       ) AS revenue
FROM Facilities f
JOIN Bookings b
  ON f.facid = b.facid
GROUP BY f.name
HAVING revenue < 1000;


facility	total_revenue
0	Table Tennis	180.0
1	Snooker Table	240.0
2	Pool Table	270.0



/* Q11: Produce a report of members and who recommended them in alphabetic surname,firstname order */

SELECT 
    m.firstname || ' ' || m.surname AS member,
    r.firstname || ' ' || r.surname AS recommended_by
FROM Members m
LEFT JOIN Members r
    ON m.recommendedby = r.memid
ORDER BY m.surname, m.firstname;


	member	recommended_by
0	Florence Bader	Ponder Stibbons
1	Anne Baker	Ponder Stibbons
2	Timothy Baker	Jemima Farrell
3	Tim Boothe	Tim Rownam
4	Gerald Butters	Darren Smith
5	Joan Coplin	Timothy Baker
6	Erica Crumpet	Tracy Smith
7	Nancy Dare	Janice Joplette
8	David Farrell	None
9	Jemima Farrell	None
10	GUEST GUEST	None
11	Matthew Genting	Gerald Butters
12	John Hunt	Millicent Purview
13	David Jones	Janice Joplette
14	Douglas Jones	David Jones
15	Janice Joplette	Darren Smith
16	Anna Mackenzie	Darren Smith
17	Charles Owen	Darren Smith
18	David Pinker	Jemima Farrell
19	Millicent Purview	Tracy Smith
20	Tim Rownam	None
21	Henrietta Rumney	Matthew Genting
22	Ramnaresh Sarwin	Florence Bader
23	Darren Smith	None
24	Darren Smith	None
25	Jack Smith	Darren Smith
26	Tracy Smith	None
27	Ponder Stibbons	Burton Tracy
28	Burton Tracy	None
29	Hyacinth Tupperware	None
30	Henry Worthington-Smyth	Tracy Smith


/* Q12: Find the facilities with their usage by member, but not guests */

SELECT 
    f.name AS facility,
    COUNT(*) AS member_usage
FROM Bookings b
JOIN Facilities f
    ON b.facid = f.facid
WHERE b.memid <> 0
GROUP BY f.name
ORDER BY f.name;



facility	member_usage
0	Badminton Court	344
1	Massage Room 1	421
2	Massage Room 2	27
3	Pool Table	783
4	Snooker Table	421
5	Squash Court	195
6	Table Tennis	385
7	Tennis Court 1	308
8	Tennis Court 2	276



/* Q13: Find the facilities usage by month, but not guests */
facility	month	member_usage

SELECT 
    f.name AS facility,
    strftime('%m', b.starttime) AS month,
    COUNT(*) AS member_usage
FROM Bookings b
JOIN Facilities f
    ON b.facid = f.facid
WHERE b.memid <> 0
GROUP BY f.name, month
ORDER BY month, f.name;


0	Badminton Court	07	51
1	Massage Room 1	07	77
2	Massage Room 2	07	4
3	Pool Table	07	103
4	Snooker Table	07	68
5	Squash Court	07	23
6	Table Tennis	07	48
7	Tennis Court 1	07	65
8	Tennis Court 2	07	41
9	Badminton Court	08	132
10	Massage Room 1	08	153
11	Massage Room 2	08	9
12	Pool Table	08	272
13	Snooker Table	08	154
14	Squash Court	08	85
15	Table Tennis	08	143
16	Tennis Court 1	08	111
17	Tennis Court 2	08	109
18	Badminton Court	09	161
19	Massage Room 1	09	191
20	Massage Room 2	09	14
21	Pool Table	09	408
22	Snooker Table	09	199
23	Squash Court	09	87
24	Table Tennis	09	194
25	Tennis Court 1	09	132
26	Tennis Court 2	09	126
