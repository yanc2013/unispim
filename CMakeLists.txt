# CMakeLists.txt --- CMake project settings
#    ex) cmake -G "Visual Studio 9 2008" .
#    ex) cmake -DCMAKE_BUILD_TYPE=Release -G "MSYS Makefiles" .
##############################################################################

# CMake minimum version
cmake_minimum_required(VERSION 3.0)

# project name and languages
project(unispim C CXX RC)

# set output directory (build/)
set(CMAKE_BINARY_DIR ${CMAKE_SOURCE_DIR}/build)
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR})
set(LIBRARY_OUTPUT_PATH ${CMAKE_BINARY_DIR})

# statically link
if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    # using Clang
    set(CMAKE_C_FLAGS "-static")
    set(CMAKE_CXX_FLAGS "-static")
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    # using GCC
    set(CMAKE_C_FLAGS "-static")
    set(CMAKE_CXX_FLAGS "-static")
elseif (MSVC)
    # replace "/MD" with "/MT" (building without runtime DLLs)
    set(CompilerFlags
        CMAKE_C_FLAGS
        CMAKE_C_FLAGS_DEBUG
        CMAKE_C_FLAGS_MINSIZEREL
        CMAKE_C_FLAGS_RELEASE
        CMAKE_C_FLAGS_RELWITHDEBINFO
        CMAKE_CXX_FLAGS
        CMAKE_CXX_FLAGS_DEBUG
        CMAKE_CXX_FLAGS_MINSIZEREL
        CMAKE_CXX_FLAGS_RELEASE
        CMAKE_CXX_FLAGS_RELWITHDEBINFO)
    foreach(CompilerFlags ${CompilerFlags})
        string(REPLACE "/MD" "/MT" ${CompilerFlags} "${${CompilerFlags}}")
    endforeach()
endif()

##############################################################################
# ZLib

add_subdirectory(zlib)

set(ZLIB_INCLUDE_DIRS .)
set(ZLIB_LIBRARY zlibstatic)

##############################################################################

# Add include directories
include_directories(include)

# Use codepage 936 (Chinese)
if(MSVC)
    add_definitions(/source-charset:.936 /execution-charset:.936)
else()
    add_definitions(-finput-charset=cp936 -fexec-charset=cp936)
endif()

# Unicode support
add_definitions(-DUNICODE -D_UNICODE)

# ime_install.exe
add_executable(ime_install source/win32/ime_setup.c)
target_compile_definitions(ime_install PRIVATE -D_CONSOLE -D_CRT_SECURE_NO_DEPRECATE)
target_link_libraries(ime_install PRIVATE imm32 shlwapi)

# unispim.ime
add_library(unispim SHARED
    source/bh.c
    source/bigram.c
    source/ci.c
    source/config.c
    source/context.c
    source/editor.c
    source/english.c
    source/fontcheck.c
    source/gbk_map.c
    source/icw.c
    source/win32/ime_interface.c
    source/win32/ime_main.c
    source/j2f.c
    source/kernel.c
    source/libfunc.c
    source/win32/main_windows.cpp
    source/tools/map_file.cpp
    source/pim_resource.c
    source/pim_state.c
    source/share_segment.c
    source/win32/softkbd.c
    source/spw.c
    source/syllable.c
    source/symbol.c
    source/win32/ui_window.c
    source/utility.c
    source/wordlib.c
    source/wordlib_v5.c
    source/zi.c
    source/unispim.def)
target_include_directories(unispim PRIVATE ${ZLIB_INCLUDE_DIRS})
target_compile_definitions(unispim PRIVATE -D_WIN32_WINNT=0x501 -D_USRDLL -DUNISPIM_EXPORTS -D_CRT_SECURE_NO_DEPRECATE)
target_link_libraries(unispim PRIVATE shlwapi msimg32 ${ZLIB_LIBRARY} comctl32 imm32 gdiplus)
set_target_properties(unispim PROPERTIES PREFIX "")
set_target_properties(unispim PROPERTIES SUFFIX "")
set_target_properties(unispim PROPERTIES OUTPUT_NAME "unispim6.ime")

# ci_test.exe
add_executable(ci_test
    source/j2f.c
    source/share_segment.c
    source/utility.c
    source/wl_tool.c)
target_include_directories(ci_test PRIVATE ${ZLIB_INCLUDE_DIRS})
target_link_libraries(ci_test PRIVATE ${ZLIB_LIBRARY} unispim comctl32 imm32 gdiplus htmlhelp)
