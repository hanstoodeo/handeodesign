# UK Car Marketplace — Project Brief for Claude Code

## What this app is
A mobile-first UK car marketplace for private sellers and buyers.
The goal is to provide a fairer, more transparent alternative to Autotrader —
free to list for private sellers, with integrated Stripe payments and built-in
buyer/seller trust tools.

Core competitors studied: Autotrader, Collecting Cars, PistonHeads.
Our wedge: binding holding deposits + free private listings + mobile-first UX.
No other UK platform combines these three things today.

---

## Target market
- UK only (GBP currency throughout, UK phone number validation)
- Mobile-first: iOS and Android via React Native
- Primary seller: private individual, 25–50, selling 1–3 cars per year
- Primary buyer: private individual, 25–45, budget £3,000–£25,000
- Not targeting dealers in V1

---

## Tech stack
| Layer         | Choice          | Notes                                              |
|---------------|-----------------|----------------------------------------------------|
| Frontend      | React Native    | Single codebase for iOS + Android                  |
| Backend + DB  | Supabase        | PostgreSQL, auth, real-time, storage               |
| Payments      | Stripe Connect  | Marketplace payouts, deposits, platform fee splits |
| Reg lookup    | DVLA API        | Auto-fill make/model/spec from number plate        |
| Shipping      | EasyPost        | Phase 2 — transport quotes and booking             |
| HPI checks    | DVLA / HPI API  | Phase 2 — finance, stolen, write-off status        |

---

## User roles
Two roles exist: `seller` and `buyer`. A user can hold both roles.

### Seller
- Registers with email + UK mobile (verified via OTP)
- Completes Stripe Connect onboarding before first listing goes live
- Has a public seller profile: photo, name, member since, rating (Phase 2)
- Can create, edit, pause, and delete listings
- Receives Stripe payout when deposit or full payment is confirmed

### Buyer
- Registers with email + UK mobile (verified via OTP)
- Browses and saves listings without payment details required
- Adds card via Stripe before placing a holding deposit
- Can message sellers through in-app chat only

---

## Core data model (V1)

### users
- id, email, phone, full_name, avatar_url
- role: 'buyer' | 'seller' | 'both'
- stripe_account_id (sellers only)
- verified: boolean
- created_at

### listings
- id, seller_id (→ users)
- reg_plate, make, model, year, mileage, fuel_type, transmission
- colour, body_type, engine_size
- description, asking_price (GBP pence, integer)
- status: 'draft' | 'active' | 'reserved' | 'sold' | 'withdrawn'
- location_postcode, location_lat, location_lng
- mot_expiry, service_history: boolean
- created_at, updated_at

### listing_images
- id, listing_id, url, position (integer), is_primary: boolean

### messages
- id, listing_id, sender_id, recipient_id, body, read_at, created_at

### deposits
- id, listing_id, buyer_id, seller_id
- amount_pence (default 25000 = £250)
- stripe_payment_intent_id
- status: 'pending' | 'held' | 'released_to_seller' | 'refunded'
- created_at

---

## V1 feature list

### Phase 1 (build first)
1. **Auth** — email + UK phone OTP via Supabase Auth
2. **Seller onboarding** — profile setup + Stripe Connect account creation
3. **Listing creation** — reg plate input → DVLA auto-fill → photo upload (20+ images) → price → publish
4. **Search & browse** — filter by make, model, price range, mileage, fuel type, location radius
5. **Saved searches** — push notification when new matching listing goes live
6. **In-app messaging** — buyer initiates chat; phone numbers never shown until deposit placed
7. **Holding deposit** — buyer pays £250 via Stripe to reserve a listing; funds held until confirmed or refunded

### Phase 2 (do not build yet)
- Full vehicle payment via Stripe Connect
- Shipping booking via EasyPost API
- HPI / DVLA check badge on every listing
- Seller and buyer ratings + reviews
- Dealer account type
- Auction listing format
- Analytics dashboard for sellers

---

## Key business rules
- All monetary values stored as integers in GBP pence (e.g. £250 = 25000)
- Platform fee: 2% of deposit, collected via Stripe Connect application fee
- A listing moves to `reserved` status the moment a deposit is placed
- Only one active deposit per listing at a time
- Buyer can cancel and receive full refund within 48 hours
- After 48 hours, seller may retain deposit if buyer cancels (Phase 2 dispute flow)
- Sellers must complete Stripe Connect onboarding before any listing goes live
- Phone numbers are masked in chat until deposit is placed by buyer

---

## UI & UX conventions
- Mobile-first always: design for 390px width, scale up
- Sentence case everywhere — no title case in UI labels
- Primary actions are full-width bottom buttons on mobile
- Listing photos: first image is hero; minimum 5 required to publish
- Price is always displayed as £X,XXX with comma formatting
- Distance shown as miles (not km) — UK standard
- Postcode used for location, not full address (privacy)

---

## Code conventions
- TypeScript throughout (strict mode)
- Component naming: PascalCase
- File naming: kebab-case
- Supabase client: initialised once in /lib/supabase.ts
- Stripe client: initialised in /lib/stripe.ts
- Environment variables: never hardcode keys; always use .env
- All API calls go through /services/ layer, not directly in components
- Error states and loading states required on every async operation

---

## Folder structure
```
/app              React Native screens (Expo Router)
  /(auth)         Login, register, OTP verification
  /(buyer)        Browse, search, listing detail, chat, deposit
  /(seller)       Dashboard, create listing, manage listings
  /(shared)       Profile, settings, notifications
/components       Reusable UI components
/services         Supabase queries, Stripe calls, DVLA API
/lib              Supabase client, Stripe client, constants
/hooks            Custom React hooks
/types            TypeScript types and interfaces
/utils            Formatting helpers (price, date, distance)
```

---

## What NOT to do
- Do not build dealer-facing features in V1
- Do not build a web version — mobile app only for now
- Do not store full payment card details anywhere — Stripe handles this
- Do not expose seller phone numbers before a deposit is placed
- Do not use any hardcoded GBP amounts — all prices come from the database
- Do not build the auction format in V1 — buy-it-now and deposit only

---

## Definition of done for each feature
A feature is complete when:
1. It works on both iOS (simulator) and Android (emulator)
2. It handles loading state, error state, and empty state
3. It does not expose sensitive data (phone, email) prematurely
4. Stripe calls go through the /services layer, not inline
5. TypeScript has no `any` types in the feature's files
