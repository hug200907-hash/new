#pragma once

#import <Foundation/Foundation.h>
#include <dlfcn.h>
#include <fcntl.h>
#include <mach-o/dyld.h>
#include <mach-o/loader.h>
#include <pthread/pthread.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <unistd.h>
#include <map>
#include <string>
#include <vector>

namespace Unity {

typedef struct
{
    uint32_t magic;
    int32_t cputype;
    int32_t cpusubtype;
    uint32_t filetype;
    uint32_t ncmds;
    uint32_t sizeofcmds;
    uint32_t flags;
    uint32_t reserved;
} mach_header_64_t;

typedef struct
{
    uint32_t cmd;
    uint32_t cmdsize;
} load_command_t;

typedef struct
{
    uint32_t cmd;
    uint32_t cmdsize;
    char segname[16];
    uint64_t vmaddr;
    uint64_t vmsize;
    uint64_t fileoff;
    uint64_t filesize;
    uint32_t maxprot;
    uint32_t initprot;
    uint32_t nsects;
    uint32_t flags;
} segment_command_64_t;

typedef struct
{
    uint64_t offset;
    uint64_t offsetEnd;
    uint64_t address;
    uint64_t addressEnd;
} search_section_t;

typedef struct
{
    search_section_t *items;
    size_t count;
    size_t cap;
} section_list_t;

typedef struct
{
    uint32_t nameIndex;
    int32_t assemblyIndex;
    int32_t typeStart;
    uint32_t typeCount;
    int32_t exportedTypeStart;
    uint32_t exportedTypeCount;
    int32_t entryPointIndex;
    uint32_t token;
    int32_t customAttributeStart;
    uint32_t customAttributeCount;
} Il2CppImageDefinition;

typedef struct
{
    uint32_t nameIndex;
    uint32_t namespaceIndex;
    int32_t byvalTypeIndex;
    int32_t declaringTypeIndex;
    int32_t parentIndex;
    int32_t elementTypeIndex;
    int32_t genericContainerIndex;
    uint32_t flags;
    int32_t fieldStart;
    int32_t methodStart;
    int32_t eventStart;
    int32_t propertyStart;
    int32_t nestedTypesStart;
    int32_t interfacesStart;
    int32_t vtableStart;
    int32_t interfaceOffsetsStart;
    uint16_t method_count;
    uint16_t property_count;
    uint16_t field_count;
    uint16_t event_count;
    uint16_t nested_type_count;
    uint16_t vtable_count;
    uint16_t interfaces_count;
    uint16_t interface_offsets_count;
    uint32_t bitfield;
    uint32_t token;
} Il2CppTypeDefinition;

typedef struct
{
    uint32_t nameIndex;
    int32_t declaringType;
    int32_t returnType;
    int32_t parameterStart;
    int32_t genericContainerIndex;
    uint32_t token;
    uint16_t flags;
    uint16_t iflags;
    uint16_t slot;
    uint16_t parameterCount;
} Il2CppMethodDefinition;

typedef struct
{
    uint32_t nameIndex;
    int32_t typeIndex;
    uint32_t token;
} Il2CppFieldDefinition;

typedef struct
{
    uint64_t reversePInvokeWrapperCount;
    uint64_t reversePInvokeWrappers;
    uint64_t genericMethodPointersCount;
    uint64_t genericMethodPointers;
    uint64_t genericAdjustorThunks;
    uint64_t invokerPointersCount;
    uint64_t invokerPointers;
    uint64_t unresolvedVirtualCallCount;
    uint64_t unresolvedVirtualCallPointers;
    uint64_t interopDataCount;
    uint64_t interopData;
    uint64_t windowsRuntimeFactoryCount;
    uint64_t windowsRuntimeFactoryTable;
    uint64_t codeGenModulesCount;
    uint64_t codeGenModules;
} Il2CppCodeRegistration;

typedef struct
{
    uint64_t moduleName;
    int64_t methodPointerCount;
    uint64_t methodPointers;
    int64_t adjustorThunkCount;
    uint64_t adjustorThunks;
    uint64_t invokerIndices;
    uint64_t reversePInvokeWrapperCount;
    uint64_t reversePInvokeWrapperIndices;
    int64_t rgctxRangesCount;
    uint64_t rgctxRanges;
    int64_t rgctxsCount;
    uint64_t rgctxs;
    uint64_t debuggerMetadata;
    uint64_t moduleInitializer;
    uint64_t staticConstructorTypeIndices;
    uint64_t metadataRegistration;
    uint64_t codeRegistration;
} Il2CppCodeGenModule;

typedef struct
{
    int64_t genericClassesCount;
    uint64_t genericClasses;
    int64_t genericInstsCount;
    uint64_t genericInsts;
    int64_t genericMethodTableCount;
    uint64_t genericMethodTable;
    int64_t typesCount;
    uint64_t types;
    int64_t methodSpecsCount;
    uint64_t methodSpecs;
    int64_t fieldOffsetsCount;
    uint64_t fieldOffsets;
    int64_t typeDefinitionsSizesCount;
    uint64_t typeDefinitionsSizes;
    uint64_t metadataUsagesCount;
    uint64_t metadataUsages;
} Il2CppMetadataRegistration;

typedef struct
{
    uint8_t *data;
    size_t size;
    bool is_mmap;
} file_buffer_t;

typedef struct
{
    uint64_t image_base;
    uint64_t code_reg_va;
    uint64_t meta_reg_va;
    file_buffer_t unity;
    file_buffer_t meta;
    section_list_t exec_secs;
    section_list_t data_secs;
    const uint32_t *hdr;
} unity_cache_t;

bool read_file(const char *path, file_buffer_t *out);
void free_file(file_buffer_t *buf);
void sec_push(section_list_t *list, search_section_t sec);
void sec_free(section_list_t *list);
uint32_t xor_subtract_u32(uint32_t value, uint32_t sub, uint32_t key);
bool deobf_meta(file_buffer_t *meta);
bool parse_macho(const file_buffer_t *buf, section_list_t *exec_secs, section_list_t *data_secs, uint64_t *out_image_base);
bool va_to_off(const section_list_t *secs, uint64_t va, uint64_t *out_off);
bool va_to_off_any(const section_list_t *data_secs, const section_list_t *exec_secs, uint64_t va, uint64_t *out_off);
bool off_to_va(const section_list_t *secs, uint64_t off, uint64_t *out_va);
bool va_in(const section_list_t *secs, uint64_t va);
bool find_bytes(const uint8_t *data, size_t data_len, const uint8_t *pat, size_t pat_len, size_t *out_pos);
size_t find_refs(const file_buffer_t *buf, const section_list_t *data_secs, uint64_t target_va, uint64_t *out_refs, size_t max_refs);
bool find_code_reg(const file_buffer_t *unity_buf, const section_list_t *exec_secs, const section_list_t *data_secs, int imageCount, uint64_t *out_code_reg_va);
bool find_meta_reg(const file_buffer_t *unity_buf, const section_list_t *exec_secs, const section_list_t *data_secs, int typeDefinitionsCount, uint64_t *out_meta_reg_va);
const char *metadata_string(const file_buffer_t *meta, const uint32_t *hdr, uint32_t index);
bool find_method_tok(const file_buffer_t *meta, const uint32_t *hdr, const char *image_name, const char *type_namespace, const char *type_name, const char *method_name, uint32_t *out_method_token);
bool find_field_idx(const file_buffer_t *meta, const uint32_t *hdr, const char *image_name, const char *type_namespace, const char *type_name, const char *field_name, int *out_type_index,
                    int *out_field_index_in_type, bool *out_is_value_type);
bool get_method_ptr(const file_buffer_t *unity_buf, const section_list_t *data_secs, const section_list_t *exec_secs, uint64_t code_reg_va, const char *image_name, uint32_t method_token,
                    uint64_t *out_method_va);
bool get_field_off(const file_buffer_t *unity_buf, const section_list_t *data_secs, const section_list_t *exec_secs, uint64_t metadata_reg_va, int typeIndex, int fieldIndexInType, bool isValueType,
                   int *out_offset);
char *get_unity_path();
char *get_meta_path();
bool init_cache(unity_cache_t *cache);
void free_cache(unity_cache_t *cache);
unity_cache_t *get_global_cache();

uint64_t FindMethodOffset(const char *image_name, const char *type_namespace, const char *type_name, const char *method_name);
size_t FindFieldOffset(const char *image_name, const char *type_namespace, const char *type_name, const char *field_name);

}  // namespace Unity

