Clone Odoo 19.0
Run this in your project folder:


cd ~/Documents/erp-odoo
git clone https://github.com/odoo/odoo.git --depth 1 --branch 19.0
Then continue with the rest:


# Create virtual environment
python3 -m venv venv
source venv/bin/activate

# Upgrade pip tools
pip install --upgrade pip wheel setuptools

# Install Odoo requirements
pip install -r odoo/requirements.txt
If pip install fails on Python 3.13, paste the last 10 lines of the error here.

Finally verify:


python odoo/odoo-bin --version







Perfect. Here's your complete setup — Odoo native, PostgreSQL in Docker:

1. Start PostgreSQL (Docker)

docker run -d --name odoo_postgres \
  -e POSTGRES_USER=odoo \
  -e POSTGRES_PASSWORD=odoo \
  -e POSTGRES_DB=postgres \
  -p 5432:5432 \
  postgres:16-alpine
2. Set up Python virtual environment

cd /home/shumon/Documents/odoo-erp
python3 -m venv venv
source venv/bin/activate
3. Install Python dependencies
I already created requirements-kali.txt which replaces psycopg2 (needs compilation) with psycopg2-binary (precompiled wheel):


pip install -r requirements-kali.txt
Note: On Kali, python-ldap or libsass might fail if they try to compile. If that happens, install everything except those two:


pip install $(grep -v -E '^(python-ldap|libsass)' requirements-kali.txt)
python-ldap is only needed for LDAP auth. libsass is for SCSS — you can add them later if needed.

4. Run Odoo
I already created config/local.conf pointing to localhost:


./odoo-bin -c config/local.conf
Then open http://localhost:8069

The first boot will create the smartbiz database automatically (or show the database selector if it doesn't).

