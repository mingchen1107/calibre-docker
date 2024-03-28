# Use Arch Linux as the base image
FROM --platform=linux/amd64 archlinux:latest

# Update the system and install base-devel for building packages
RUN pacman -Syu --noconfirm \
    && pacman -S --noconfirm base-devel git wget python-pip unzip 

# Define working directory for dependencies
WORKDIR /deps

# Function to download and extract
RUN echo 'download_and_extract() { wget $1 -O temp.tar.gz && mkdir -p $2 && tar -xf temp.tar.gz -C $2 --strip-components=1 && rm temp.tar.gz; }' >> /root/.bashrc

# Source the function
RUN source /root/.bashrc

# Download and extract each dependency
RUN download_and_extract() { \
        wget $1 -O temp.tar.gz && \
        mkdir -p $2 && \
        if [ ${1: -4} == ".zip" ]; then \
            unzip temp.tar.gz -d $2; \
        else \
            tar -xf temp.tar.gz -C $2 --strip-components=1; \
        fi && \
        rm temp.tar.gz; \
    } && \    
    download_and_extract "https://zlib.net/zlib-1.3.1.tar.xz" "zlib" \
    && download_and_extract "https://sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz" "bzip2" \
    && download_and_extract "https://tukaani.org/xz/xz-5.4.4.tar.gz" "xz" \
    && download_and_extract "https://www.rarlab.com/rar/unrarsrc-6.2.11.tar.gz" "unrar" \
    && download_and_extract "https://github.com/google/brotli/archive/refs/tags/v1.1.0.tar.gz" "brotli" \
    && download_and_extract "https://github.com/facebook/zstd/releases/download/v1.5.5/zstd-1.5.5.tar.gz" "zstd" \
    && download_and_extract "https://github.com/libexpat/libexpat/releases/download/R_2_5_0/expat-2.5.0.tar.bz2" "expat" \
    && download_and_extract "https://www.sqlite.org/2023/sqlite-autoconf-3430000.tar.gz" "sqlite" \
    && download_and_extract "https://github.com/libffi/libffi/releases/download/v3.4.4/libffi-3.4.4.tar.gz" "libffi" \
    && download_and_extract "https://downloads.sourceforge.net/hunspell/hyphen-2.8.8.tar.gz" "hyphen" \
    && download_and_extract "https://www.openssl.org/source/openssl-3.1.3.tar.gz" "openssl" \
    && download_and_extract "https://ftp.gnu.org/gnu/ncurses/ncurses-6.4.tar.gz" "ncurses" \
    && download_and_extract "https://ftp.gnu.org/gnu/readline/readline-8.2.tar.gz" "readline" \
    && download_and_extract "https://www.python.org/ftp/python/3.11.5/Python-3.11.5.tar.xz" "python" \
    && download_and_extract "https://github.com/unicode-org/icu/releases/download/release-73-2/icu4c-73_2-src.tgz" "icu" \
    && download_and_extract "https://snowballstem.org/dist/libstemmer_c-2.2.0.tar.gz" "libstemmer" \
    && download_and_extract "https://downloads.sourceforge.net/project/libjpeg-turbo/3.0.0/libjpeg-turbo-3.0.0.tar.gz" "libjpeg" \
    && download_and_extract "https://downloads.sourceforge.net/sourceforge/libpng/libpng-1.6.40.tar.xz" "libpng" \
    && download_and_extract "https://www.cl.cam.ac.uk/~mgk25/jbigkit/download/jbigkit-2.1.tar.gz" "libjbig" \
    && download_and_extract "http://download.osgeo.org/libtiff/tiff-4.6.0.tar.xz" "libtiff" \
    && download_and_extract "http://downloads.webmproject.org/releases/webp/libwebp-1.3.2.tar.gz" "libwebp" \
    && download_and_extract "https://github.com/glencoesoftware/jxrlib/archive/v0.2.4.tar.gz" "jxrlib" \
    && download_and_extract "https://github.com/silnrsi/graphite/releases/download/1.3.14/graphite2-1.3.14.tgz" "graphite" \
    && download_and_extract "https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.17.tar.gz" "iconv" \
    && download_and_extract "https://download.gnome.org/sources/libxml2/2.12/libxml2-2.12.1.tar.xz" "libxml2" \
    && download_and_extract "https://download.gnome.org/sources/libxslt/1.1/libxslt-1.1.39.tar.xz" "libxslt" \
    && download_and_extract "http://www.jedrea.com/chmlib/chmlib-0.40.tar.bz2" "chmlib" \
    && download_and_extract "https://downloads.sourceforge.net/sourceforge/optipng/optipng-0.7.7.tar.gz" "optipng" \
    && download_and_extract "https://github.com/mozilla/mozjpeg/archive/v4.1.4.tar.gz" "mozjpeg" \
    && download_and_extract "https://github.com/libusb/libusb/releases/download/v1.0.26/libusb-1.0.26.tar.bz2" "libusb" \
    && download_and_extract "https://downloads.sourceforge.net/libmtp/libmtp-1.1.21.tar.gz" "libmtp" \
    && download_and_extract "https://github.com/uclouvain/openjpeg/archive/v2.5.0/openjpeg-2.5.0.tar.gz" "openjpeg" \
    && download_and_extract "https://poppler.freedesktop.org/poppler-23.08.0.tar.xz" "poppler" \
    && download_and_extract "https://github.com/podofo/podofo/archive/f7797f620f151475d05c87c1fab3db20b2f00c0e.tar.gz" "podofo" \
    && download_and_extract "https://gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-1.47.tar.bz2" "libgpg-error" \
    && download_and_extract "https://gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-1.10.2.tar.bz2" "libgcrypt" \
    && download_and_extract "https://ftp.gnome.org/pub/GNOME/sources/glib/2.78/glib-2.78.0.tar.xz" "glib" \
    && download_and_extract "https://dbus.freedesktop.org/releases/dbus/dbus-1.15.8.tar.xz" "dbus" \
    && download_and_extract "https://dbus.freedesktop.org/releases/dbus-glib/dbus-glib-0.112.tar.gz" "dbusglib" \
    && download_and_extract "https://github.com/hunspell/hunspell/releases/download/v1.7.2/hunspell-1.7.2.tar.gz" "hunspell" \
    && download_and_extract "https://github.com/nodejs/node/archive/refs/tags/v20.7.0.tar.gz" "nodejs" \
    && download_and_extract "https://www.freedesktop.org/software/uchardet/releases/uchardet-0.0.8.tar.xz" "uchardet" \
    && download_and_extract "https://github.com/rogerbinns/apsw/releases/download/3.43.0.0/apsw-3.43.0.0.zip" "apsw" \
    && download_and_extract "https://github.com/brailcom/speechd/releases/download/0.11.5/speech-dispatcher-0.11.5.tar.gz" "speech-dispatcher"

