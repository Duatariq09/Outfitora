# Outfitora test day guide

Use this to run a real usability test and collect evidence for your evaluation.

## Before the test
1. Start Outfitora on your laptop (`START-WINDOWS.bat`) and open http://localhost:3000.
2. Make yourself the admin: put `ADMIN_EMAIL=your-email` in `.env`, restart, and sign up (or log in) with that email. An **Admin** item then appears in the left menu. If it does not, run `MAKE-ADMIN.bat`.
3. To let people test on their own phones, double-click `SHARE-ONLINE.bat` and send them the https link. Keep your laptop on and awake during the test.
4. Prepare 5 to 8 women from your target group (university students, working women). 5 is the minimum.

## For each participant (about 15 minutes)
1. Say: "We are testing the app, not you. Nothing you do is wrong. You can stop any time."
2. They sign up (name, email, password). Do not help unless they are stuck for a minute. Write down where they got stuck.
3. They open **Settings > Help us improve**, tick the agreement, and do the 5 tasks (press Start, do it, press Done or "Could not do it").
4. They answer the 10 statements (SUS) and write a comment.
5. Ask 3 questions out loud and write the answers: "What was easiest?", "What confused you?", "Would you use it? Why or why not?"

## After the test: see the data
Open `#admin` and scroll to **Participants and data**:
- **Visitors** (people who opened the site), **members**, **logins**, sign-up rate, and a last-14-days table
- Members, how many agreed to take part, number of questionnaires, **average SUS score**
- **Task results:** how many finished each task, how many could not, average time in seconds
- **What people used:** which pages and actions, how many times
- Written comments
- Four **Download (CSV)** buttons to put the numbers in Excel or your report

## What the numbers mean
- **Task success rate** = people who pressed Done / people who tried. 80% or more is good.
- **SUS** below 68 is below average, 68 or more is above average, 80 or more is excellent.
- Tasks with low success or long times show your **real usability problems**. Fix the top 3, test with 3 new people again, and compare the numbers. That is your before and after evidence.

## Rules to keep it honest
- Only use data from people who agreed. Outfitora records nothing until they tick the agreement.
- Do not write numbers you did not collect. Report the real number of participants, even if it is 5.
- Keep a list of the problems you saw, and what you changed because of them.
