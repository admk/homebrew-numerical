require 'formula'

class Mlgmp < Formula
  homepage 'http://www-verimag.imag.fr/~monniaux/programmes.html.en'
  url 'http://www-verimag.imag.fr/~monniaux/download/mlgmp.tar.gz'
  sha1 '8d2d9e60b07f383bfe73efa8c67158ec48af54e1'
  version '0.13'

  depends_on 'objective-caml'
  depends_on 'gmp'
  depends_on 'mpfr'

  def patches
      DATA
  end

  def install
      system "make", "clean"
      system "make", "install"
      (lib+'ocaml').install "gmp"
  end

  test do
  end
end

__END__
diff --git a/Makefile b/Makefile
index 587a428..b8b40ab 100644
--- a/Makefile
+++ b/Makefile
@@ -1,11 +1,11 @@
 # Use GNU Make !
 RANLIB= ranlib
 
-OCAML_LIBDIR:= $(shell ocamlc -where)
-GMP_INCLUDES= -I/opt/gmp-4.1.2/include -I/users/absint2/local/include -I$(HOME)/packages/gmp/include
+OCAML_LIBDIR:= /usr/local/lib/ocaml
+GMP_INCLUDES= -I/usr/local/include
 
-GMP_LIBDIR=/opt/gmp-4.1.2/lib
-DESTDIR= $(OCAML_LIBDIR)/gmp
+GMP_LIBDIR=/usr/local/lib
+DESTDIR=gmp
 
 #RLIBFLAGS= -cclib "-Wl,-rpath $(GMP_LIBDIR)" # Linux, FreeBSD
 #RLIBFLAGS= -cclib "-Wl,-R $(GMP_LIBDIR)" # Solaris
@@ -36,7 +36,7 @@ TESTS= test_suite test_suite.opt
 all:	$(LIBS) tests
 
 install: all
-	-mkdir $(DESTDIR)
+	-mkdir -p $(DESTDIR)
 	cp $(LIBS) gmp.mli $(DESTDIR)
 
 tests:	$(LIBS) $(TESTS)