// Additional structures and utilities
union intfloat
{
    int i;
    float f;
};

class MemoryInfo
{
   public:
    uint32_t index;
    const mach_header *header;
    const char *name;
    intptr_t address;
};

struct MethodInfo
{
    void *methodPointer;
    void *virtualMethodPointer;
    void *invoker_method;
    const char *name;
};

struct Il2CppClass_1
{
    void *image;
    void *gc_desc;
    const char *name;
    const char *namespaze;
};

// IL2CPP Runtime functions namespace
namespace IL2CPP
{
extern const void *(*il2cpp_assembly_get_image)(const void *assembly);
extern void *(*il2cpp_domain_get)();
extern void **(*il2cpp_domain_get_assemblies)(const void *domain, size_t *size);
extern const char *(*il2cpp_image_get_name)(void *image);
extern void *(*il2cpp_class_from_name)(const void *image, const char *namespaze, const char *name);
extern void *(*il2cpp_class_get_field_from_name)(void *klass, const char *name);
extern void *(*il2cpp_class_get_method_from_name)(void *klass, const char *name, int argsCount);
extern size_t (*il2cpp_field_get_offset)(void *field);
extern void (*il2cpp_field_static_get_value)(void *field, void *value);
extern void (*il2cpp_field_static_set_value)(void *field, void *value);
extern void *(*il2cpp_image_get_class)(void *image, size_t index);
extern size_t (*il2cpp_class_num_fields)(void *Klass);
extern const void *(*il2cpp_class_get_image)(const void *Klass);
extern const char *(*il2cpp_class_get_name)(void *Klass);
extern const char *(*il2cpp_class_get_namespace)(void *Klass);
extern void *(*il2cpp_class_get_fields)(void *Klass, void **iter);
extern void *(*il2cpp_class_get_parent)(void *Klass);
extern const char *(*il2cpp_field_get_name)(void *field);
extern void *(*il2cpp_array_new)(void *elementTypeInfo, size_t length);
extern uint16_t *(*il2cpp_string_chars)(void *str);
extern void *(*il2cpp_string_new)(const char *str);
extern void *(*il2cpp_string_new_utf16)(const wchar_t *str, int32_t length);
extern char *(*il2cpp_type_get_name)(void *type);
extern void *(*il2cpp_method_get_param)(void *method, uint32_t index);
extern void *(*il2cpp_class_get_methods)(void *klass, void **iter);
extern const char *(*il2cpp_method_get_name)(void *method);
extern void *(*il2cpp_object_new)(void *klass);
extern void (*il2cpp_runtime_class_init)(void *klass);
}  // namespace IL2CPP