# Install dependencies from pacman
RUN pacman -S --noconfirm qt6-base qt6-svg qt6-shadertools qt6-declarative qt6-imageformats qt6-webchannel qt6-location qt6-wayland qt6-sensors qt6-webengine

RUN pacman -S --noconfirm python-pip 

# Create a virtual environment
RUN python -m venv --system-site-packages /venv

RUN pacman -S --noconfirm python-pip libunrar unrar chmlib

# Install dependencies from PyPI
RUN source /venv/bin/activate && \
    pip install \
    installer==0.7.0 \
    packaging==23.1 \
    pyproject_hooks==1.0.0 \
    wheel==0.41.2 \
    setuptools==68.2.2 \
    setuptools_scm==8.0.3 \
    six==1.16.0 \
    unrardll==0.1.7 \
    lxml==4.9.3 \
    pychm==0.8.6 \
    html5-parser==0.4.12 \
    css_parser==1.0.10 \
    python_dateutil==2.8.2 \
    jeepney==0.8.0 \
    dnspython==2.4.2 \
    mechanize==0.4.8 \
    feedparser==6.0.10 \
    sgmllib3k==1


WORKDIR /calibre-build

# Clone the Calibre and bypy repositories
# Ensure the calibre repository is updated or cloned
RUN if [ -d "calibre/.git" ]; then \
        cd calibre && git pull; \
    else \
        git clone --depth 1 https://github.com/mingchen1107/calibre.git; \
    fi

# Ensure the bypy repository is updated or cloned
RUN if [ -d "bypy/.git" ]; then \
        cd bypy && git pull; \
    else \
        git clone --depth 1 https://github.com/kovidgoyal/bypy.git bypy; \
    fi



# Install dependencies for hunspell, uchardet, and potentially PoDoFo
RUN pacman -Syu --noconfirm \
    && pacman -S --noconfirm hunspell uchardet podofo-tools

RUN pacman -Syu --noconfirm \
    && pacman -S --noconfirm zlib bzip2 xz unrar brotli zstd

RUN pacman -Syu --noconfirm \
    && pacman -S --noconfirm expat sqlite libffi openssl ncurses readline

RUN pacman -Syu --noconfirm \
    && pacman -S --noconfirm icu libjpeg libpng libtiff libwebp graphite

RUN pacman -Syu --noconfirm \
    && pacman -S --noconfirm libxml2 libxslt optipng libusb libmtp

RUN pacman -S --needed git base-devel 

# Create a non-root user for building packages (required by makepkg)
# RUN useradd -m builduser && \
#     passwd -d builduser && \
#    echo "builduser ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/builduser

# Switch to the non-root user
# USER builduser
# WORKDIR /home/builduser

# Clone, build, and install 'yay'
# RUN git clone https://aur.archlinux.org/yay.git --depth 1 && \
#     cd yay && \
#     makepkg -si --noconfirm

# RUN yay -S mozjpeg

# USER root 
RUN pacman -Syu --noconfirm \
    && pacman -S --noconfirm openjpeg2 poppler libgpg-error libgcrypt glib2 dbus 

RUN pacman -Syu --noconfirm \
    && pacman -S --noconfirm nodejs uchardet speech-dispatcher hyphen

RUN pacman -Syu --noconfirm \
    && pacman -S --noconfirm jxrlib libiconv dbus-glib libstemmer python-apsw

WORKDIR calibre
# Execute the bootstrap process


RUN pacman -S --noconfirm python-pyqt6

RUN pacman -S --noconfirm python-pyqt5 \
    python-pyqt5-sip \
    sip

RUN pacman -S --noconfirm pyqt-builder


# Set QT_QMAKE_EXECUTABLE environment variable
ENV QT_QMAKE_EXECUTABLE /usr/lib/qt5/bin/qmake



