include (ExternalProject)

set(gemmlowp_URL https://mirror.bazel.build/github.com/google/gemmlowp/archive/010bb3e71a26ca1d0884a167081d092b43563996.zip)
set(gemmlowp_HASH SHA256=dd2557072bde12141419cb8320a9c25e6ec41a8ae53c2ac78c076a347bb46d9d)
set(gemmlowp_BUILD ${CMAKE_CURRENT_BINARY_DIR}/gemmlowp/src/gemmlowp)
set(gemmlowp_INCLUDE_DIR ${CMAKE_CURRENT_BINARY_DIR}/gemmlowp/src/gemmlowp)

ExternalProject_Add(gemmlowp
    PREFIX gemmlowp
    URL ${gemmlowp_URL}
    URL_HASH ${gemmlowp_HASH}
    DOWNLOAD_DIR "${DOWNLOAD_LOCATION}"
    BUILD_IN_SOURCE 1
    PATCH_COMMAND ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_CURRENT_SOURCE_DIR}/patches/gemmlowp/CMakeLists.txt ${gemmlowp_BUILD}
    INSTALL_COMMAND "")