void Attach();
void *Il2CppGetImageByName(const char *image);
void *Il2CppGetClassType(const char *image, const char *namespaze, const char *clazz);
void *Il2CppGetMethodOffset(const char *image, const char *namespaze, const char *clazz, const char *name, int argsCount);
size_t Il2CppGetFieldOffset(const char *image, const char *namespaze, const char *clazz, const char *name);
void *Il2CppGetSingleton(const char *dllfilename, const char *namespaze, const char *className);
void *Il2CppGetInstance(const char *dllfilename, const char *namespaze, const char *className);
void *Il2CppGetGenericSingleton(const char *dllfilename, const char *namespaze, const char *className);
void *GetStaticInstance(const char *dllfilename, const char *namespaze, const char *className, const char *staticFieldName);
void *get_offset(const char *dllfilename, const char *namespaze, const char *className, const char *methodName, int argsCount);
size_t getFieldOffset(const char *dllFilename, const char *namespaceName, const char *className, const char *fieldName);

// Main API functions for v1.61
uint64_t newGetMethodOffset(const char *dllfilenamec, const char *namespazec, const char *classNamec, const char *methodNamec, int argsCount);
uint64_t newGetFieldOffset(const char *dllfilenamec, const char *namespazec, const char *classNamec, const char *fieldNamec);

