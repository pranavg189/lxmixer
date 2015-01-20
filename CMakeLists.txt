# newer cmake is required for CMAKE_AUTOMOC Qt support
cmake_minimum_required(VERSION 2.8.11)

project(lxmixer)

# additional cmake files
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

set (MAJOR_VERSION 0)
set (MINOR_VERSION 0)
set (PATCH_VERSION 0)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(CMAKE_AUTOMOC ON)

find_package(Qt5Widgets REQUIRED)
find_package(Qt5DBus REQUIRED)
find_package(Qt5X11Extras REQUIRED QUIET)
find_package(Qt5LinguistTools REQUIRED QUIET)
message(STATUS "Building with Qt ${Qt5Core_VERSION_STRING}")

find_package(PkgConfig REQUIRED)
pkg_check_modules(GLIB REQUIRED glib-2.0)

# add src subdirectory
add_subdirectory(src)

# install an icon for the application
#install(
#	FILES data/lximage-qt.png
#	# FIXME: is this the proper place to install an icon?
#	DESTINATION share/icons/hicolor/48x48/apps
#)

#install(TARGETS ${PROJECT_NAME} RUNTIME DESTINATION bin)
#install(FILES ${CONFIG_FILES} DESTINATION ${APP_SHARE_DIR})
#install(FILES ${DESKTOP_FILES} DESTINATION share/applications)

# building tarball with CPack -------------------------------------------------
include (InstallRequiredSystemLibraries)
set (CPACK_PACKAGE_VERSION_MAJOR ${MAJOR_VERSION})
set (CPACK_PACKAGE_VERSION_MINOR ${MINOR_VERSION})
set (CPACK_PACKAGE_VERSION_PATCH ${PATCH_VERSION})
set (CPACK_GENERATOR TBZ2)
set (CPACK_SOURCE_GENERATOR TBZ2)
set (CPACK_SOURCE_IGNORE_FILES /build/;.gitignore;.*~;.git;.kdev4;temp)
include (CPack)
