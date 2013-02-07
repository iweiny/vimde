vimde
=====

Vim Development Environment

This is a series of scripts I have developed over the years to be able to quickly and effectivly browse source code which is not mine.

It operates on the IDE idea of a "project" by creating a "vimde" directory and recursively scanning a directory for C, C++, Java, and now Python source files.  It builds cscope files using cscope and pyscope which are auto loaded when editing any file within that source tree.  In addition various control commands are added to vim on start up.

