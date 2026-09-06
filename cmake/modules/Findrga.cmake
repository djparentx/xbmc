# Findrga
# ----------
# Finds the RGA library
#
# This will define the following target:
#
#   RGA::RGA   - The RGA library

if(NOT TARGET RGA::RGA)
  find_package(PkgConfig)
  if(PKG_CONFIG_FOUND)
    pkg_check_modules(PC_RGA librga QUIET)
  endif()

  find_path(RGA_INCLUDE_DIR NAMES rga/RgaApi.h
                            HINTS ${PC_RGA_INCLUDEDIR})
  find_library(RGA_LIBRARY NAMES rga
                           HINTS ${PC_RGA_LIBDIR})

  include(FindPackageHandleStandardArgs)
  find_package_handle_standard_args(rga
                                    REQUIRED_VARS RGA_LIBRARY RGA_INCLUDE_DIR)

  if(RGA_FOUND)
    add_library(RGA::RGA UNKNOWN IMPORTED)
    set_target_properties(RGA::RGA PROPERTIES
                                   IMPORTED_LOCATION "${RGA_LIBRARY}"
                                   INTERFACE_INCLUDE_DIRECTORIES "${RGA_INCLUDE_DIR}")
    set_property(GLOBAL APPEND PROPERTY INTERNAL_DEPS_PROP RGA::RGA)
  endif()
endif()
