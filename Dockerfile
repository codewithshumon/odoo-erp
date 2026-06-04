FROM python:3.12-slim-bookworm

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    libxml2-dev \
    libxslt1-dev \
    libldap2-dev \
    libsasl2-dev \
    libtiff5-dev \
    libjpeg62-turbo-dev \
    libopenjp2-7-dev \
    zlib1g-dev \
    libfreetype6-dev \
    liblcms2-dev \
    libwebp-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libxcb1-dev \
    libpng-dev \
    libssl-dev \
    libffi-dev \
    libzip-dev \
    libblas-dev \
    liblapack-dev \
    gfortran \
    nodejs \
    npm \
    wkhtmltopdf \
    git \
    curl \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Create odoo user and directories
RUN useradd -m -d /var/lib/odoo -U -r -s /bin/bash odoo \
    && mkdir -p /etc/odoo /var/log/odoo /mnt/extra-addons /opt/odoo \
    && chown -R odoo:odoo /etc/odoo /var/log/odoo /var/lib/odoo /mnt/extra-addons /opt/odoo

# Set working directory
WORKDIR /opt/odoo

# Copy and install Python requirements first (for better layer caching)
COPY --chown=odoo:odoo requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy entrypoint script
COPY --chown=odoo:odoo docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Switch to odoo user
USER odoo

# Expose Odoo services
EXPOSE 8069 8072

# Default entrypoint and command
ENTRYPOINT ["/entrypoint.sh"]
CMD ["./odoo-bin", "-c", "/etc/odoo/odoo.conf"]