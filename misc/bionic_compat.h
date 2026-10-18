/* Di-include paksa (-include) ke semua file C/C++ library AOSP lewat CMakeLists.txt.
 *
 * Header publik NDK r27 tidak mendeklarasikan fungsi property internal ini, padahal
 * libbase, liblog, libcutils dan libselinux Android 17 memakainya. Simbolnya ada di
 * libc.a (bionic statis), jadi cukup dideklarasikan.
 * Taruh di: misc/bionic_compat.h
 */
#ifndef AAPT2_BIONIC_COMPAT_H
#define AAPT2_BIONIC_COMPAT_H

#include <stdint.h>
#include <sys/system_properties.h>

#ifdef __cplusplus
extern "C" {
#endif

uint32_t __system_property_area_serial(void);
uint32_t __system_property_serial(const prop_info* pi);
int __system_properties_init(void);

#ifdef __cplusplus
}
#endif

#endif
