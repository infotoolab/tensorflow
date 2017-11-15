include (ExternalProject)

set(gemmlowp_URL http://github.com/google/gemmlowp/archive/a6f29d8ac48d63293f845f2253eccbf86bc28321.tar.gz)
set(gemmlowp_HASH SHA256=1e40863d9f15dd6b15f8f18f49c500944be6118d9fe17e9dc58a1c709cadbb8a)
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
