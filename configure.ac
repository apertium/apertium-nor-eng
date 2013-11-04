#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ(2.52)

m4_define([required_apertium_version], [3.2.0])
m4_define([required_lttolbox_version], [3.1.2])

AC_INIT([apertium-no-en], [0.1.0], [ftyers@prompsit.com])
AM_INIT_AUTOMAKE([apertium-no-en], [0.1.0], no-define)
AC_PROG_LN_S
AC_PROG_AWK



PKG_CHECK_MODULES(APERTIUM,   apertium >= required_apertium_version, [], [PKG_CHECK_MODULES(APERTIUM,   apertium-3.2 >= required_apertium_version)])
PKG_CHECK_MODULES(LTTOOLBOX,   lttoolbox >= required_lttoolbox_version, [], [PKG_CHECK_MODULES(LTTOOLBOX,   lttoolbox-3.2 >= required_lttoolbox_version)])


AC_PATH_PROG(CGCOMP, cg-comp, no)
if test x$ac_cv_path_CGCOMP = x
then
  AC_MSG_ERROR([You don't have cg-comp installed.])
fi
if test x$ac_cv_path_CGPROC = xno
then
  AC_MSG_ERROR([You don't have cg-comp installed.])
fi

AC_PATH_PROG(CGPROC, cg-proc, no)
if test x$ac_cv_path_CGPROC = x
then
  AC_MSG_ERROR([You don't have cg-proc installed.])
fi
if test x$ac_cv_path_CGPROC = xno
then
  AC_MSG_ERROR([You don't have cg-proc installed.])
fi


AC_ARG_VAR(NNOSRC, "Source directory for apertium-nno")
AS_IF([test -z "$NNOSRC"],
      [
          PKG_CHECK_MODULES([APERTIUM_NNO], [apertium-nno])
          NNOSRC=`pkg-config --variable=srcdir apertium-nno`
      ],
      [echo "Using apertium-nno from $NNOSRC"])

AC_ARG_VAR(NOBSRC, "Source directory for apertium-nob")
AS_IF([test -z "$NOBSRC"],
      [
          PKG_CHECK_MODULES([APERTIUM_NOB], [apertium-nob])
          NOBSRC=`pkg-config --variable=srcdir apertium-nob`
      ],
      [echo "Using apertium-nob from $NOBSRC"])


AC_OUTPUT([Makefile])
