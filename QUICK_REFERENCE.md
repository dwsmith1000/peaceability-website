# PeaceAbility Website - Quick Reference Card

Keep this handy while setting up!

## 🔗 Important URLs

| Service | URL | Action |
|---------|-----|--------|
| GitHub | https://github.com/new | Create `peaceability-website` repo |
| Node.js | https://nodejs.org | Download & install (v18+) |
| Web3Forms | https://web3forms.com | Sign up → create form → get access key |
| Cloudflare | https://dash.cloudflare.com | Deploy Pages project |
| Your Domain | Your domain registrar | Manage DNS (optional) |

## 📝 Configuration Steps

### 1. Web3Forms Access Key
**File**: `src/pages/en/index.astro` (and `fr/index.astro`)
**Find**: `access_key" value="YOUR_WEB3FORMS_KEY_HERE"`
**Replace with**: Your actual Web3Forms access key

### 2. Decap CMS GitHub Config
**File**: `public/admin/config.yml`
**Find**: `repo: YOUR_GITHUB_USERNAME/peaceability-website`
**Replace with**: `repo: your-actual-username/peaceability-website`

### 3. Domain URLs in Contact Form
**Files**: `src/pages/en/index.astro` and `src/pages/fr/index.astro`
**Find**: `redirect" value="https://yourdomain.com/..."`
**Replace with**: Your actual domain or Cloudflare Pages URL

## 🎯 Brand Colors

- **Primary Green**: `#BADA55` (Lime)
- **Primary Blue**: `#1F3B5C` (Navy)
- **Background**: `#FFFFFF` (White)
- **Light Background**: `#F5F5F5` (Light Gray)

## 📚 File Reference

| File | Purpose | When to Edit |
|------|---------|-------------|
| `src/pages/en/index.astro` | English home page | Sample content, Web3Forms key |
| `src/pages/fr/index.astro` | French home page | Sample content, Web3Forms key |
| `src/styles/global.css` | All styling | Colors, fonts, layout |
| `astro.config.mjs` | Astro settings | Languages (EN/FR) |
| `public/admin/config.yml` | CMS settings | GitHub repo, collections |
| `package.json` | Dependencies | Rarely, unless adding packages |

## ⚡ Commands You'll Use

```bash
# Install dependencies (once at start)
npm install

# Test locally
npm run dev

# Build for production
npm run build

# View live site
npm run preview
```

## 🔄 Deployment Flow

1. **Local**: Edit files, test with `npm run dev`
2. **GitHub**: `git add .` → `git commit -m "..."` → `git push`
3. **Cloudflare**: Auto-builds and deploys within 2-3 minutes
4. **Live**: Visit your domain to see changes

## 📧 Contact Form

- **Receives emails at**: peaceabilityngo@gmail.com (via Web3Forms)
- **Change email**: Update Web3Forms account settings
- **Redirect page**: Users sent to `/en/thank-you` or `/fr/merci`

## 🌐 Languages

- **English**: `/en/` in URL
- **French**: `/fr/` in URL
- **Toggle**: Click flag in top right (🇬🇧 or 🇫🇷)

## 📊 3-Column Layout

| Left | Center | Right |
|------|--------|-------|
| News & Events | Resources | UN News (RSS) |
| Managed by CMS | Managed by CMS | Auto-refreshing |

## 🔐 Access Control

- **Website editors**: Need GitHub account + repo access
- **CMS access**: At `/admin` → login with GitHub
- **Publish changes**: Auto-push to GitHub by Decap CMS
- **Who can edit**: Anyone with GitHub repo access

## 📱 Testing Checklist

- [ ] Logo displays in header
- [ ] Language toggle works (EN ↔ FR)
- [ ] 3 columns visible on desktop
- [ ] Responsive on mobile (1 column)
- [ ] Contact form submits
- [ ] Email received
- [ ] Thank you page shows
- [ ] UN News feed displays
- [ ] Lime green and navy blue colors visible

## 🚨 Common Issues

| Problem | Solution |
|---------|----------|
| Build fails | Check astro.config.mjs syntax, Node.js version |
| Form doesn't send | Verify Web3Forms access key is correct |
| CMS won't load | Ensure GitHub OAuth app is configured |
| Colors look wrong | Check CSS custom properties in global.css |
| French doesn't show | Create content separately in CMS for "fr" locale |

## 📞 Documentation Guide

| Question | Read |
|----------|------|
| How do I set up? | DEPLOYMENT_GUIDE.md |
| How do I edit content? | CMS_USER_GUIDE.md |
| What's included? | SETUP_SUMMARY.md |
| General info? | README.md |

## 🎬 Next Action

1. Read **DEPLOYMENT_GUIDE.md** from top to bottom
2. Follow steps 1-6 in order
3. Refer to **CMS_USER_GUIDE.md** for content editing
4. Keep this card handy for quick reference

---

**Questions? Check the documentation files first!**

Good luck! 🕊️
