
#pragma once

#include <string>
#include <list>

#if defined(_MSC_VER)
#  pragma warning(disable: 4065)  // "Switch statement contains 'default' but no 'case' labels"
#endif

namespace Orthanc {
namespace ServerResources {

    enum FileResourceId
    {
      DICOM_CONFORMANCE,
      FONT_UBUNTU_MONO_BOLD_16,
      LUA_TOOLBOX,
      PREPARE_DATABASE,
      UPGRADE_DATABASE_3_TO_4,
      UPGRADE_DATABASE_4_TO_5,
      INSTALL_TRACK_ATTACHMENTS_SIZE,
      INSTALL_LABELS_TABLE,
      INSTALL_REVISION_AND_CUSTOM_DATA,
      INSTALL_DELETED_FILES,
      INSTALL_KEY_VALUE_STORES_AND_QUEUES,
      ADD_TIMEOUT_TO_QUEUES,
      INSTALL_DICOM_IDENTIFIERS_INDEX_3,
      MAKE_PUBLIC_INDEX_UNIQUE,
      INSTALL_ATTACHED_FILES_UUID_INDEX,
      CONFIGURATION_SAMPLE,
      ADVANCED_CONFIGURATION_SAMPLE
    };

    enum DirectoryResourceId
    {
      ORTHANC_EXPLORER
    };

    const void* GetFileResourceBuffer(FileResourceId id);
    size_t GetFileResourceSize(FileResourceId id);
    void GetFileResource(std::string& result, FileResourceId id);

    const void* GetDirectoryResourceBuffer(DirectoryResourceId id, const char* path);
    size_t GetDirectoryResourceSize(DirectoryResourceId id, const char* path);
    void GetDirectoryResource(std::string& result, DirectoryResourceId id, const char* path);

    void ListResources(std::list<std::string>& result, DirectoryResourceId id);

}
}
