class Libxmlsec1AT12 < Formula
    desc "XML security library - 1.2 branch"
    homepage "https://www.aleksey.com/xmlsec/"
    url "https://github.com/platformed-com/tap/releases/download/v1.2.41/xmlsec1-1.2.41.tar.gz"
    conflicts_with "libxmlsec1", because: "both stable and legacy libxmlsec provide the same library name"
    sha256 "e872f7999b9a90d410d91a9cd7b4471063a0fb67f86423012b764afe2d2c1884"
    license "MIT"
  
    livecheck do
      url "https://www.aleksey.com/xmlsec/download/"
      regex(/href=.*?xmlsec1[._-]v?(\d+(?:\.\d+)+)\.t/i)
    end
  
    depends_on "pkgconf" => :build
    depends_on "gnutls" # Yes, it wants both ssl/tls variations
    depends_on "libgcrypt"
    depends_on "openssl@3"
    uses_from_macos "libxslt"
  
    def install
      args = [
        "--disable-crypto-dl",
        "--disable-apps-crypto-dl",
        "--with-nss=no",
        "--with-nspr=no",
        "--enable-mscrypto=no",
        "--enable-mscng=no",
        "--with-openssl=#{Formula["openssl@3"].opt_prefix}",
        "--with-libxml=/usr",
      ]
  
      system "./configure", *args, *std_configure_args
      system "make", "install"
    end
  
    test do
      system bin/"xmlsec1", "--version"
      system bin/"xmlsec1-config", "--version"
    end
  end
