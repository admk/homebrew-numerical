require 'formula'

class Flopoco < Formula
  homepage 'http://flopoco.gforge.inria.fr/'
  url 'https://gforge.inria.fr/frs/download.php/31858/flopoco-2.4.0.tgz'
  sha1 '1f527957bd63b81019b734ad096517164b46691b'

  depends_on 'cmake' => :build
  depends_on 'boost'
  depends_on 'gsl'
  depends_on 'bison' => :build
  depends_on 'flex' => :build
  depends_on 'gmp'
  depends_on 'mpfr'
  depends_on 'mpfi'
  depends_on 'libxml2' unless MacOS.version >= :lion
  depends_on 'fplll'
  depends_on 'sollya' => :recommended

  def install
    system "cmake", ".", *std_cmake_args
    system "make"
    ["flopoco", "bin2fp", "longacc2fp", "fp2bin"].each { |x| bin.install x }
  end

  test do
    system "#{bin}/flopoco", "IntConstMult", "16", "12345"
  end

  fails_with :clang do
    build 425
    cause <<-EOS.undent
      Compiler fails with the following error:
      Object expression of non-scalar type '__mpfr_struct [1]' cannot be used
      in a pseudo-destructor.
    EOS
  end
end
