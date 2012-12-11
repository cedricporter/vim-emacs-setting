/* config.h.  Generated from config.h.in by configure.  */
/* config.h.in.  Generated from configure.in by autoheader.  */

/* We're using a BSD-flavoured Unix */
/* #undef BSD */

/* Found some version of curses that we're going to use */
#define HAS_CURSES 1

/* Define to 1 if you have the `asprintf' function. */
#define HAVE_ASPRINTF 1

/* Define to 1 if you have the <dirent.h> header file, and it defines `DIR'.
   */
#define HAVE_DIRENT_H 1

/* Define to 1 if you have the <fcntl.h> header file. */
#define HAVE_FCNTL_H 1

/* Define to 1 if you have the `fixkeypad' function. */
/* #undef HAVE_FIXKEYPAD */

/* Define to 1 if you have the <floss.h> header file. */
/* #undef HAVE_FLOSS_H */

/* Define to 1 if you have the `getcwd' function. */
#define HAVE_GETCWD 1

/* Define to 1 if you have the `getopt_long' function. */
#define HAVE_GETOPT_LONG 1

/* Define to 1 if the system has the type `intmax_t'. */
/* #undef HAVE_INTMAX_T */

/* Define to 1 if you have the <inttypes.h> header file. */
#define HAVE_INTTYPES_H 1

/* Define to 1 if you have the <io.h> header file. */
/* #undef HAVE_IO_H */

/* Define to 1 if you have the `regex' library (-lregex). */
/* #undef HAVE_LIBREGEX */

/* Define to 1 if you have the `localeconv' function. */
/* #undef HAVE_LOCALECONV */

/* Define to 1 if you have the <locale.h> header file. */
/* #undef HAVE_LOCALE_H */

/* Define to 1 if the system has the type `long double'. */
/* #undef HAVE_LONG_DOUBLE */

/* Define to 1 if the system has the type `long long int'. */
/* #undef HAVE_LONG_LONG_INT */

/* Define to 1 if you have the `lstat' function. */
#define HAVE_LSTAT 1

/* Define to 1 if you have the `memcpy' function. */
#define HAVE_MEMCPY 1

/* Define to 1 if you have the <memory.h> header file. */
#define HAVE_MEMORY_H 1

/* Define to 1 if you have the `memset' function. */
#define HAVE_MEMSET 1

/* Define to 1 if you have the <ndir.h> header file, and it defines `DIR'. */
/* #undef HAVE_NDIR_H */

/* Define to 1 if the system has the type `ptrdiff_t'. */
/* #undef HAVE_PTRDIFF_T */

/* Define to 1 if you have the `regcmp' function. */
/* #undef HAVE_REGCMP */

/* Define to 1 if you have the `regcomp' function. */
#define HAVE_REGCOMP 1

/* Define to 1 if you have the `setmode' function. */
/* #undef HAVE_SETMODE */

/* Define to 1 if you have the <signal.h> header file. */
#define HAVE_SIGNAL_H 1

/* Define if we have sigsetjmp(). */
#define HAVE_SIGSETJMP 1

/* Define to 1 if you have a C99 compliant `snprintf' function. */
#define HAVE_SNPRINTF 1

/* Define to 1 if you have the <stdarg.h> header file. */
#define HAVE_STDARG_H 1

/* Define to 1 if you have the <stddef.h> header file. */
/* #undef HAVE_STDDEF_H */

/* Define to 1 if you have the <stdint.h> header file. */
#define HAVE_STDINT_H 1

/* Define to 1 if you have the <stdlib.h> header file. */
#define HAVE_STDLIB_H 1

/* Define to 1 if you have the `strchr' function. */
#define HAVE_STRCHR 1

/* Define to 1 if you have the `strerror' function. */
#define HAVE_STRERROR 1

/* Define to 1 if you have the <strings.h> header file. */
#define HAVE_STRINGS_H 1

/* Define to 1 if you have the <string.h> header file. */
#define HAVE_STRING_H 1

/* Define to 1 if `decimal_point' is a member of `struct lconv'. */
/* #undef HAVE_STRUCT_LCONV_DECIMAL_POINT */

/* Define to 1 if `thousands_sep' is a member of `struct lconv'. */
/* #undef HAVE_STRUCT_LCONV_THOUSANDS_SEP */

/* Define to 1 if you have the <sys/dir.h> header file, and it defines `DIR'.
   */
/* #undef HAVE_SYS_DIR_H */

/* Define to 1 if you have the <sys/ndir.h> header file, and it defines `DIR'.
   */
