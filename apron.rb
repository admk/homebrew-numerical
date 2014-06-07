require "formula"

class Apron < Formula
  homepage "http://apron.cri.ensmp.fr/library/"
  url "svn://scm.gforge.inria.fr/svnroot/apron/apron-dist/trunk"
  version "0.9.10"

  depends_on "gmp"
  depends_on "mpfr"

  def patches
    DATA
  end

  def install
    args = %W[
      APRON_PREFIX=#{prefix}
      PPL_PREFIX=#{prefix}
    ]
    system "make", *args
    system "make", "install", *args
  end

  test do
    system "octtestD"
  end
end


__END__
diff --git a/Makefile.config b/Makefile.config
new file mode 100644
index 0000000..eb603f6
--- /dev/null
+++ b/Makefile.config
@@ -0,0 +1,66 @@
+HAS_SHARED=1
+HAS_OCAML=
+HAS_OCAMLOPT=
+MLGMPIDL_PREFIX=/tmp
+GMP_PREFIX=/usr
+MPFR_PREFIX=/usr
+CAML_PREFIX=$(dir $(shell which ocamlc))/..
+CAMLIDL_PREFIX=$(dir $(shell which camlidl))/..
+
+CFLAGS=\
+-Wcast-qual -Wswitch -Werror-implicit-function-declaration \
+-Wall -Wextra -Wundef -Wbad-function-cast -Wcast-align -Wstrict-prototypes \
+-Wno-unused \
+-std=c99 -U__STRICT_ANSI__ \
+-fPIC -O3 -DNDEBUG
+CFLAGS_DEBUG=\
+-Wcast-qual -Wswitch -Werror-implicit-function-declaration \
+-Wall -Wextra -Wundef -Wbad-function-cast -Wcast-align -Wstrict-prototypes \
+-Wno-unused \
+-std=c99  -U__STRICT_ANSI__ \
+-fPIC -g -O0 -UNDEBUG
+CFLAGS_PROF=\
+-Wcast-qual -Wswitch -Werror-implicit-function-declaration \
+-Wall -Wextra -Wundef -Wbad-function-cast -Wcast-align -Wstrict-prototypes \
+-Wno-unused \
+-std=c99 \
+-fPIC -O3 -DNDEBUG -g -pg
+CXXFLAGS=\
+-Wcast-qual -Wswitch \
+-Wall -Wextra -Wundef -Wcast-align \
+-Wno-unused \
+-fPIC -O3 -DNDEBUG
+CXXFLAGS_DEBUG=\
+-Wcast-qual -Wswitch \
+-Wall -Wextra -Wundef -Wcast-align \
+-Wno-unused \
+-fPIC -g -O0 -UNDEBUG
+
+AR=ar
+RANLIB=ranlib
+SED=/usr/local/bin/gsed
+M4=m4
+INSTALL=install
+INSTALLd=install -d
+
+OCAMLFIND=
+OCAMLC=$(CAML_PREFIX)/bin/ocamlc.opt
+OCAMLOPT=$(CAML_PREFIX)/bin/ocamlopt.opt
+
+OCAMLFLAGS=-g
+OCAMLOPTFLAGS=-inline 20
+
+OCAMLDEP=$(CAML_PREFIX)/bin/ocamldep
+OCAMLLEX=$(CAML_PREFIX)/bin/ocamllex.opt
+OCAMLYACC=$(CAML_PREFIX)/bin/ocamlyacc
+OCAMLDOC=$(CAML_PREFIX)/bin/ocamldoc.opt
+OCAMLMKTOP=$(CAML_PREFIX)/bin/ocamlmktop
+OCAMLMKLIB=$(CAML_PREFIX)/bin/ocamlmklib
+
+CAMLIDL=$(CAMLIDL_PREFIX)/bin/camlidl
+
+LATEX=latex
+DVIPDF=dvipdf
+MAKEINDEX=makeindex
+TEXI2DVI=texi2dvi
+TEXI2HTML=texi2html
diff --git a/apron/apron/Makefile b/apron/apron/Makefile
index 102bda5..8ba22d4 100644
--- a/apron/apron/Makefile
+++ b/apron/apron/Makefile
@@ -227,7 +227,7 @@ depend: $(C_FILES) $(H_FILES)
 ap_scalar.o: ap_scalar.c ap_scalar.h ap_config.h
 ap_interval.o: ap_interval.c ap_interval.h \
   ap_config.h \
-  ap_scalar.h $(MPFR_PREFIX)/include/mpfr.h
+  ap_scalar.h
 ap_coeff.o: ap_coeff.c ap_coeff.h \
   ap_config.h \
   ap_scalar.h \
@@ -335,7 +335,7 @@ ap_policy.o: ap_policy.c ap_policy.h ap_manager.h ap_coeff.h ap_config.h \
 ap_scalar_debug.o: ap_scalar.c ap_scalar.h ap_config.h
 ap_interval_debug.o: ap_interval.c ap_interval.h \
   ap_config.h \
-  ap_scalar.h $(MPFR_PREFIX)/include/mpfr.h
+  ap_scalar.h
 ap_coeff_debug.o: ap_coeff.c ap_coeff.h \
   ap_config.h \
   ap_scalar.h \
diff --git a/apron/taylor1plus/Makefile b/apron/taylor1plus/Makefile
index 1829f6c..cb72de7 100644
--- a/apron/taylor1plus/Makefile
+++ b/apron/taylor1plus/Makefile
@@ -76,7 +76,7 @@ ifneq ($(HAS_SHARED),)
 CAML_TO_INSTALL += dllt1pMPQ_caml.so dllt1pD_caml.so dllt1pMPFR_caml.so dllt1pMPQ_caml_debug.so dllt1pD_caml_debug.so dllt1pMPFR_caml_debug.so
 endif
 
-LIBS = -L$(APRON_PREFIX) -lapron -L$(GMP_PREFIX)/lib -lgmpxx -lgmp -L$(MPFR_PREFIX)/lib -lmpfr -lstdc++ -lm
+LIBS = -L$(APRON_PREFIX) -lapron -L../box -lboxD -lboxMPFR -lboxMPQ -L../newpolka -lpolkaRll -lpolkaMPQ -L$(GMP_PREFIX)/lib -lgmpxx -lgmp -L$(MPFR_PREFIX)/lib -lmpfr -lstdc++ -lm
 LIBS_DEBUG = -L$(APRON_PREFIX) -lapron_debug -L$(GMP_PREFIX)/lib -lgmpxx -lgmp -L$(MPFR_PREFIX)/lib -lmpfr -lstdc++ -lm
 
 #---------------------------------------
