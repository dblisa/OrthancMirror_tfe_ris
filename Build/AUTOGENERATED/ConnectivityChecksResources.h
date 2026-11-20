
#pragma once

#include <string>
#include <list>

#if defined(_MSC_VER)
#  pragma warning(disable: 4065)  // "Switch statement contains 'default' but no 'case' labels"
#endif

namespace Orthanc {
namespace EmbeddedResources {

    enum FileResourceId
    {

    };

    enum DirectoryResourceId
    {
      WEB_RESOURCES,
      LIBRARIES
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
