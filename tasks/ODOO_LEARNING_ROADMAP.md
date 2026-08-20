# 🚀 Odoo Learning Roadmap — Sample ERP Project

> **Goal:** Build a complete Odoo project using both **custom** and **existing** modules, exploring all core Odoo features — step by step, by yourself, with guided help.

---

## 📌 Project Idea: **"SmartBiz ERP"**
A small-business ERP covering:
- **Sales & CRM**
- **Inventory & Purchasing**
- **Accounting**
- **Employees & Payroll (basic)**
- **Project Management**
- **Custom Module:** Rental Management (e.g., equipment rental tracking)

---

## PHASE 1: Environment Setup & First Run

### Step 1.1 — Install Odoo Dependencies
- [ ] Install Python 3.10+, PostgreSQL, Node.js, wkhtmltopdf
- [ ] Install Python packages: `pip install -r requirements.txt`

### Step 1.2 — Clone & Setup Odoo
- [ ] Clone Odoo Community Edition from GitHub
- [ ] Create PostgreSQL user/role for Odoo
- [ ] Create an empty database for the project

### Step 1.3 — Create Your Project Structure
```
smartbiz-erp/
├── odoo/              # Odoo source code (community)
├── custom_addons/     # Your custom modules
├── config/
│   └── odoo.conf      # Odoo configuration file
└── requirements.txt   # Project-specific Python deps
```

### Step 1.4 — First Run
- [ ] Start Odoo with `odoo-bin -c config/odoo.conf`
- [ ] Open `http://localhost:8069`
- [ ] Create your first database via the web UI
- [ ] Activate **Developer Mode** (Settings → Activate Developer Mode)

---

## PHASE 2: Understand the Basics

### Step 2.1 — Explore the UI as a User
- [ ] Navigate through **Sales, Inventory, Accounting, CRM** apps
- [ ] Create a sample Quotation → Sales Order → Invoice → Payment
- [ ] Understand the flow: **Lead → Opportunity → Quotation → Sale → Delivery → Invoice**

### Step 2.2 — Understand Odoo Architecture
- [ ] Learn the **MVC architecture**: Model (Python), View (XML), Controller (Python/Web)
- [ ] Understand **ORM**: `create()`, `write()`, `search()`, `browse()`, `unlink()`
- [ ] Understand **Record Rules**, **Access Rights**, **Groups**
- [ ] Learn about **QWeb** templates for reports and kanban views

### Step 3 — Explore Existing Modules
- [ ] Go to **Apps** menu and install key modules:
  - `sales` (Sales Management)
  - `purchase` (Purchase)
  - `stock` (Inventory)
  - `account` (Invoicing / Accounting)
  - `crm` (CRM)
  - `project` (Project Management)
  - `hr` (Human Resources)
- [ ] Explore the **Technical** menu (with Developer Mode on):
  - Models, Views, Actions, Menus, Server Actions, Automated Actions, etc.

---

## PHASE 3: Build Your First Custom Module

### Step 3.1 — Scaffold the Module
- [ ] Create module folder: `custom_addons/rental_management/`
- [ ] Create required files:
  - `__manifest__.py` — module metadata & dependencies
  - `__init__.py` — Python package init
  - `models/__init__.py`
  - `models/rental_order.py`
  - `views/rental_order_views.xml`
  - `security/ir.model.access.csv`
  - `data/rental_sequence.xml`

### Step 3.2 — Define the Data Model
- [ ] Create `rental.order` model with fields:
  - `name` (Char, required)
  - `customer_id` (Many2one → `res.partner`)
  - `product_id` (Many2one → `product.product`)
  - `rental_start_date` (Date)
  - `rental_end_date` (Date)
  - `state` (Selection: draft, confirmed, ongoing, returned, cancelled)
  - `total_amount` (Float, computed)

### Step 3.3 — Create Views
- [ ] **Tree View** — list of rental orders
- [ ] **Form View** — detailed rental order form
- [ ] **Search View** — filters and group-by options
- [ ] **Kanban View** — visual status board
- [ ] **Action & Menu Items** — add to the Odoo menu

### Step 3.4 — Add Business Logic
- [ ] Override `create()` to auto-generate sequence number
- [ ] Add `confirm()`, `start()`, `return()`, `cancel()` methods
- [ ] Add computed field `duration_days` (rental_end_date - rental_start_date)
- [ ] Add constraints (`@api.constrains`) — e.g., end date must be after start date
- [ ] Add `onchange` to auto-calculate total amount based on daily rate × duration

### Step 3.5 — Security & Access Rights
- [ ] Define access rules in `ir.model.access.csv`
- [ ] Create Record Rules (e.g., users can only see their own rental orders)
- [ ] Assign groups: Rental User, Rental Manager

---

## PHASE 4: Integrate with Existing Modules

### Step 4.1 — Link Rental to Sales
- [ ] Add a button "Create Sales Order" on `rental.order`
- [ ] On confirmation, auto-create a `sale.order` using Odoo's existing `sale` module
- [ ] Link the two records (Many2one on rental → sale_order_id)

### Step 4.2 — Link Rental to Inventory
- [ ] When rental starts, create a `stock.picking` (delivery) to move product to customer location
- [ ] When rental ends, create a return picking
- [ ] Track product availability using existing `stock` module

### Step 4.3 — Link Rental to Accounting
- [ ] When rental is confirmed, create a `account.move` (customer invoice)
- [ ] Track payment status on the rental order

