require "formula"

class Ppl < Formula
  homepage "http://bugseng.com/products/ppl"
  url "ftp://ftp.cs.unipr.it/pub/ppl/releases/1.1/ppl-1.1.tar.bz2"
  sha1 "f76fbc2d374170771fed030b79a5ffac08d907bf"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system "ppl-config"
  end
end
