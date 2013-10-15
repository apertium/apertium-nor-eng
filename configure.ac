#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ(2.52)

m4_define([required_apertium_version], [3.2.0])
m4_define([required_lttolbox_version], [3.1.2])

AC_INIT([apertium-no-en], [0.1.0], [ftyers@prompsit.com])
AM_INIT_AUTOMAKE([apertium-no-en], [0.1.0], no-define)
AC_PROG_LN_S
AC_PROG_AWK

PKG_CHECK_MODULES([APERTIUM_NOB],[apertium-nob])
AC_ARG_VAR(NOBSRC, "Source directory for apertium-nob")
AS_IF([test -z "$NOBSRC"], [NOBSRC=`pkg-config --variable=srcdir apertium-nob`])

PKG_CHECK_MODULES([APERTIUM_NNO],[apertium-nno])
AC_ARG_VAR(NNOSRC, "Source directory for apertium-nno")
AS_IF([test -z "$NNOSRC"], [NNOSRC=`pkg-config --variable=srcdir apertium-nno`])

AC_DEFUN([PKG_CHECK_APERTIUM], [
  APERTIUM_VER=0
  PKG_CHECK_MODULES(APERTIUM, apertium-3.0 >= 3.0.0,
  [
    APERTIUM_VER=30
  ],
  [
    PKG_CHECK_MODULES(APERTIUM, apertium-3.1 >= 3.1.0,
    [
      APERTIUM_VER=31
    ],
    [
      PKG_CHECK_MODULES(APERTIUM, apertium-3.2 >= 3.2.0,
      [
        APERTIUM_VER=31
      ],
      [
        PKG_CHECK_MODULES(APERTIUM, apertium-3.3 >= 3.3.0)
        APERTIUM_VER=33
      ])
    ])
  ])
  AC_SUBST(APERTIUM_VER)
])

AC_DEFUN([PKG_CHECK_LTTOOLBOX], [
  LTTOOLBOX_VER=0
  PKG_CHECK_MODULES(LTTOOLBOX, lttoolbox-3.0 >= 3.0.0,
  [
    LTTOOLBOX_VER=30
  ],
  [
    PKG_CHECK_MODULES(LTTOOLBOX, lttoolbox-3.1 >= 3.1.0,
    [
      LTTOOLBOX_VER=31
    ],
    [
      PKG_CHECK_MODULES(LTTOOLBOX, lttoolbox-3.2 >= 3.2.0,
      [
        LTTOOLBOX_VER=31
      ],
      [
        PKG_CHECK_MODULES(LTTOOLBOX, lttoolbox-3.3 >= 3.3.0)
        LTTOOLBOX_VER=33
      ])
    ])
  ])
  AC_SUBST(LTTOOLBOX_VER)
])

PKG_CHECK_APERTIUM
PKG_CHECK_LTTOOLBOX


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


AC_OUTPUT([Makefile])
