# Install script for directory: /home/linux/Documents/UCL2627/TFE_RIS/Orthanc/OrthancServer

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/objdump")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/sbin/Orthanc" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/sbin/Orthanc")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/sbin/Orthanc"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/sbin" TYPE EXECUTABLE FILES "/home/linux/Documents/UCL2627/TFE_RIS/Orthanc/Build/Orthanc")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/sbin/Orthanc" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/sbin/Orthanc")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/sbin/Orthanc")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins/libServeFolders.so.mainline" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins/libServeFolders.so.mainline")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins/libServeFolders.so.mainline"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins" TYPE SHARED_LIBRARY FILES "/home/linux/Documents/UCL2627/TFE_RIS/Orthanc/Build/libServeFolders.so.mainline")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins/libServeFolders.so.mainline" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins/libServeFolders.so.mainline")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins/libServeFolders.so.mainline")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins" TYPE SHARED_LIBRARY FILES "/home/linux/Documents/UCL2627/TFE_RIS/Orthanc/Build/libServeFolders.so")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins/libModalityWorklists.so.mainline" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins/libModalityWorklists.so.mainline")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins/libModalityWorklists.so.mainline"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins" TYPE SHARED_LIBRARY FILES "/home/linux/Documents/UCL2627/TFE_RIS/Orthanc/Build/libModalityWorklists.so.mainline")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins/libModalityWorklists.so.mainline" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins/libModalityWorklists.so.mainline")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins/libModalityWorklists.so.mainline")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins" TYPE SHARED_LIBRARY FILES "/home/linux/Documents/UCL2627/TFE_RIS/Orthanc/Build/libModalityWorklists.so")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins/libConnectivityChecks.so.mainline" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins/libConnectivityChecks.so.mainline")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins/libConnectivityChecks.so.mainline"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins" TYPE SHARED_LIBRARY FILES "/home/linux/Documents/UCL2627/TFE_RIS/Orthanc/Build/libConnectivityChecks.so.mainline")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins/libConnectivityChecks.so.mainline" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins/libConnectivityChecks.so.mainline")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins/libConnectivityChecks.so.mainline")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins" TYPE SHARED_LIBRARY FILES "/home/linux/Documents/UCL2627/TFE_RIS/Orthanc/Build/libConnectivityChecks.so")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins/libDelayedDeletion.so.mainline" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins/libDelayedDeletion.so.mainline")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins/libDelayedDeletion.so.mainline"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins" TYPE SHARED_LIBRARY FILES "/home/linux/Documents/UCL2627/TFE_RIS/Orthanc/Build/libDelayedDeletion.so.mainline")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins/libDelayedDeletion.so.mainline" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins/libDelayedDeletion.so.mainline")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins/libDelayedDeletion.so.mainline")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins" TYPE SHARED_LIBRARY FILES "/home/linux/Documents/UCL2627/TFE_RIS/Orthanc/Build/libDelayedDeletion.so")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins/libHousekeeper.so.mainline" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins/libHousekeeper.so.mainline")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins/libHousekeeper.so.mainline"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins" TYPE SHARED_LIBRARY FILES "/home/linux/Documents/UCL2627/TFE_RIS/Orthanc/Build/libHousekeeper.so.mainline")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins/libHousekeeper.so.mainline" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins/libHousekeeper.so.mainline")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins/libHousekeeper.so.mainline")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins" TYPE SHARED_LIBRARY FILES "/home/linux/Documents/UCL2627/TFE_RIS/Orthanc/Build/libHousekeeper.so")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins/libMultitenantDicom.so.mainline" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins/libMultitenantDicom.so.mainline")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins/libMultitenantDicom.so.mainline"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins" TYPE SHARED_LIBRARY FILES "/home/linux/Documents/UCL2627/TFE_RIS/Orthanc/Build/libMultitenantDicom.so.mainline")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins/libMultitenantDicom.so.mainline" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins/libMultitenantDicom.so.mainline")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins/libMultitenantDicom.so.mainline")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/orthanc/plugins" TYPE SHARED_LIBRARY FILES "/home/linux/Documents/UCL2627/TFE_RIS/Orthanc/Build/libMultitenantDicom.so")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/OrthancRecoverCompressedFile" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/OrthancRecoverCompressedFile")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/OrthancRecoverCompressedFile"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/home/linux/Documents/UCL2627/TFE_RIS/Orthanc/Build/OrthancRecoverCompressedFile")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/OrthancRecoverCompressedFile" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/OrthancRecoverCompressedFile")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/OrthancRecoverCompressedFile")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/orthanc" TYPE FILE FILES
    "/home/linux/Documents/UCL2627/TFE_RIS/Orthanc/OrthancServer/Plugins/Include/orthanc/OrthancCDatabasePlugin.h"
    "/home/linux/Documents/UCL2627/TFE_RIS/Orthanc/OrthancServer/Plugins/Include/orthanc/OrthancCPlugin.h"
    "/home/linux/Documents/UCL2627/TFE_RIS/Orthanc/OrthancServer/Plugins/Include/orthanc/OrthancDatabasePlugin.proto"
    "/home/linux/Documents/UCL2627/TFE_RIS/Orthanc/OrthancServer/Plugins/Include/orthanc/OrthancPluginCodeModel.json"
    )
endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/linux/Documents/UCL2627/TFE_RIS/Orthanc/Build/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