// Obfuscated value functions
int GetObscuredIntValue(uint64_t location);
int GetObscuredBoolValue(uint64_t location);
void SetObscuredIntValue(uint64_t location, int value);
float GetObscuredFloatValue(uint64_t location);
void SetObscuredFloatValue(uint64_t location, float value);

// Hook function
bool Il2CppHookImpl(const char *image, const char *namespaze, const char *clazz, void *hook, void *orig, const char *name, int cnttt);

// Debug function
void DebugClassFields(const char *dllfilename, const char *namespaze, const char *className);

// monoString structure
typedef struct _monoString
{
    Il2CppClass_1 *klass;
    void *monitor;
    int length;
    char chars[1];

    int getLength()
    {
        return length;
    }

    char *getChars()
    {
        return chars;
    }

    NSString *toNSString()
    {
        return [[NSString alloc] initWithBytes:(const void *)(chars) length:(NSUInteger)(length * 2) encoding:(NSStringEncoding)NSUTF16LittleEndianStringEncoding];
    }

    const char *c_str()
    {
        return toNSString().UTF8String;
    }

    std::string str()
    {
        return std::string(c_str());
    }
} monoString;

// Il2CppArray
template <typename T>
struct Il2CppArray {
    void *klass;
    void *monitor;
    void *bounds;
    int max_length;
    T m_Items[0];  // Flexible array member - actual size determined at runtime

    int getLength()
    {
        return max_length;
    }

    T *getPointer()
    {
        return (T *)m_Items;
    }

    T &operator[](int i)
    {
        return m_Items[i];
    }

    T &operator[](int i) const
    {
        return m_Items[i];
    }
};

template <typename T>
using Array = Il2CppArray<T>;

// Il2CppList
template <typename T>
struct Il2CppList {
    void *klass;
    void *unk1;
    Array<T> *items;
    int size;
    int version;

    T *getItems()
    {
        if (!items) return nullptr;
        return items->getPointer();
    }

    int getSize()
    {
        return size;
    }

    int getVersion()
    {
        return version;
    }

    T &operator[](int i)
    {
        if (!items)
        {
            static T dummy = {};
            return dummy;
        }
        return items->m_Items[i];
    }

    T &operator[](int i) const
    {
        if (!items)
        {
            static T dummy = {};
            return dummy;
        }
        return items->m_Items[i];
    }

    std::vector<T> toCPPlist()
    {
        std::vector<T> ret;
        if (!items || size <= 0) return ret;
        ret.reserve(size);
        for (int i = 0; i < size; i++)
        {
            ret.push_back(items->m_Items[i]);
        }
        return ret;
    }
};

template <typename T>
using List = Il2CppList<T>;

// monoArray
template <typename T>
struct monoArray {
    void *klass;
    void *monitor;
    void *bounds;
    int32_t capacity;
    T m_Items[0];

    int getCapacity()
    {
        return capacity;
    }

    T *getPointer()
    {
        return m_Items;
    }

    std::vector<T> toCPPlist()
    {
        std::vector<T> ret;
        for (int i = 0; i < capacity; i++) ret.push_back(m_Items[i]);
        return ret;
    }

    T operator[](int index)
    {
        if (getCapacity() < index) return {};
        return m_Items[index];
    }

    T at(int index)
    {
        if (getCapacity() <= index || empty()) return {};
        return m_Items[index];
    }

    bool empty()
    {
        return getCapacity() <= 0;
    }
};
