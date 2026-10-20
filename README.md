# Outfitora backend

Accounts, wardrobe, photo storage, styling chat, community, admin and notifications.
No `npm install` needed. You only need **Node.js 22.13 or newer** (https://nodejs.org).

## Run it
1. Open a terminal in this folder.
2. `cp .env.example .env` (Windows: copy the file and rename it to `.env`)
3. `npm start`
4. Open http://localhost:3000

Check it works: `npm test` (32 checks, uses a temporary database).

## What works today
- Signup and login (passwords hashed with scrypt, signed HttpOnly session cookie, rate limited)
- Every user only sees their own wardrobe, looks, plan, chat and notifications
- AI Wardrobe Scanner has its own page in the left menu (upload a photo, then your items open in My Wardrobe)
- Settings page (left menu): account settings, personal details, privacy and security (change password, sign out of all devices, download my data, delete account), help and support (FAQ and a message box that reaches the admin page), About Outfitora
- Profile: photo, bio, member since, wardrobe palette, favourites, style preferences
- Wardrobe: add, edit, delete, favourite, worn counter, dress/shirt and bottom style names (Kalidar, Anarkali, Sharara, Palazzo and more), photo upload (JPG/PNG/WebP, 8 MB, checked)
- Preferences, try-on looks, weekly plan and saved trends (`/api/data/:key`)
- Community: posts, likes, saves, comments, reports, delete own post
- Admin (the `ADMIN_EMAIL` account): stats and report moderation
- Notifications, free weather (`/api/weather?lat=..&lon=..`)

## Virtual try-on
- Three options at the top of the page: **Virtual Try-On** (a model, with Small / Medium / Large size and skin tone choices), **Upload Photo** (the member's own photo wearing her look) and **Look Board** (the real clothes photos together).
- Pieces are chosen from groups (Dress, Abaya or bottom, Scarf, Shoes, Bag, Accessory). A group opens only when tapped. All three looks are always shown under the model, each with Edit, Save and Clear.
- Without any key, Virtual Try-On shows a fashion illustration that follows the style (short or long shirt, palazzo, sharara...) and the chosen size.
- **For a model that looks like a real person:** put model photos in `public/models/`, named `size-skintone.jpg` (for example `small-fair.jpg`, `medium-tan.jpg`, `large-deep.jpg`; sizes small, medium, large; tones fair, light, tan, deep). When a photo matches the chosen size and skin tone, it is shown with a **Dress this model** button, and an image AI key dresses her in the look. See `public/models/README.txt`. Use only photos you have the right to use.
- **Upload Photo** and **Dress this model** need an image AI key in `.env`: `GEMINI_API_KEY` (Google) or `FAL_KEY` (fal.ai). Without a key the screen says it is not switched on yet.
- Each member can make 8 try-ons per hour, to protect your key from overuse.
- The server path is tested with a pretend image service (`npm test`). It was not tested with a real Google or fal.ai key, so the first real try may need a small fix. Quality depends on the service and on a clear, front-facing photo.

## Notifications
- Settings has a **Notifications** tab. Good morning, Good evening and Good night messages each have an on/off switch and a time. Morning is on by default (08:00).
- **Reminders:** the member says what it is (University, Dinner, Wedding...), the date and time, how early to remind her (30 minutes, 1 hour, 3 hours, or the evening before at 9 pm) and whether it repeats (every weekday, every day, every week). The reminder names her planned outfit.
- The server checks every 30 seconds and puts due messages in the bell (using the member's own time zone). They also pop up as device notifications while Outfitora is open in the browser, once she taps "Allow notifications on this device".
- Not included yet: messages when the browser is closed (that needs a service worker and push keys) and email or phone messages.

## Needs a key from you (not tested here)
- Real wardrobe scan and AI chat: set `ANTHROPIC_API_KEY`. This is a paid service.
- Google sign-in: set `GOOGLE_CLIENT_ID` and send the Google credential to `/api/auth/google`.

## Not done yet
- In `public/index.html`, signup/login, wardrobe, try-on looks, weekly plan, preferences and saved trends now use the server. Community, the admin page, style chat history, wardrobe scan, notifications, saved outfits and the profile also use the server now. With an `ANTHROPIC_API_KEY`, chat and scan use the real AI; without it, chat uses simple built-in rules and scan adds sample items.
- Real try-on (clothes on a photo) needs an image AI service.
- Daily notification sending (a scheduler) and email/phone delivery.
- Before going live: HTTPS, `NODE_ENV=production`, a strong `SESSION_SECRET`, backups of `data/` and `uploads/`.

## VS Code (Windows): easiest way
1. Install Node.js **22 or newer** (the "LTS" button on https://nodejs.org). Close and reopen VS Code afterwards.
2. Unzip `outfitora-backend.zip` (right click, Extract All). In VS Code: File > Open Folder > choose the `outfitora-backend` folder. You must see `server.js` in the left list.
3. Either double-click `START-WINDOWS.bat`, or in the VS Code terminal run: `node start.js`
4. Open http://localhost:3000 in the browser. Stop with Ctrl+C.

## If it does not start
- It says Node.js is too old or "No such built-in module: node:sqlite": install Node.js 22 or newer, then run `node -v` to check.
- "Cannot find module" or "package.json not found": VS Code has the wrong folder open. Open the folder that directly contains `server.js`.
- PowerShell says "running scripts is disabled": use `node start.js` instead of `npm start`.
- "Port 3000 is already in use": close the other window (Ctrl+C) or run `set PORT=3001` and start again, then open http://localhost:3001.
- Do not open `public/index.html` by double-clicking it. That shows only the preview, without login or saving. Always open http://localhost:3000.
- Still stuck: copy the red error text from the terminal and send it.
## Home background video
- Home plays a muted looping video behind the headline: your walk-in wardrobe clip (`public/videos/hero1.mp4` and `hero1.webm`). If it is missing, an abstract silk video (`silk.mp4`) plays instead.
- The wardrobe clip is an iStock/Getty preview and has a faint watermark. Buy the clean version before the site goes live.
- To use your own fashion videos: save them as `public/videos/hero1.mp4`, `hero2.mp4`, `hero3.mp4`, `hero4.mp4` (also add a `.webm` with the same name if you can). They play one after the other with a soft fade. If none exist, the silk video plays.
- Best clips: 1080p, 8 to 15 seconds, no sound, under 5 MB each, calm slow motion (silk or lawn fabric moving, hands browsing a wardrobe rail, embroidery close-ups, a dupatta in the wind).
- Make a clip small with ffmpeg: `ffmpeg -i input.mp4 -an -vf scale=1280:-2 -c:v libx264 -crf 28 -movflags +faststart hero1.mp4`
- Visitors who choose "reduce motion" or Data Saver never download the video, and there is a Pause button on the page.

## Page backgrounds
- Every page except Home has its own wardrobe photo behind it (`public/bg/*.webp`), shown clearly like the Home video: My Wardrobe, AI Wardrobe Scanner, Choose Occasion, Weekly Planner, Style Chat, Virtual Try-On, Insights, Trends, Community, Saved and My Profile. Home keeps the video.
- A dark tint sits on top so the light headings stay readable (all text measured at 4.5 contrast or better, even on the brightest part of each photo). Cards stay ivory with dark text.
- To swap a photo, replace the file with the same name (wide picture, about 1600 px, saved as .webp).
- To make a page's photo clearer or darker, change its number in `OVL` inside `public/index.html` (for example `chat: 0.74`). Lower is clearer, higher is darker. Keep it at 0.6 or more so text stays readable.
- Visitors with Data Saver turned on do not load the photos.

## Logo
- The logo is in `public/logo/` (`logo-96.png` for the menu, `logo-192.png` for About, `favicon-32.png` and `favicon-64.png` for the browser tab, `apple-touch-icon.png` for phones). It has a transparent background, so it works best on light backgrounds.
- To change it, replace those files with the same names and sizes.

## Look
- The light theme is caramel and cream; the dark theme is unchanged. The member's choice is remembered.

## Putting Outfitora online
**1. For your viva (best): run it on your laptop.** `START-WINDOWS.bat` keeps accounts, wardrobes and photos safely on your computer.

**2. To show it on a phone or to someone far away, for free:** start Outfitora, then double-click `SHARE-ONLINE.bat`. It uses a Cloudflare quick tunnel (no account needed) and prints a public https link. The link works only while your laptop and that window stay open, and it changes each time.

**3. A free cloud demo (Render):** push this folder to GitHub, then on render.com choose New > Blueprint (it reads `render.yaml`), and set `ADMIN_EMAIL`. Warning: the free plan sleeps after 15 minutes without visitors and forgets every file when it restarts, so the database and uploaded photos are lost. Use it only to show screens.

**4. A real launch needs:** a server whose disk is kept (a small paid VPS, or a paid host with a persistent disk) with Node 22.13 or newer, `NODE_ENV=production`, a long random `SESSION_SECRET`, HTTPS (a domain with a free certificate), regular backups of the `data/` and `uploads/` folders, and your AI keys in `.env`.

## Usability test data (for your evaluation)
- Settings > **Help us improve**: a member can agree to share usage statistics, do 5 timed tasks, and answer the 10 standard SUS statements with a comment. Nothing is recorded until she agrees, and wardrobe photos, chats and messages are never read.
- The admin page (`#admin`) has **Participants and data**: members, SUS average, task success and times, pages used, comments, and CSV downloads.
- See `TEST-DAY-GUIDE.md` for how to run the test.

## Visitors and logins (for your report)
- The admin page (`#admin`, under **Participants and data**) shows: **visitors** (people who opened the site, counted anonymously from a random code in their browser), visitors today, page loads, **members** (signed up), **logins** (total and members who logged in), the sign-up rate (members out of visitors), a **last 14 days** table, and a **members list** with joined date, last login, number of logins and last seen. Each part has a CSV download.
- Visitors who never sign up are counted too. No name, email or address is stored for them.

## If the Admin page does not show
1. Admin is the account whose email is in `.env` as `ADMIN_EMAIL=your-email`. The file must be named exactly `.env` (Notepad often saves it as `.env.txt`; turn on "File name extensions" in Windows to check). Close the server window and run `START-WINDOWS.bat` again after editing it. The window prints "Admin email: ..." when it was read.
2. If you already signed up before setting it, just log out and log in again (or restart the server). That account becomes admin.
3. Still nothing? Double-click `MAKE-ADMIN.bat`, type the email of your account, then log out and log in again.
4. An **Admin** item then appears at the bottom of the left menu (it is visible only to the admin). The preview link online has no real admin.

## Free hosting without a card: Hugging Face Spaces
- Render may ask for a payment card to verify your account. Hugging Face Spaces (Docker, free "CPU basic") is another free choice. Use `outfitora-huggingface.zip` (a ready package) or this folder's `Dockerfile`.
- In the Space, set the variables `ADMIN_EMAIL`, `NODE_ENV=production` and the secret `SESSION_SECRET`. Open the direct link ending in `.hf.space`, not the page inside huggingface.co, so login works.
- Free Spaces forget the database and uploaded photos when they restart, so use it to show the app, not to collect test data.

## Quick way to get a real public link (phone, real login)
1. Put `ADMIN_EMAIL=your-email` in `.env` (optional, to be the admin).
2. Double-click **GO-ONLINE.bat**. It starts Outfitora and prints a link like `https://xxxx.trycloudflare.com`.
3. Open that link on any phone. Sign up and log in as on any website. The data is kept on your laptop (`data/` and `uploads/`).
4. Keep both windows open and the laptop awake while people use it. The link changes each time you start it. Logins now survive a restart (the secret is saved in `data/session.secret`).
