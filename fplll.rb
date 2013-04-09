require 'formula'

class Fplll < Formula
  homepage 'http://xpujol.net/fplll/'
  url 'http://xpujol.net/fplll/libfplll-4.0.1.tar.gz'
  sha1 'ce18f0f0113969172b77b790fb370fcd2d304a32'

  depends_on 'gmp'
  depends_on 'mpfr'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "make", "check"
  end
end