### Step 4.4 — Link Rental to CRM
- [ ] Option to convert a CRM **Opportunity** into a Rental Order
- [ ] Log rental activities in the customer's chatter/history

---

## PHASE 5: Advanced Odoo Features

### Step 5.1 — Reports & QWeb
- [ ] Create a **PDF Report** for Rental Agreement (QWeb template)
- [ ] Create a **PDF Report** for Rental Invoice Summary
- [ ] Add a print button on the rental order form

### Step 5.2 — Automated Actions & Scheduled Jobs
- [ ] Create an **Automated Action**:
  - If rental end date is today → send reminder email
- [ ] Create a **Scheduled Job (Cron)**:
  - Daily check for overdue rentals and change state to "overdue"

### Step 5.3 — Email Templates
- [ ] Create email template: Rental Confirmation
- [ ] Create email template: Rental Return Reminder
- [ ] Send emails via `mail.template` on state changes

### Step 5.4 — Dashboard & KPIs
- [ ] Create a **Dashboard** with:
  - Total active rentals
  - Revenue this month
  - Overdue rentals
  - Top rented products
- [ ] Use `board` module or create custom dashboard view

### Step 5.5 — Web Controllers (Optional)
- [ ] Create a public-facing **Rental Inquiry Form** (`/rental/inquiry`)
- [ ] Save inquiries as CRM Leads or Rental Orders

### Step 5.6 — Website Integration (Optional)
- [ ] Create a simple **Odoo Website page** showing available products for rent
- [ ] Allow online rental requests

---

## PHASE 6: Data & Configuration

### Step 6.1 — Master Data
- [ ] Create **Rental Product Categories**
- [ ] Create **Rental Products** with daily/weekly/monthly rates
- [ ] Configure **Units of Measure** for rental periods

### Step 6.2 — Demo Data
- [ ] Add `demo/rental_demo.xml` with sample rental orders
- [ ] Add demo products, customers, and rental records

### Step 6.3 — Translations (i18n)
- [ ] Export `.pot` file for your module
- [ ] Create Bengali (`bn.po`) and Arabic (`ar.po`) translations
- [ ] Test switching languages

---

## PHASE 7: Testing & Quality

### Step 7.1 — Unit Tests
- [ ] Write Python unit tests in `tests/test_rental.py`
- [ ] Test model creation, state transitions, computed fields
- [ ] Run tests with: `odoo-bin -i rental_management --test-enable`

### Step 7.2 — Constraints & Validation
- [ ] Test that you cannot rent an unavailable product
- [ ] Test that end date cannot be before start date
- [ ] Test access rights (user vs manager)

### Step 7.3 — Debug & Logging
- [ ] Use `_logger` for debugging
- [ ] Practice using `pdb` or `ipdb` for debugging
- [ ] Learn to read Odoo logs effectively

---

## PHASE 8: Deployment & Documentation

### Step 8.1 — Module Documentation
- [ ] Write `README.md` for your module
- [ ] Add docstrings to Python classes and methods
- [ ] Document the business flow with diagrams

### Step 8.2 — Prepare for Deployment
- [ ] Create a `Dockerfile` for your Odoo project
- [ ] Create `docker-compose.yml` with Odoo + PostgreSQL services
- [ ] Test running everything with Docker

### Step 8.3 — Backup & Restore
- [ ] Practice PostgreSQL backup (`pg_dump`) and restore
- [ ] Understand Odoo's database management UI (`/web/database/manager`)

---

## 🛠️ Tools & Commands Cheat Sheet

| Task | Command |
|------|---------|
| Start Odoo | `./odoo-bin -c odoo.conf` |
| Install module | `./odoo-bin -c odoo.conf -i rental_management` |
| Update module | `./odoo-bin -c odoo.conf -u rental_management` |
| Run tests | `./odoo-bin -c odoo.conf -u rental_management --test-enable` |
| Scaffold module | `./odoo-bin scaffold rental_management custom_addons/` |
| Create database | `./odoo-bin -c odoo.conf -d smartbiz --init base` |

---

## 📚 Recommended Learning Resources

1. **Official Odoo Documentation**: https://www.odoo.com/documentation/
2. **Odoo Guidelines**: https://www.odoo.com/documentation/master/contributing/development.html
3. **Odoo ORM API**: https://www.odoo.com/documentation/master/developer/reference/backend/orm.html
4. **QWeb Reports**: https://www.odoo.com/documentation/master/developer/reference/backend/reports.html

---

## ✅ Completion Checklist

- [ ] Odoo installed and running locally
- [ ] First database created
- [ ] Existing modules explored and understood
- [ ] Custom module (`rental_management`) created
- [ ] Models, Views, Actions, Menus implemented
- [ ] Business logic (state machine, computed fields) working
- [ ] Integration with Sales, Inventory, Accounting done
- [ ] Reports (PDF) generated via QWeb
- [ ] Automated actions and scheduled jobs running
- [ ] Email templates configured and sending
- [ ] Dashboard with KPIs created
- [ ] Unit tests written and passing
- [ ] Module deployed via Docker
- [ ] Documentation complete

---

## 🎯 Next Steps

> **Tell me: "I am ready for Step X.Y"** and I will guide you through that specific step with detailed instructions. We will go one step at a time.

---

*Roadmap created for learning Odoo ERP development from scratch.*
