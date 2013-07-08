require 'formula'

class Rangelab < Formula
  homepage 'http://perso.univ-perp.fr/mmartel/rangelab.html'
  url 'http://perso.univ-perp.fr/mmartel/rangelab.tar.gz'
  sha1 'a1d5fecd7d3004ff5d9a3aa7090389c31d605329'
  version '1.0'

  depends_on 'mlgmp'

  def patches
      DATA
  end

  def install
    ENV.j1

    cd 'src' do
        system "env"
        system "make"
        bin.install "rangelab"
    end
  end

  test do
    system "rangelab"
  end
end

__END__
diff --git a/src/Makefile b/src/Makefile
index 24927fe..ec1f302 100755
--- a/src/Makefile
+++ b/src/Makefile
@@ -23,7 +23,7 @@ OCAMLDEP=ocamldep
 OCAMLLEX=ocamllex
 OCAMLYACC=ocamlyacc
 
-INCLUDES=-I ~/mlgmp
+INCLUDES=-I /usr/local/lib/ocaml/gmp
 
 RANGELAB = types.cmx prelude.cmx boolean.cmx integer.cmx float.cmx fixed.cmx\
  	coercion.cmx matrix.cmx print.cmx slice.cmx semiformal.cmx arrays.cmx\
diff --git a/src/matrix.ml b/src/matrix.ml
index 80082da..7d40d24 100755
--- a/src/matrix.ml
+++ b/src/matrix.ml
@@ -72,27 +72,9 @@ let matrixTranspose m =
 	in AVal(n) ;;
 	
 	
-let matrixRandom y x =
-	let m = Array.make_matrix y x ValBottom in
-	let _ = for i=0 to (y-1) do
-				for j=0 to (x-1) do
-					let r = M(FR.random float64_mantissa)
-					in m.(i).(j) <- FVal(FE((r,r),!eZero,float64_mantissa))  
-				done
-			done
-	in AVal(m) ;;
-	
-
-let matrixRandomErrors y x =
-	let m = Array.make_matrix y x ValBottom in
-	let _ = for i=0 to (y-1) do
-				for j=0 to (x-1) do
-					let r = M(FR.random float64_mantissa)
-					in m.(i).(j) <- FVal(FE(!f64Zero,(r,r),float64_mantissa))  
-				done
-			done
-	in AVal(m) ;;
+let matrixRandom y x = matrixZeros y x ;;
 
+let matrixRandomErrors y x = matrixZeros y x ;;
 	
 let matrixLinspace a b n = if (n<2) then b else match (a,b) with
 	(IVal(I32(x),_),IVal(_,I32(y))) ->	let h = ((Int32.to_float (Int32.sub y x))+.1.0) /. (Int32.to_float (Int32.of_int (n-1))) in
