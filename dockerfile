# Use Arch Linux as the base image
FROM --platform=linux/amd64 archlinux:latest

# Update the system, install base-devel, git, wget, python-pip, unzip and necessary compilers
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm base-devel git wget python-pip unzip gcc make cmake autoconf automake libtool

# Install Qt6 and additional dependencies
RUN pacman -S --noconfirm qt6-base qt6-svg qt6-shadertools qt6-declarative qt6-imageformats qt6-webchannel qt6-location qt6-wayland qt6-sensors qt6-webengine \
    python-pyqt6 python-pyqt6-sip sip pyqt-builder \
    libunrar unrar chmlib hunspell uchardet podofo-tools zlib bzip2 xz unrar brotli zstd expat sqlite libffi openssl ncurses readline icu libjpeg libpng libtiff libwebp graphite libxml2 libxslt optipng libusb libmtp openjpeg2 poppler libgpg-error libgcrypt glib2 dbus nodejs speech-dispatcher hyphen jxrlib libiconv dbus-glib libstemmer python-apsw

# Create a virtual environment
RUN python -m venv --system-site-packages /venv
RUN source /venv/bin/activate && \
    pip install --upgrade pip setuptools wheel && \
    pip install --upgrade sip PyQt6 && \
    pip install \
    installer==0.7.0 packaging==23.1 pyproject_hooks==1.0.0 wheel==0.41.2 setuptools==68.2.2 setuptools_scm==8.0.3 six==1.16.0 unrardll==0.1.7 lxml==4.9.3 pychm==0.8.6 html5-parser==0.4.12 css_parser==1.0.10 python_dateutil==2.8.2 jeepney==0.8.0 dnspython==2.4.2 mechanize==0.4.8 feedparser==6.0.10 sgmllib3k==1

# Clone the Calibre and bypy repositories
WORKDIR /calibre-build
RUN if [ -d "calibre/.git" ]; then \
        cd calibre && git pull; \
    else \
        git clone --depth 1 https://github.com/mingchen1107/calibre.git; \
    fi && \
    if [ -d "bypy/.git" ]; then \
        cd bypy && git pull; \
    else \
        git clone --depth 1 https://github.com/kovidgoyal/bypy.git bypy; \
    fi


WORKDIR /calibre-build/calibre

# Calibre's pre-build set-up and dependency requirements have been completed. You can now run Calibre build commands such as `python3 setup.py bootstrap` and other build steps.
