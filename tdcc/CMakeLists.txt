PROJECT (tdcc)
CMAKE_MINIMUM_REQUIRED (VERSION 2.6)

FIND_PACKAGE (PythonInterp REQUIRED)

EXECUTE_PROCESS(COMMAND
                ${PYTHON_EXECUTABLE} -c "from sys import stdout; from distutils import sysconfig; stdout.write(sysconfig.get_python_lib(True))"
                OUTPUT_VARIABLE PYTHON_INSTALL_DIR)
EXECUTE_PROCESS(COMMAND
                ${PYTHON_EXECUTABLE} -c "import sys; sys.stdout.write('%s.%s' % (sys.version_info.major, sys.version_info.minor))"
                OUTPUT_VARIABLE PYTHON_MAJOR_DOT_MINOR_VERSION)

MESSAGE(STATUS "Python install dir is ${PYTHON_INSTALL_DIR}")

INSTALL (FILES tdcc.desktop DESTINATION ${CMAKE_INSTALL_PREFIX}/share/applications)

ADD_SUBDIRECTORY(bin)
ADD_SUBDIRECTORY(tdcc)
