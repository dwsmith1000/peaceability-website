# PeaceAbility Website - Complete Deployment Guide

This guide walks you through setting up and deploying the PeaceAbility website step-by-step.

## Overview of What We're Building

Your website will:
1. **Display content** in 3 columns: News & Events, Resources, and UN News feed
2. **Support two languages** (English & French) with a flag toggle
3. **Allow non-technical users** to add content via a web admin panel (Decap CMS)
4. **Collect contact form submissions** via Web3Forms
5. **Deploy automatically** from GitHub to Cloudflare Pages (when you push code)

## Prerequisites

You'll need:
- A GitHub account (free at github.com)
- A Cloudflare account (free at cloudflare.com)
- Node.js installed on your computer (v18+, get it at nodejs.org)
- Your PeaceAbility logo file (PNG or SVG)
- Your domain name (if you already own one)

---

## Step 1: GitHub Repository Setup

### 1a. Create the Repository

1. Go to [github.com/new](https://github.com/new)
2. Repository name: `peaceability-website`
3. Description: `PeaceAbility NGO Website`
4. Make it **Public** (required for Cloudflare Pages to work)
5. Click "Create repository"

### 1b. Clone to Your Computer

```bash
git clone https://github.com/YOUR_USERNAME/peaceability-website.git
cd peaceability-website
```

Replace `YOUR_USERNAME` with your actual GitHub username.

### 1c. Copy Project Files

Copy all files from the PeaceAbility website project into this folder. Your folder structure should look like:

```
peaceability-website/
├── src/
├── public/
├── astro.config.mjs
├── package.json
├── .gitignore
├── README.md
└── DEPLOYMENT_GUIDE.md
```

---

## Step 2: Local Setup & Testing

### 2a. Install Dependencies

```bash
npm install
```

This downloads the necessary libraries (Astro, etc.).

### 2b. Add Your Logo

1. Save your PeaceAbility logo as `logo.png` (PNG or SVG)
2. Place it in: `public/images/logo.png`
3. Ideal size: 400x300 pixels (will be resized to 50px height in header)

### 2c. Test Locally

```bash
npm run dev
```

Open your browser to `http://localhost:3000`. You should see:
- Navy blue header with PeaceAbility logo and title
- Language toggle (UK flag 🇬🇧 for English, France flag 🇫🇷 for French)
- 3-column layout with sample content
- Contact form at the bottom
- Lime green and navy blue styling

To stop the local server, press `Ctrl+C` in your terminal.

---

## Step 3: Web3Forms Setup (Contact Form)

The contact form needs a service to email you submissions.

### 3a. Create Web3Forms Account

1. Go to [web3forms.com](https://web3forms.com/)
2. Click "Sign Up" and create an account
3. Verify your email address
4. Go to the Dashboard

### 3b. Create a Form

1. Click "New Form" or "+ Form"
2. Form name: `PeaceAbility Contact`
3. Notification email: `peaceabilityngo@gmail.com` (or your email)
4. Click "Create"
5. Copy your **Access Key** (looks like: `abc123def456xyz789...`)

### 3c. Update Your Website

Now update the contact form with your access key:

1. Open `src/pages/en/index.astro`
2. Find this line: `<input type="hidden" name="access_key" value="YOUR_WEB3FORMS_KEY_HERE" />`
3. Replace `YOUR_WEB3FORMS_KEY_HERE` with your actual access key
4. Also update this line: `<input type="hidden" name="redirect" value="https://yourdomain.com/en/thank-you" />`
   - Replace `yourdomain.com` with your actual domain or Cloudflare Pages URL (you'll have this after deployment)

5. Do the same for `src/pages/fr/index.astro`, but change the redirect to `/fr/merci`

### 3d. Test the Form

```bash
npm run dev
```

Fill out and submit the form. You should receive an email at the address you specified.

---

## Step 4: Decap CMS Setup (Content Management)

Decap CMS is the web-based admin panel where non-technical users can add news, events, and resources.

### 4a. Set Up GitHub OAuth

OAuth lets Decap CMS authenticate with GitHub securely.

1. Go to your GitHub account → Settings
2. Scroll to bottom → "Developer settings" → "OAuth Apps"
3. Click "New OAuth App"
4. Fill in:
   - **Application name**: `PeaceAbility CMS`
   - **Homepage URL**: `https://yourdomain.com` (for now use your Cloudflare Pages URL once you have it)
   - **Authorization callback URL**: `https://yourdomain.com/api/auth`
5. Click "Register application"
6. You'll see **Client ID** and **Client Secret** — copy the **Client ID**

### 4b. Configure Decap CMS

1. Open `public/admin/config.yml`
2. Update line: `repo: YOUR_GITHUB_USERNAME/peaceability-website`
   - Replace `YOUR_GITHUB_USERNAME` with your GitHub username
3. Save the file

### 4c. CMS Authentication Challenge

Decap CMS requires OAuth, which works best when deployed. For local testing, you can use the test mode or deploy first and test on the live site.

To test locally:
1. Run `npm run dev`
2. Go to `http://localhost:3000/admin`
3. You may need to authenticate

**After deployment to Cloudflare**, the CMS will work fully. You'll access it at: `https://yourdomain.com/admin`

---

## Step 5: Commit & Push to GitHub

Now that everything is set up, push your code to GitHub:

```bash
git add .
git commit -m "Initial PeaceAbility website setup with Decap CMS"
git push origin main
```

Check [github.com](https://github.com/YOUR_USERNAME/peaceability-website) to confirm your files are there.

---

## Step 6: Deploy to Cloudflare Pages

### 6a. Connect GitHub to Cloudflare

1. Log into your [Cloudflare account](https://dash.cloudflare.com/)
2. In the sidebar, click "Pages"
3. Click "Create a project" → "Connect to Git"
4. Click "GitHub" and authorize Cloudflare to access your repos
5. Select the `peaceability-website` repository
6. Click "Begin setup"

### 6b. Configure Build Settings

1. Framework preset: Select **Astro**
2. Build command: `npm run build`
3. Build output directory: `dist`
4. Leave environment variables blank (for now)
5. Click "Save and Deploy"

Cloudflare will automatically build and deploy your site. Wait 2-3 minutes for the build to complete.

### 6c. Get Your Cloudflare URL

Once deployed, Cloudflare gives you a URL like: `peaceability-website.pages.dev`

You can now:
- Visit your site at that URL
- Access the CMS at `https://peaceability-website.pages.dev/admin`

**IMPORTANT**: Update your Web3Forms redirect URLs now:
- In `src/pages/en/index.astro`: Change `yourdomain.com` to `peaceability-website.pages.dev`
- In `src/pages/fr/index.astro`: Same change
- Commit and push these changes: `git add . && git commit -m "Update Web3Forms redirect URLs" && git push origin main`
- Cloudflare will automatically redeploy

### 6d. Connect Your Custom Domain (Optional)

If you own a domain (e.g., `peaceability.org`):

1. In Cloudflare, go to your Pages project → "Custom domains"
2. Click "Set up a custom domain"
3. Enter your domain
4. Follow DNS setup instructions (Cloudflare will guide you)
5. Wait 5-10 minutes for DNS to propagate

Once your domain is connected, update your Web3Forms URLs again to use your custom domain.

---

## Step 7: Test the Live Site

Visit your deployed site and test:

1. ✅ Logo and header display correctly
2. ✅ 3-column layout with sample content
3. ✅ Language toggle works (click flags to switch EN/FR)
4. ✅ Contact form submits and you receive email
5. ✅ Footer displays correctly
6. ✅ Site is mobile-responsive (test on phone)

---

## Step 8: Using the Decap CMS Admin Panel

Once everything is deployed:

### Access the CMS

Go to: `https://yourdomain.com/admin`

You'll be asked to log in with GitHub. Click "Login with GitHub" and authorize.

### Add News & Events

1. Click "News & Events" in the sidebar
2. Click "New News Item"
3. Fill in:
   - **Title** (e.g., "Peace Summit 2024")
   - **Date** (click calendar to pick)
   - **Description** (e.g., "Join us for our annual peace summit...")
4. Click "Save" (top right)
5. After 60 seconds, refresh the website and your new item appears!

To make it appear in French too, add a separate French version:
- The CMS interface will show a language toggle at the top
- Switch to "French" and fill in the translated content

### Add Resources

Same process as News, but click "Resources" instead.

### Upload Images

You can upload images within the CMS:
1. In any field that supports images, click the image icon
2. Click "Choose image" and upload a file
3. It saves automatically to `/images/uploads/`

---

## Automatic Deployments

Every time you (or a team member) adds content via the CMS:

1. They click "Save"
2. Decap CMS commits the change to GitHub automatically
3. Cloudflare detects the change and rebuilds the site
4. Site updates within 1-2 minutes (usually faster)

**No manual deploy needed!** It's fully automatic.

---

## Troubleshooting

### Site won't build on Cloudflare

Check the build logs in Cloudflare Pages → Your project → "Deployments" → latest build.

Common issues:
- Missing Node.js version specification (should be v18+)
- Typos in `astro.config.mjs`
- Missing dependencies in `package.json`

**Fix**: Look at the build log, fix the error, push again.

### Contact form not working

1. Verify Web3Forms access key is correct in `src/pages/en/index.astro`
2. Test by visiting the form and submitting
3. Check your email (including spam folder)
4. If nothing works, re-create your Web3Forms form and get a new access key

### CMS admin panel shows 404

Make sure you're accessing `/admin` (with trailing slash): `https://yourdomain.com/admin/`

### Content added to CMS doesn't appear

1. Make sure you clicked "Save" in the CMS
2. Wait 2-3 minutes for the site to rebuild
3. Hard-refresh your browser (`Cmd+Shift+R` on Mac, `Ctrl+Shift+R` on Windows)
4. Check GitHub: go to your repo → click the folder for the language (en or fr) → navigate to `src/content/` to see if the file was created

### Language toggle not working

1. Ensure you have both `/en/` and `/fr/` versions of pages
2. Check that `astro.config.mjs` has `i18n` configured
3. Check browser console for errors (F12 → Console tab)

---

## Security Notes

1. **Web3Forms Access Key**: This is in your HTML (not secret), but only Web3Forms and your email can be compromised by someone knowing it. It's acceptable to expose.
2. **Decap CMS**: Only people with GitHub access can edit. Make sure your GitHub password is strong.
3. **Contact Emails**: Go to `peaceabilityngo@gmail.com`. Consider using Gmail's app-specific passwords if you enable 2FA.

---

## Next Steps

1. ✅ Set up accounts (Web3Forms, GitHub, Cloudflare)
2. ✅ Deploy the site
3. ✅ Test everything works
4. Add more content via the CMS
5. Invite team members to contribute (give them GitHub access)
6. Monitor emails for contact form submissions
7. Update news/resources regularly

---

## Support Resources

- **Astro Docs**: https://docs.astro.build/
- **Decap CMS Docs**: https://decapcms.org/docs/
- **Web3Forms Docs**: https://docs.web3forms.com/
- **Cloudflare Pages Docs**: https://developers.cloudflare.com/pages/

---

Good luck! Your PeaceAbility website is now live. 🕊️
