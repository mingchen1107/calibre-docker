import subprocess

dependencies = [
    'zlib', 'bzip2', 'xz', 'unrar', 'brotli', 'zstd', 'expat', 'sqlite', 'libffi',
    'hyphen', 'openssl', 'ncurses', 'readline', 'python', 'icu', 'libstemmer', 'libjpeg',
    'libpng', 'libjbig', 'libtiff', 'libwebp', 'jxrlib', 'graphite', 'iconv', 'libxml2',
    'libxslt', 'chmlib', 'optipng', 'mozjpeg', 'libusb', 'libmtp', 'openjpeg', 'poppler',
    'podofo', 'libgpg-error', 'libgcrypt', 'glib', 'dbus', 'dbusglib', 'hunspell', 'nodejs',
    'qt-base', 'qt-svg', 'qt-shadertools', 'qt-declarative', 'qt-imageformats', 'qt-webchannel',
    'qt-positioning', 'qt-wayland', 'qt-sensors', 'qt-webengine', 'installer', 'packaging',
    'pyproject_hooks', 'wheel', 'build', 'setuptools', 'setuptools_scm', 'six', 'unrardll',
    'lxml', 'pychm', 'html5-parser', 'css-parser', 'dateutil', 'jeepney', 'dnspython', 'mechanize',
    'feedparser', 'sgmllib3k', 'markdown', 'html2text', 'soupsieve', 'beautifulsoup4', 'regex',
    'chardet', 'uchardet', 'msgpack', 'pygments', 'pycryptodome', 'apsw', 'webencodings', 'html5lib',
    'pillow', 'netifaces', 'psutil', 'ifaddr', 'texttable', 'multivolumefile', 'python-brotli', 'pyzstd',
    'pyppmd', 'pybcj', 'inflate64', 'py7zr', 'poetry_core', 'zeroconf', 'fonttools', 'ply', 'sip',
    'pyqt-builder', 'pyqt-sip', 'pyqt', 'pyqt-webengine', 'speech-dispatcher-client', 'xxhash'
]
def install_apt_packages():
    subprocess.run(['apt-get', 'update'])
    subprocess.run(['apt-get', 'install', '-y', 'apt-file'])
    subprocess.run(['apt-file', 'update'])

def find_package(dependency):
    result = subprocess.run(['apt-file', 'search', dependency], capture_output=True, text=True)
    output_lines = result.stdout.split('\n')
    for line in output_lines:
        if line.startswith(dependency + ': '):
            return line.split(': ')[0]
    return None

def main():
    install_apt_packages()
    with open("dependency_packages.txt", "w") as file:
        for dependency in dependencies:
            package = find_package(dependency)
            if package:
                file.write(f"{dependency}: {package}\n")
            else:
                file.write(f"Package for {dependency} not found.\n")

if __name__ == "__main__":
    main()
