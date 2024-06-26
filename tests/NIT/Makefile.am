# Network UPS Tools: NUT Integration Tests (NIT)

# Export certain values for ccache which NUT ci_build.sh can customize,
# to facilitate developer iteration re-runs of "make" later.
# At least GNU and BSD make implementations are okay with this syntax.
@NUT_AM_MAKE_CAN_EXPORT@export CCACHE_NAMESPACE=@CCACHE_NAMESPACE@
@NUT_AM_MAKE_CAN_EXPORT@export CCACHE_BASEDIR=@CCACHE_BASEDIR@
@NUT_AM_MAKE_CAN_EXPORT@export CCACHE_DIR=@CCACHE_DIR@
@NUT_AM_MAKE_CAN_EXPORT@export CCACHE_PATH=@CCACHE_PATH@
@NUT_AM_MAKE_CAN_EXPORT@export PATH=@PATH_DURING_CONFIGURE@

EXTRA_DIST = nit.sh README.adoc

if WITH_CHECK_NIT
check: check-NIT
else
check:
	@echo "NO-OP: $@ in `pwd` is inactive by default. Run 'configure --enable-check-NIT' or 'make check-NIT' explicitly" >&2
endif

# Run in builddir, use script from srcdir
# Avoid running "$<" - not all make implementations handle that
check-NIT: $(abs_srcdir)/nit.sh
	"$(abs_srcdir)/nit.sh"

# Make sure pre-requisites for NIT are fresh as we iterate
check-NIT-devel: $(abs_srcdir)/nit.sh
	+@cd .. && ( $(MAKE) $(AM_MAKEFLAGS) -s cppnit$(EXEEXT) || echo "OPTIONAL C++ test client test will be skipped" )
	+@cd "$(top_builddir)/clients" && $(MAKE) $(AM_MAKEFLAGS) -s upsc$(EXEEXT) upsrw$(EXEEXT) upsmon$(EXEEXT)
	+@cd "$(top_builddir)/server" && $(MAKE) $(AM_MAKEFLAGS) -s upsd$(EXEEXT)
	+@cd "$(top_builddir)/drivers" && $(MAKE) $(AM_MAKEFLAGS) -s dummy-ups$(EXEEXT)
	+@$(MAKE) $(AM_MAKEFLAGS) check-NIT

SPELLCHECK_SRC = README.adoc

# NOTE: Due to portability, we do not use a GNU percent-wildcard extension.
# We also have to export some variables that may be tainted by relative
# paths when parsing the other makefile (e.g. MKDIR_P that may be defined
# via expanded $(top_builddir)/install_sh):
#%-spellchecked: % Makefile.am $(top_srcdir)/docs/Makefile.am $(abs_srcdir)/$(NUT_SPELL_DICT)
#	+$(MAKE) -s -f $(top_builddir)/docs/Makefile $(AM_MAKEFLAGS) MKDIR_P="$(MKDIR_P)" builddir="$(builddir)" srcdir="$(srcdir)" top_builddir="$(top_builddir)" top_srcdir="$(top_srcdir)" SPELLCHECK_SRC_ONE="$<" SPELLCHECK_SRCDIR="$(srcdir)" SPELLCHECK_BUILDDIR="$(builddir)" $@

# NOTE: Portable suffix rules do not allow prerequisites, so we shim them here
# by a wildcard target in case the make implementation can put the two together.
*-spellchecked: Makefile.am $(top_srcdir)/docs/Makefile.am $(abs_srcdir)/$(NUT_SPELL_DICT)

.sample.sample-spellchecked:
	+$(MAKE) -s -f $(top_builddir)/docs/Makefile $(AM_MAKEFLAGS) MKDIR_P="$(MKDIR_P)" builddir="$(builddir)" srcdir="$(srcdir)" top_builddir="$(top_builddir)" top_srcdir="$(top_srcdir)" SPELLCHECK_SRC_ONE="$<" SPELLCHECK_SRCDIR="$(srcdir)" SPELLCHECK_BUILDDIR="$(builddir)" $@

.in.in-spellchecked:
	+$(MAKE) -s -f $(top_builddir)/docs/Makefile $(AM_MAKEFLAGS) MKDIR_P="$(MKDIR_P)" builddir="$(builddir)" srcdir="$(srcdir)" top_builddir="$(top_builddir)" top_srcdir="$(top_srcdir)" SPELLCHECK_SRC_ONE="$<" SPELLCHECK_SRCDIR="$(srcdir)" SPELLCHECK_BUILDDIR="$(builddir)" $@

spellcheck spellcheck-interactive spellcheck-sortdict:
	+$(MAKE) -f $(top_builddir)/docs/Makefile $(AM_MAKEFLAGS) MKDIR_P="$(MKDIR_P)" builddir="$(builddir)" srcdir="$(srcdir)" top_builddir="$(top_builddir)" top_srcdir="$(top_srcdir)" SPELLCHECK_SRC="$(SPELLCHECK_SRC)" SPELLCHECK_SRCDIR="$(srcdir)" SPELLCHECK_BUILDDIR="$(builddir)" $@

CLEANFILES = *-spellchecked

MAINTAINERCLEANFILES = Makefile.in .dirstamp

clean-local:
	$(AM_V_at)rm -rf tmp
