####################################################################################
################################## SALAMANDER Makefile ##################################
####################################################################################
#
# Optional Environment variables:
#
# MOOSE_DIR        - Root directory of MOOSE
# TMAP8_DIR        - Root directory of TMAP8
# CARDINAL_DIR     - Root directory of Cardinal
# OPENMC_DIR       - Root directory of OpenMC
# DAGMC_DIR        - Root directory of DagMC
# MOAB_DIR         - Root directory of MOAB
#
# EIGEN3_DIR       - Root directory of Eigen3 (should contain FindEigen3.cmake).
#                    This is needed for DagMC.
#
# OpenMC uses HDF5; below are influential environment variables for that
# installation. None of these need to be set if HDF5 is being pulled from
# a manual PETSc installation, and HDF5_DIR is provided directly from conda.
#
# HDF5_DIR         - Root directory of HDF5
# HDF5_INCLUDE_DIR - Root directory for HDF5 headers (default: $(HDF5_DIR)/include)
# HDF5_LIBDIR      - Root directory for HDF5 libraries (default: $(HDF5_DIR)/lib)
# PETSC_DIR        - Root directory for PETSc (default: $(MOOSE_DIR)/petsc)
# PETSC_ARCH       - PETSc architecture (default: arch-moose)
####################################################################################
# Use the MOOSE submodule if it exists and MOOSE_DIR is not set
# If it doesn't exist, and MOOSE_DIR is not set, then look for it adjacent to the application
MOOSE_SUBMODULE       := $(CURDIR)/moose
ifneq ($(wildcard $(MOOSE_SUBMODULE)/framework/Makefile),)
  MOOSE_DIR           ?= $(MOOSE_SUBMODULE)
else
  MOOSE_DIR           ?= $(shell dirname `pwd`)/moose
endif
FRAMEWORK_DIR      := $(MOOSE_DIR)/framework

SALAMANDER_DIR     := $(CURDIR)

# Check for optional dependencies and, if found, configure for building.
include config/check_deps.mk

# ENABLE_CARDINAL = yes by default, but is set to "no" automatically if Cardinal is not found via CARDINAL_DIR.
ifeq ($(ENABLE_CARDINAL),yes)
  include config/configure_cardinal.mk
endif

# framework
include $(FRAMEWORK_DIR)/build.mk
include $(FRAMEWORK_DIR)/moose.mk

################################## MODULES ####################################
# The default MOOSE modules used with SALAMANDER are activated below. To turn on more
# modules, set their respective variables to yes. One can also set ALL_MODULES
# to yes to turn on everything (overrides other set variables).
#
# Additional modules may be turned on by optional dependencies - please
# reference config/dep_modules.mk to review those that might be available
# in your installation configuration.

ALL_MODULES                 := no

CHEMICAL_REACTIONS          := no
CONTACT                     := no
ELECTROMAGNETICS            := yes
EXTERNAL_PETSC_SOLVER       := no
FLUID_PROPERTIES            := no
FSI                         := no
FUNCTIONAL_EXPANSION_TOOLS  := no
GEOCHEMISTRY                := no
HEAT_TRANSFER               := no
LEVEL_SET                   := no
MISC                        := no
NAVIER_STOKES               := no
OPTIMIZATION                := no
PERIDYNAMICS                := no
PHASE_FIELD                 := no
POROUS_FLOW                 := no
RAY_TRACING                 := yes
REACTOR                     := no
RDG                         := no
RICHARDS                    := no
SCALAR_TRANSPORT            := no
SOLID_MECHANICS             := no
SOLID_PROPERTIES            := no
STOCHASTIC_TOOLS            := yes
THERMAL_HYDRAULICS          := no
XFEM                        := no

# Enable modules required by optional dependencies
include config/dep_modules.mk

include $(MOOSE_DIR)/modules/modules.mk
###############################################################################

# Build optional dependencies
include config/build_deps.mk

# SALAMANDER
APPLICATION_DIR    := $(SALAMANDER_DIR)
APPLICATION_NAME   := salamander
BUILD_EXEC         := yes
GEN_REVISION       := yes

# Cardinal dependency libraries needed for SALAMANDER linking
ifeq ($(ENABLE_CARDINAL),yes)
  ADDITIONAL_LIBS := -L$(CARDINAL_DIR)/lib $(CC_LINKER_SLFLAG)$(CARDINAL_DIR)/lib \
                     -L$(OPENMC_LIBDIR) -lopenmc -lhdf5_hl -ldagmc -lMOAB \
                     $(CC_LINKER_SLFLAG)$(OPENMC_LIBDIR)
endif

include            $(FRAMEWORK_DIR)/app.mk

# External flags
ifeq ($(ENABLE_CARDINAL),yes)
  include config/external_cardinal_flags.mk
endif
