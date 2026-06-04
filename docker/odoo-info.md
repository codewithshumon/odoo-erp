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