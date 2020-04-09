#!/usr/bin/env sh

# This script is used for creating CTAN archive of zhlipsum.

module=zhlipsum
maindir=$PWD
builddir=$maindir/build
distribdir=$builddir/distrib
docdir=$builddir/doc
tdsdir=$distribdir/tds
unpackdir=$builddir/unpacked
ctandir=$distribdir/ctan/$module
tds_docdir=$tdsdir/doc/latex/$module
tds_srcdir=$tdsdir/src/latex/$module
tds_texdir=$tdsdir/tex/latex/$module

rm -rf $distribdir
if [ "$1" == "--build-doc" ]; then
    l3build doc
fi

mkdir -p $ctandir $tds_docdir $tds_srcdir $tds_texdir

cp $docdir/*.pdf    $ctandir
cp $unpackdir/*.md  $ctandir
cp $unpackdir/*.dtx $ctandir

cp $docdir/*.pdf    $tds_docdir
cp $docdir/*.tex    $tds_docdir
cp $unpackdir/*.md  $tds_docdir
cp $unpackdir/*.dtx $tds_srcdir
cp $unpackdir/*.ins $tds_srcdir
cp $unpackdir/*.sty $tds_texdir
cp $unpackdir/*.def $tds_texdir

cd $tdsdir
zip -q -r -9 $module.tds.zip .

cd $ctandir/..
cp $tdsdir/$module.tds.zip .
zip -q -r -9 $module.zip .

cp -f *.zip $maindir
