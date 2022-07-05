#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ(2.52)

m4_define([required_apertium_version], [3.4.0])

AC_INIT([Apertium Norwegian-English], [0.1.1], [ftyers@prompsit.com], [apertium-nor-eng], [https://wiki.apertium.org/wiki/Apertium-nor-eng])
AM_INIT_AUTOMAKE

AC_PROG_LN_S
AC_PROG_AWK

PKG_CHECK_MODULES(APERTIUM, apertium >= required_apertium_version, [], [PKG_CHECK_MODULES(APERTIUM, apertium-3.2 >= required_apertium_version)])

PKG_CHECK_MODULES(CG3, cg3 >= 1.3.6)
PKG_CHECK_MODULES(APERTIUM_LEX_TOOLS, apertium-lex-tools >= 0.4.0)

AC_PATH_PROG([PKGCONFIG], [pkg-config], [false], [$PATH$PATH_SEPARATOR$with_pkg_config/bin])
AS_IF([test x$PKGCONFIG = xfalse], [AC_MSG_ERROR([You don't have pkg-config installed])])


m4_ifdef([AP_CHECK_LING],[],[AC_MSG_ERROR([AP_CHECK_LING not defined, is apertium.m4 in ACLOCAL_PATH? See: https://wiki.apertium.org/wiki/Installation_troubleshooting])])

AP_CHECK_LING([1n], [apertium-nno])
AP_CHECK_LING([1b], [apertium-nob])
AP_CHECK_LING([2], [apertium-eng])

PKG_CHECK_MODULES(REGTEST, apertium-regtest >= 0.0.1, [],
                  [AC_MSG_WARN([Running tests requires apertium-regtest])])

AP_MKINCLUDE

AC_OUTPUT([Makefile])
