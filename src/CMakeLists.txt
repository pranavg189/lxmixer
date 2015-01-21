# set visibility to hidden to hide symbols, unlesss they're exporeted manually in the code
set(CMAKE_CXX_FLAGS "-DQT_NO_KEYWORDS -fno-exceptions")

set(QTX_INCLUDE_DIRS "")
set(QTX_LIBRARIES Qt5::Widgets Qt5::Core Qt5::DBus Qt5::X11Extras)

include_directories(
    ${QTX_INCLUDE_DIRS}
    ${CMAKE_CURRENT_BINARY_DIR}
    ${GLIB_INCLUDE_DIRS}
    ${EXIF_INCLUDE_DIRS}
    ${LIBFM_QT_INCLUDE_DIRS}
    ${X11_INCLUDE_DIR}
    ${XFIXES_INCLUDE_DIRS}
)

# For some unknown reasons these are required for build on FreeBSD
link_directories(
    ${QT_LIBRARY_DIR}
    ${GLIB_LIBRARY_DIRS}
)

set(lxmixer_SRCS
    main.cpp
    mainwindow.cpp
)

set(lxmixer_HEADERS
    mainwindow.h
)

set(lxmixer_UIS
    mainwindow.ui
)
qt5_wrap_ui(lxmixer_UI_H ${lxmixer_UIS})

# add translation for lxmixer
# See http://www.cmake.org/Wiki/CMake:How_To_Build_Qt4_Software
file(GLOB TS_FILES translations/*.ts)
option (UPDATE_TRANSLATIONS "Update source translation translations/*.ts files")
if (UPDATE_TRANSLATIONS)
    qt5_create_translation(QM_FILES ${lxmixer_SRCS} ${lxmixer_UI_H} ${TS_FILES})
else()
    qt5_add_translation(QM_FILES ${TS_FILES})
endif()

add_custom_target (lxmixer_translations DEPENDS ${QM_FILES})
install(FILES ${QM_FILES} DESTINATION share/lxmixer/translations)
# prevent the generated files from being deleted during make clean
set_directory_properties(PROPERTIES CLEAN_NO_CUSTOM true)

# process desktop entry files
include(LXQtTranslateDesktop)

file(GLOB desktop_files_in ../data/*.desktop.in)
lxqt_translate_desktop(desktop_files SOURCES ${desktop_files_in})
install(FILES ${desktop_files} DESTINATION share/applications)

add_executable(lxmixer
    ${lxmixer_SRCS}
    ${lxmixer_UI_H}
    ${desktop_files}
    ${QM_FILES}
)

add_definitions(
    -DLXIMAGE_DATA_DIR="${CMAKE_INSTALL_PREFIX}/share/lxmixer"
    -DLIBFM_QT_API=Q_DECL_IMPORT    # FIXME: This should be done in libfm-qt headers instead :-(
)

target_link_libraries(lxmixer
    ${QTX_LIBRARIES}
    ${GLIB_LIBRARIES}
    ${EXIF_LIBRARIES}
    ${LIBFM_QT_LIBRARIES}
    ${X11_LIBRARIES}
    ${XFIXES_LIBRARIES}
)

install(TARGETS lxmixer RUNTIME DESTINATION bin)