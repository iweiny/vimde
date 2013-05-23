#!/bin/bash

export CSCOPE_VERSION="15.5"
export PYCSCOPE_VERSION="0.3"

# make sure we know where we are running from
cd `dirname $0`

BASE_DIR=$1

if [ "${BASE_DIR}" == "" ]; then
    BASE_DIR=${HOME}
fi

INSTALL_DIR=${BASE_DIR}/bin
VIMDE_HOME=${BASE_DIR}/.vimde
CC=gcc; export CC

echo "Intalling VIM Development"
echo "   Environment Base Dir : ${BASE_DIR}"
echo "   Install Dir          : ${INSTALL_DIR}"
echo "   VimDe Home           : ${VIMDE_HOME}"

if [ ! -d "${INSTALL_DIR}" ]; then
   mkdir -m 755 ${INSTALL_DIR}
fi

if [ ! -d "${VIMDE_HOME}" ]; then
   mkdir -m 755 ${VIMDE_HOME}
fi

make realpath

if [ `uname` = "SunOS" ] || [ `uname` = "Darwin" ]; then
   MODE='-m '
else
   MODE='--mode='
fi

which cscope
if [ "$?" != "0" ]; then
   pushd 3rdParty
   #tar xzf cscope-$CSCOPE_VERSION.tar.gz
   pushd cscope-$CSCOPE_VERSION
   #./configure
   #make
   install ${MODE}755 ./src/cscope ${INSTALL_DIR}
   popd
   popd
fi

which pycscope.py
if [ "$?" != "0" ]; then
   pushd 3rdParty
   tar xzf pycscope-$PYCSCOPE_VERSION.tar.gz
   pushd pycscope-$PYCSCOPE_VERSION
   install ${MODE}755 ./pycscope.py ${INSTALL_DIR}
   popd
   popd
fi

install ${MODE}755 vimde ${INSTALL_DIR}
install ${MODE}755 realpath ${VIMDE_HOME}
install ${MODE}755 mktags.sh ${VIMDE_HOME}
install ${MODE}755 conv_spaces.pl ${VIMDE_HOME}
install ${MODE}644 s.gvimrc.raw ${VIMDE_HOME}
install ${MODE}644 user.gvimrc.raw ${VIMDE_HOME}
install ${MODE}644 user.conf.raw ${VIMDE_HOME}
install ${MODE}644 vimde.menus ${VIMDE_HOME}
install ${MODE}644 vimde.cmds ${VIMDE_HOME}
install ${MODE}644 vimde.c.cmds ${VIMDE_HOME}
install ${MODE}644 vimde.java.cmds ${VIMDE_HOME}

ln -s ${INSTALL_DIR}/vimde ${INSTALL_DIR}/vd

if [ ! -f ${VIMDE_HOME}/vimde.conf ]; then
   install ${MODE}644 vimde.conf ${VIMDE_HOME}
fi

