#!/bin/bash
#
# simple script to build vimde tools databases
#

vimde_home=${HOME}/.vimde

function usage
{
   echo "Usage mktags.sh [-hak] <dir>"
   echo "   -h this message"
   echo "   -a (re)make all tags"
   echo "   -k use kernel mode"
   exit 1
}

if [ "$1" = "" ]; then
   usage
fi

make_all="no"
kernel_mode="no"
while getopts "akh" option; do
   case option in
      a) make_all="yes" ;;
      k) kernel_mode="yes" ;;
      h) usage ;;
      \?) usage ;;
   esac
done

shift $(($OPTIND-1))
req_dir=$1

dir=`$vimde_home/realpath $req_dir`
echo "Checking files in $dir"
cd $dir

if [ -f ./vimde/user.conf ]; then
   . ./vimde/user.conf
else
   echo "Failed to find \"user.conf\" using defaults"
fi

# build a list of exclude directories.
# this does not work...
#excludes=" -path '$dir/c++/3rdParty/ACE_wrappers-5.2.1' -prune -o "
#excludes=$excludes" -path '$dir/c++/3rdParty/soapcpp-linux-2.0.1' -prune -o "
#echo "$excludes"

if [ "$make_all" == "yes" ] || [ ! -f ./vimde/cscope.files ]; then
   echo "Regenerating all files"

   # remove old database
   rm -f ./vimde/cscope.out
   rm -f ./vimde/pycscope.out

   # regenerate the list of files
   find $dir -iname "*.h"    -print >  ./vimde/cscope.files
   find $dir -iname "*.hpp"  -print >> ./vimde/cscope.files
   find $dir -name  "*.c"    -print >> ./vimde/cscope.files
   find $dir -iname "*.cc"   -print >> ./vimde/cscope.files
   find $dir -name  "*.cxx"  -print >> ./vimde/cscope.files
   find $dir -iname "*.cpp"  -print >> ./vimde/cscope.files
   find $dir -iname "*.java" -print >> ./vimde/cscope.files

   # Add Python files.
   find $dir -iname "*.py" -print > ./vimde/pycscope.files
fi

for exclude_path in $EXCLUDE_DIRS; do
   echo "excluding : $exclude_path"
   cat ./vimde/cscope.files | sed -e "s/.*$exclude_path.*//g" > tmp.foo
   mv tmp.foo ./vimde/cscope.files
   cat ./vimde/pycscope.files | sed -e "s/.*$exclude_path.*//g" > tmp.foo
   mv tmp.foo ./vimde/pycscope.files
done

if [ "$kernel_mode" = "yes" ]; then
   cscope -k -b -i ./vimde/cscope.files -f ./vimde/cscope.out
else
   cscope -b -i ./vimde/cscope.files -f ./vimde/cscope.out
   pycscope.py -i ./vimde/pycscope.files -f ./vimde/pycscope.out
fi

# I found that this was to slow to do on a regular basis
if [ "$make_all" == "yes" ]; then
   # remove old database
   rm -f ./vimde/tags
   ctags --c++-types=cegnv -f ./vimde/tags -L ./vimde/cscope.files
fi

cat ./vimde/cscope.files > ./vimde/all.files
cat ./vimde/pycscope.files >> ./vimde/all.files

exit 0

