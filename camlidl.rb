require "formula"

class Camlidl < Formula
  homepage "http://caml.inria.fr/pub/old_caml_site/camlidl/"
  url "http://caml.inria.fr/pub/old_caml_site/distrib/bazar-ocaml/camlidl-1.05.tar.gz"
  sha1 "2a0d5ba70fea8c1de1c5387f8b2058357b2177df"

  depends_on "objective-caml"

  def patches
    DATA
  end

  def install
    system "mv", "config/Makefile.unix", "config/Makefile"

    system "make", "all"
    system "make", "install", "OCAMLLIB=..", "BINDIR=.."

    bin.install "camlidl"
    (lib+"ocaml").install "libcamlidl.a"
    (lib+"ocaml/caml").install "caml/camlidlruntime.h"
    ["com.a", "com.cma", "com.cmi", "com.cmxa"].each { |x|
        (lib+"ocaml").install x
    }
  end

  test do
    system "camlidl"
  end
end


__END__
diff --git a/config/Makefile.unix b/config/Makefile.unix
index cf4549c..6ef6dcc 100644
--- a/config/Makefile.unix
+++ b/config/Makefile.unix
@@ -31,10 +31,8 @@ RANLIB=ranlib
 #RANLIB=:
 
 # Location of the Objective Caml library in your installation
-OCAMLLIB=/usr/local/lib/ocaml
 
 # Where to install the binaries
-BINDIR=/usr/local/bin
 
 # The Objective Caml compilers (the defaults below should be OK)
 OCAMLC=ocamlc -g
diff --git a/runtime/Makefile.unix b/runtime/Makefile.unix
index 5617349..a9a99fc 100644
--- a/runtime/Makefile.unix
+++ b/runtime/Makefile.unix
@@ -22,6 +22,7 @@ libcamlidl.a: $(OBJS)
 	$(RANLIB) $@
 
 install:
+	mkdir -p $(OCAMLLIB)/caml
 	cp camlidlruntime.h $(OCAMLLIB)/caml/camlidlruntime.h
 	cp libcamlidl.a $(OCAMLLIB)/libcamlidl.a
 	cd $(OCAMLLIB); $(RANLIB) libcamlidl.a