/* #undef HAVE_SYS_NDIR_H */

/* Define to 1 if you have the <sys/stat.h> header file. */
#define HAVE_SYS_STAT_H 1

/* Define to 1 if you have the <sys/termios.h> header file. */
#define HAVE_SYS_TERMIOS_H 1

/* Define to 1 if you have the <sys/types.h> header file. */
#define HAVE_SYS_TYPES_H 1

/* Define to 1 if you have the <sys/window.h> header file. */
/* #undef HAVE_SYS_WINDOW_H */

/* Define to 1 if the system has the type `uintmax_t'. */
/* #undef HAVE_UINTMAX_T */

/* Define to 1 if the system has the type `uintptr_t'. */
/* #undef HAVE_UINTPTR_T */

/* Define to 1 if you have the <unistd.h> header file. */
#define HAVE_UNISTD_H 1

/* Define to 1 if the system has the type `unsigned long long int'. */
/* #undef HAVE_UNSIGNED_LONG_LONG_INT */

/* Define to 1 if you have the <varargs.h> header file. */
/* #undef HAVE_VARARGS_H */

/* Define to 1 if you have the `vasprintf' function. */
#define HAVE_VASPRINTF 1

/* Define to 1 if you have the `va_copy' function or macro. */
/* #undef HAVE_VA_COPY */

/* Define to 1 if you have a C99 compliant `vsnprintf' function. */
#define HAVE_VSNPRINTF 1

/* Define to 1 if you have the `_setmode' function. */
/* #undef HAVE__SETMODE */

/* Define to 1 if you have the `__va_copy' function or macro. */
/* #undef HAVE___VA_COPY */

/* We're using some variant of Linux */
#define Linux 1

/* Set to reflect version of ncurses: 0 = version 1.* 1 = version 1.9.9g 2 =
   version 4.0/4.1 */
/* #undef NCURSES_970530 */

/* If your Curses does not have color define this one */
/* #undef NO_COLOR_CURSES */

/* Define to 1 if your C compiler doesn't accept -c and -o together. */
/* #undef NO_MINUS_C_MINUS_O */

/* Name of package */
#define PACKAGE "cscope"

/* Define to the address where bug reports for this package should be sent. */
#define PACKAGE_BUGREPORT ""

/* Define to the full name of this package. */
#define PACKAGE_NAME ""

/* Define to the full name and version of this package. */
#define PACKAGE_STRING ""

/* Define to the one symbol short name of this package. */
#define PACKAGE_TARNAME ""

/* Define to the home page for this package. */
#define PACKAGE_URL ""

/* Define to the version of this package. */
#define PACKAGE_VERSION ""

/* Define as the return type of signal handlers (`int' or `void'). */
#define RETSIGTYPE void

/* Define if you want to turn on SCO-specific code */
/* #undef SCO_FLAVOR */

/* Define to 1 if you have the ANSI C header files. */
#define STDC_HEADERS 1

/* Use Ncurses? */
#define USE_NCURSES 1

/* Use SunOS SysV curses? */
/* #undef USE_SUNOS_CURSES */

/* Use SystemV curses? */
/* #undef USE_SYSV_CURSES */

/* Define this if the scanner is run through lex, not flex */
/* #undef USING_LEX */

/* Version number of package */
#define VERSION "15.8a"

/* Define to 1 if `lex' declares `yytext' as a `char *' by default, not a
   `char[]'. */
#define YYTEXT_POINTER 1

/* Define to rpl_asprintf if the replacement function should be used. */
/* #undef asprintf */

/* Define to empty if `const' does not conform to ANSI C. */
/* #undef const */

/* Define to the widest signed integer type if <stdint.h> and <inttypes.h> do
   not define. */
/* #undef intmax_t */

/* Define to `int' if <sys/types.h> does not define. */
/* #undef mode_t */

/* Define to `int' if <sys/types.h> does not define. */
/* #undef pid_t */

/* Define to `unsigned int' if <sys/types.h> does not define. */
/* #undef size_t */

/* Define to rpl_snprintf if the replacement function should be used. */
/* #undef snprintf */

/* Define to the widest unsigned integer type if <stdint.h> and <inttypes.h>
   do not define. */
/* #undef uintmax_t */

/* Define to the type of an unsigned integer type wide enough to hold a
   pointer, if such a type exists, and if the system does not define it. */
/* #undef uintptr_t */

/* Define to rpl_vasprintf if the replacement function should be used. */
/* #undef vasprintf */

/* Define to rpl_vsnprintf if the replacement function should be used. */
/* #undef vsnprintf */
