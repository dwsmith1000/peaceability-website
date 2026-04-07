# PeaceAbility Website

A modern, bilingual (English/French) website for PeaceAbility NGO built with Astro, Decap CMS, and hosted on Cloudflare Pages.

## Features

- **3-Column Layout**: News & Events, Resources, and Global News (UN News RSS feed)
- **Bilingual Support**: English and French with easy language toggle
- **Non-Technical CMS**: Decap CMS provides a web-based editor for adding/editing content
- **Contact Form**: Secure contact submissions via Web3Forms
- **PeaceAbility Branding**: Lime green (#BADA55) and navy blue (#1F3B5C) colors with custom styling
- **Responsive Design**: Works seamlessly on mobile, tablet, and desktop

## Quick Start

### 1. Create a GitHub Repository

1. Go to [GitHub.com](https://github.com/new) and create a new repository named `peaceability-website`
2. Clone it to your computer:
   ```bash
   git clone https://github.com/YOUR_USERNAME/peaceability-website.git
   cd peaceability-website
   ```

### 2. Set Up the Project Locally

1. Make sure you have [Node.js](https://nodejs.org/) installed (v18 or higher)
2. Copy all the files from this project into your cloned repository
3. Install dependencies:
   ```bash
   npm install
   ```

4. Add your PeaceAbility logo to `public/images/logo.png` (PNG or SVG format, 400x300px recommended)

### 3. Create a Web3Forms Account (for Contact Form)

1. Go to [Web3Forms.com](https://web3forms.com/) and sign up for a free account
2. Create a new form and get your **Access Key**
3. In `src/pages/en/index.astro` and `src/pages/fr/index.astro`, replace `YOUR_WEB3FORMS_KEY_HERE` with your actual access key
4. Also update the redirect URLs to your actual domain name

### 4. Configure Decap CMS for GitHub Authentication

1. Go to [Decap CMS documentation](https://decapcms.org/docs/github-backend/)
2. Set up OAuth with GitHub:
   - Go to your GitHub Settings → Developer settings → OAuth Apps → New OAuth App
   - Application name: `PeaceAbility CMS`
   - Homepage URL: `https://yourdomain.com` (or your Cloudflare Pages URL)
   - Authorization callback URL: `https://yourdomain.com/api/auth`
   - Copy your **Client ID**
3. Update `public/admin/config.yml`:
   - Replace `YOUR_GITHUB_USERNAME` with your GitHub username
   - Update the repo name if different
4. You'll need to use Decap CMS's Netlify integration or set up a proxy for GitHub OAuth (Cloudflare Workers can do this)

### 5. Test Locally

```bash
npm run dev
```

Visit `http://localhost:3000` in your browser. You should see the PeaceAbility website with the 3-column layout.

To access the CMS locally, visit `http://localhost:3000/admin` (note: auth may require being deployed first).

## Adding Content

### News & Events
Once the CMS is configured:
1. Go to `/admin`
2. Click "News & Events"
3. Click "New News Item"
4. Fill in the title, date, and description
5. Save and publish

The item will automatically appear in the News column on both English and French versions.

### Resources
Same process as News, but click "Resources" in the CMS menu.

## Deploying to Cloudflare Pages

### 1. Push to GitHub

```bash
git add .
git commit -m "Initial PeaceAbility website setup"
git push origin main
```

### 2. Connect to Cloudflare Pages

1. Log in to your Cloudflare account
2. Go to Pages → Create a project
3. Select "Connect to Git" → authorize GitHub
4. Select the `peaceability-website` repository
5. Build settings:
   - Framework preset: `Astro`
   - Build command: `npm run build`
   - Build output directory: `dist`
6. Click "Save and Deploy"

Cloudflare Pages will automatically deploy your site and give you a URL like `peaceability-website.pages.dev`.

### 3. Connect Your Custom Domain

1. In Cloudflare, go to your Pages project → Custom domains
2. Add your domain (e.g., `peaceability.org`)
3. Follow the DNS setup instructions

### 4. Enable Automatic Deployments

Every time you push to GitHub, Cloudflare Pages will automatically rebuild and redeploy your site.

## File Structure

```
peaceability-website/
├── src/
│   ├── pages/
│   │   ├── en/index.astro        # English home page
│   │   └── fr/index.astro        # French home page
│   ├── components/
│   │   └── ThreeColumnLayout.astro
│   ├── layouts/
│   │   └── BaseLayout.astro      # Main layout with header/footer
│   ├── styles/
│   │   └── global.css            # PeaceAbility branding colors
│   └── content/                  # Markdown content (managed by CMS)
├── public/
│   ├── admin/
│   │   ├── config.yml            # Decap CMS configuration
│   │   └── index.html            # CMS interface
│   └── images/
│       └── logo.png              # PeaceAbility logo
├── astro.config.mjs              # Astro configuration (i18n settings)
└── package.json
```

## RSS Feed Integration

The RSS column displays the latest 5 articles from UN News. To change the RSS feed source:

1. Edit the RSS parsing logic (currently pulls from `https://news.un.org/en/rss-feeds`)
2. The feed updates automatically when you rebuild the site

## Customization

### Change Colors
Edit `src/styles/global.css` and update the CSS variables:
```css
--color-lime: #BADA55;
--color-navy: #1F3B5C;
```

### Change Translations
Edit the `translations` objects in:
- `src/layouts/BaseLayout.astro`
- `src/pages/en/index.astro`
- `src/pages/fr/index.astro`

### Add New Pages
Create new `.astro` files in `src/pages/en/` and `src/pages/fr/` for additional pages.

## Future Considerations

### Transferring to Another User

When ready to transfer the site to another team member:

1. On GitHub: Go to your repo → Settings → Danger zone → Transfer ownership
2. Transfer to the new owner's account
3. Update Decap CMS OAuth credentials with their GitHub app
4. Update Cloudflare Pages to use the new repository
5. Update DNS records if transferring domain ownership

No code changes needed — the architecture is designed for this transition.

## Support & Troubleshooting

**CMS not loading?**
- Ensure GitHub OAuth is properly configured
- Check that your redirect URL matches your domain exactly
- Browsers may cache old configs — try incognito/private mode

**Decap CMS not showing content?**
- Ensure content files are committed to GitHub (not just in `src/content/` locally)
- Check that the folder structure matches `config.yml` exactly

**Contact form not working?**
- Verify your Web3Forms access key is correct
- Check that the redirect URL is valid
- Test the form locally first

## Technical Stack

- **Astro**: Static site generator
- **Decap CMS**: Headless CMS for content management
- **Web3Forms**: Serverless form backend
- **Cloudflare Pages**: Hosting and CDN
- **GitHub**: Repository and version control

## License

© 2024 PeaceAbility NGO. All rights reserved.
