#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ(2.52)

m4_define([required_apertium_version], [3.4.0])

AC_INIT([apertium-nor-eng], [0.1.1], [ftyers@prompsit.com])
AM_INIT_AUTOMAKE([apertium-nor-eng], [0.1.1], no-define)
AC_PROG_LN_S
AC_PROG_AWK

PKG_CHECK_MODULES(APERTIUM, apertium >= required_apertium_version, [], [PKG_CHECK_MODULES(APERTIUM, apertium-3.2 >= required_apertium_version)])


AC_PATH_PROG([LRXPROC], [lrx-proc], [false], [$PATH$PATH_SEPARATOR$with_lrx_proc/bin])
AS_IF([test x$LRXPROC = xfalse], [AC_MSG_ERROR([You don't have lrx-proc installed])])

AC_PATH_PROG([CGCOMP], [cg-comp], [false], [$PATH$PATH_SEPARATOR$with_cg_comp/bin])
AS_IF([test x$CGCOMP = xfalse], [AC_MSG_ERROR([You don't have cg-comp installed])])

AC_PATH_PROG([CGPROC], [cg-proc], [false], [$PATH$PATH_SEPARATOR$with_cg_proc/bin])
AS_IF([test x$CGPROC = xfalse], [AC_MSG_ERROR([You don't have cg-proc installed])])

AC_PATH_PROG([PKGCONFIG], [pkg-config], [false], [$PATH$PATH_SEPARATOR$with_pkg_config/bin])
AS_IF([test x$PKGCONFIG = xfalse], [AC_MSG_ERROR([You don't have pkg-config installed])])


m4_ifdef([AP_CHECK_LING],[],[AC_MSG_ERROR([AP_CHECK_LING not defined, is apertium.m4 in ACLOCAL_PATH? See: http://wiki.apertium.org/wiki/Installation_troubleshooting])])

AP_CHECK_LING([1n], [apertium-nno])
AP_CHECK_LING([1b], [apertium-nob])
AP_CHECK_LING([2], [apertium-eng])

AP_MKINCLUDE

AC_OUTPUT([Makefile])
