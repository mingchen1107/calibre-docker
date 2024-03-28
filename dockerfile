# Using Arch Linux as the base image as advised by the maintainer due to its up-to-date package manager
FROM --platform=linux/amd64 archlinux:latest

# Update the system and install necessary packages with pacman
RUN pacman -Syu --noconfirm \
    && pacman -S --noconfirm base-devel git wget python-pip unzip qt6-base qt6-svg qt6-shadertools qt6-declarative qt6-imageformats qt6-webchannel qt6-location qt6-wayland qt6-sensors qt6-webengine hunspell uchardet podofo-tools zlib bzip2 xz unrar brotli zstd expat sqlite libffi openssl ncurses icu libjpeg libpng libtiff libwebp graphite libxml2 libxslt optipng libusb libmtp openjpeg2 poppler libgpg-error libgcrypt glib2 dbus nodejs speech-dispatcher hyphen jxrlib libiconv dbus-glib libstemmer qt6-tools

# Create a virtual environment to install Python dependencies
RUN python -m venv --system-site-packages /venv \
    && /venv/bin/pip install installer==0.7.0 packaging==23.1 pyproject_hooks==1.0.0 wheel==0.41.2 setuptools==68.2.2 setuptools_scm==8.0.3 six==1.16.0 unrardll==0.1.7 lxml==4.9.3 pychm==0.8.6 html5-parser==0.4.12 css_parser==1.0.10 python_dateutil==2.8.2 jeepney==0.8.0 dnspython==2.4.2 mechanize==0.4.8 feedparser==6.0.10 sgmllib3k==1

# Set upper level working directory for Calibre build
WORKDIR /calibre-build

# Clone the Calibre and bypy repositories if they don't exist, or pull the latest changes if they do
RUN git clone --depth 1 https://github.com/mingchen1107/calibre.git calibre || (cd calibre && git pull) \
    && git clone --depth 1 https://github.com/kovidgoyal/bypy.git bypy || (cd bypy && git pull)

# Calibre's pre-build set-up and dependency requirements have been completed. You can now run Calibre build commands such as `python3 setup.py bootstrap` and other build steps.
