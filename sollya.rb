require 'formula'

class Sollya < Formula
  homepage 'http://sollya.gforge.inria.fr/'
  url 'https://gforge.inria.fr/frs/download.php/28571/sollya-3.0.tar.gz'
  sha1 '29580541d3b5a3a2f64092d495885e2978092467'

  depends_on 'gmp'
  depends_on 'mpfr'
  depends_on 'mpfi'
  depends_on 'fplll'
  depends_on 'libxml2' unless MacOS.version >= :lion
  depends_on 'gnuplot'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/'sample.sollya').write <<-EOS.undent
    1+x==1+x;
    EOS
    system "#{bin}/sollya", "sample.sollya"
  end
end
