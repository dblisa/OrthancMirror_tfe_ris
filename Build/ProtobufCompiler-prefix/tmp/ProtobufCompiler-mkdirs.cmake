# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "/home/linux/Documents/UCL2627/TFE_RIS/Orthanc/OrthancFramework/Resources/CMake/../ProtocolBuffers"
  "/home/linux/Documents/UCL2627/TFE_RIS/Orthanc/Build/ProtobufCompiler-build"
  "/home/linux/Documents/UCL2627/TFE_RIS/Orthanc/Build/ProtobufCompiler-prefix"
  "/home/linux/Documents/UCL2627/TFE_RIS/Orthanc/Build/ProtobufCompiler-prefix/tmp"
  "/home/linux/Documents/UCL2627/TFE_RIS/Orthanc/Build/ProtobufCompiler-prefix/src/ProtobufCompiler-stamp"
  "/home/linux/Documents/UCL2627/TFE_RIS/Orthanc/Build/ProtobufCompiler-prefix/src"
  "/home/linux/Documents/UCL2627/TFE_RIS/Orthanc/Build/ProtobufCompiler-prefix/src/ProtobufCompiler-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/home/linux/Documents/UCL2627/TFE_RIS/Orthanc/Build/ProtobufCompiler-prefix/src/ProtobufCompiler-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "/home/linux/Documents/UCL2627/TFE_RIS/Orthanc/Build/ProtobufCompiler-prefix/src/ProtobufCompiler-stamp${cfgdir}") # cfgdir has leading slash
endif()
