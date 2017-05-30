# Prerequisites

1. Install [Graphviz](https://graphviz.org).
2. Install Python 2.7 and the following modules:
    - `pyparsing`
    - [`win32`](https://sourceforge.net/projects/pywin32/)
3. Install the _development_ version of [`dot2tex`](http://dot2tex.readthedocs.io/) with a custom patch.

        git clone https://github.com/kjellmf/dot2tex.git

   Apply the following change:

    ``` diff
    diff --git a/dot2tex/dot2tex.py b/dot2tex/dot2tex.py
    index c7bd25e..d68a48d 100644
    --- a/dot2tex/dot2tex.py
    +++ b/dot2tex/dot2tex.py
    @@ -38,6 +38,7 @@ import os.path as path
     import sys, tempfile, os, re
     import logging
     import warnings
    +import subprocess

     import dotparsing

    @@ -2649,9 +2650,8 @@ class TeXDimProc:
             else:
                 command = 'latex -interaction=nonstopmode %s' % self.tempfilename
             log.debug('Running command: %s' % command)
    -        sres = os.popen(command)
    -
    -        errcode = sres.close()
    +        errcode = subprocess.call(command, cwd=os.path.split(logfilename)[0])
    +
             log.debug('errcode: %s' % errcode)
             f = open(logfilename, 'r')
             logdata = f.read()
    ```

   Then install it:

        python setup.py install


