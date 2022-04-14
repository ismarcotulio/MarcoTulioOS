#
# Copyright (C) 2017 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

PRODUCT_SHIPPING_API_LEVEL := 28
TARGET_USES_MKE2FS := true

DISABLE_RILD_OEM_HOOK := true

AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    product \
    system \
    vendor

PRODUCT_PACKAGES += \
    update_engine \
    update_verifier

# Properties that are not vendor-specific. These will go in the product
# partition, instead of the vendor partition, and do not need vendor
# sepolicy
PRODUCT_PRODUCT_PROPERTIES := \
    persist.adb.tcp.port=5555 \
    persist.traced.enable=1 \
    ro.com.google.locationfeatures=1 \
 
# Explanation of specific properties:
#   debug.hwui.swap_with_damage avoids boot failure on M http://b/25152138
#   ro.opengles.version OpenGLES 3.0
PRODUCT_PROPERTY_OVERRIDES += \
    tombstoned.max_tombstone_count=500 \
    bt.rootcanal_test_console=off \
    debug.hwui.swap_with_damage=0 \
    ro.carrier=unknown \
    ro.com.android.dataroaming=false \
    ro.hardware.virtual_device=1 \
    ro.logd.size=1M \
    ro.opengles.version=196608 \
    wifi.interface=wlan0 \

# Below is a list of properties we probably should get rid of.
PRODUCT_PROPERTY_OVERRIDES += \
    wlan.driver.status=ok

# aes-256-heh default is not supported in standard kernels.
PRODUCT_PROPERTY_OVERRIDES += ro.crypto.volume.filenames_mode=aes-256-cts

# P doesn't have APEX modules, but for Q/R compatibiltiy testing, claim
# to support updatable APEX, as the P kernel does support it
PRODUCT_PROPERTY_OVERRIDES += ro.apex.updatable=true

# Packages for various GCE-specific utilities
#
PRODUCT_PACKAGES += \
    socket_vsock_proxy \
    CuttlefishService \
    wpa_supplicant.vsoc.conf \
    vsoc_input_service \
    rename_netiface \
    ip_link_add \
    setup_wifi \

#
# Packages for AOSP-available stuff we use from the framework
#
PRODUCT_PACKAGES += \
    e2fsck \
    ip \
    sleep \
    tcpdump \
    wpa_supplicant \
    wificond \

#
# Packages for the OpenGL implementation
#

# SwiftShader provides a software-only implementation that is not thread-safe
PRODUCT_PACKAGES += \
    libEGL_swiftshader \
    libGLESv1_CM_swiftshader \
    libGLESv2_swiftshader

# GL implementation for virgl
PRODUCT_PACKAGES += \
    libGLES_mesa

DEVICE_PACKAGE_OVERLAYS := device/marco_tulio/MarcoTulioOS/shared/overlay
PRODUCT_AAPT_CONFIG := normal large xlarge hdpi xhdpi
# PRODUCT_AAPT_PREF_CONFIG is intentionally not set to pick up every density resources.

#
# General files
#
PRODUCT_COPY_FILES += \
    device/marco_tulio/MarcoTulioOS/shared/config/audio_policy.conf:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy.conf \
    device/marco_tulio/MarcoTulioOS/shared/config/camera_v3.json:$(TARGET_COPY_OUT_VENDOR)/etc/config/camera.json \
    device/marco_tulio/MarcoTulioOS/shared/config/init.vendor.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.cutf_cvm.rc \
    device/marco_tulio/MarcoTulioOS/shared/config/init.product.rc:$(TARGET_COPY_OUT_PRODUCT)/etc/init/init.rc \
    device/marco_tulio/MarcoTulioOS/shared/config/ueventd.rc:$(TARGET_COPY_OUT_VENDOR)/ueventd.rc \
    device/marco_tulio/MarcoTulioOS/shared/config/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
    device/marco_tulio/MarcoTulioOS/shared/config/media_codecs_google_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_video.xml \
    device/marco_tulio/MarcoTulioOS/shared/config/media_codecs_performance.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance.xml \
    device/marco_tulio/MarcoTulioOS/shared/config/media_profiles.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_V1_0.xml \
    device/marco_tulio/MarcoTulioOS/shared/permissions/cuttlefish_excluded_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/cuttlefish_excluded_hardware.xml \
    frameworks/av/media/libeffects/data/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_telephony.xml \
    frameworks/av/services/audiopolicy/config/audio_policy_configuration_generic.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/primary_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/primary_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.full.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.full.xml \
    frameworks/native/data/etc/android.hardware.camera.raw.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.raw.xml \
    frameworks/native/data/etc/android.hardware.ethernet.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.ethernet.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.sensor.ambient_temperature.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.ambient_temperature.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.sip.voip.xml \
    system/bt/vendor_libs/test_vendor_lib/data/controller_properties.json:vendor/etc/bluetooth/controller_properties.json \

#
# The fstab requires special handling. For system-as-root builds, we *must*
# retrieve the vendor partition mount options from DTB, as system must be
# "pristine" to support GSI.
#
PRODUCT_COPY_FILES += \
    device/marco_tulio/MarcoTulioOS/shared/config/fstab:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.cutf_cvm \

# Packages for HAL implementations

#
# Hardware Composer HAL
#
PRODUCT_PACKAGES += \
    hwcomposer.drm_minigbm \
    hwcomposer.cutf_cvm_ashmem \
    hwcomposer-stats \
    android.hardware.graphics.composer@2.2-impl \
    android.hardware.graphics.composer@2.2-service

#
# Gralloc HAL
#
PRODUCT_PACKAGES += \
    gralloc.minigbm \
    gralloc.cutf_ashmem \
    android.hardware.graphics.mapper@2.0-impl-2.1 \
    android.hardware.graphics.allocator@2.0-impl \
    android.hardware.graphics.allocator@2.0-service

#
# Bluetooth HAL and Compatibility Bluetooth library (for older revs).
#
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.0-service.sim \
    android.hardware.bluetooth.a2dp@1.0-impl


#
# Audio HAL
#
PRODUCT_PACKAGES += \
    audio.primary.cutf \
    audio.r_submix.default \
    android.hardware.audio@4.0-impl:32 \
    android.hardware.audio.effect@4.0-impl:32 \
    android.hardware.audio@2.0-service \
    android.hardware.soundtrigger@2.0-impl \

#
# Drm HAL
#
PRODUCT_PACKAGES += \
    android.hardware.drm@1.0-impl \
    android.hardware.drm@1.0-service \
    android.hardware.drm@1.1-service.clearkey

#
# Dumpstate HAL
#
PRODUCT_PACKAGES += \
    android.hardware.dumpstate@1.0-service.cuttlefish

#
# Camera
#
PRODUCT_PACKAGES += \
    camera.cutf \
    camera.cutf.jpeg \
    camera.device@3.2-impl \
    android.hardware.camera.provider@2.4-impl \
    android.hardware.camera.provider@2.4-service

#
# Gatekeeper
#
PRODUCT_PACKAGES += \
    gatekeeper.cutf \
    android.hardware.gatekeeper@1.0-impl \
    android.hardware.gatekeeper@1.0-service

#
# GPS
#
PRODUCT_PACKAGES += \
    gps.cutf \
    android.hardware.gnss@1.0-impl \
    android.hardware.gnss@1.0-service

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.0-service.cuttlefish

#
# Sensors
#
PRODUCT_PACKAGES += \
    sensors.cutf \
    android.hardware.sensors@1.0-impl \
    android.hardware.sensors@1.0-service

#
# Lights
#
PRODUCT_PACKAGES += \
    lights.cutf \
    android.hardware.light@2.0-impl \
    android.hardware.light@2.0-service

#
# Keymaster HAL
#
PRODUCT_PACKAGES += \
     android.hardware.keymaster@4.0-impl \
     android.hardware.keymaster@4.0-service

#
# Power HAL
#
PRODUCT_PACKAGES += \
    android.hardware.power@1.0-impl \
    android.hardware.power@1.0-service

#
# NeuralNetworks HAL
#
PRODUCT_PACKAGES += \
    android.hardware.neuralnetworks@1.1-service-sample-all \
    android.hardware.neuralnetworks@1.1-service-sample-float-fast \
    android.hardware.neuralnetworks@1.1-service-sample-float-slow \
    android.hardware.neuralnetworks@1.1-service-sample-minimal \
    android.hardware.neuralnetworks@1.1-service-sample-quant

#
# USB
PRODUCT_PACKAGES += \
    android.hardware.usb@1.0-service

# TODO vibrator HAL
# TODO thermal

# BootControl HAL
PRODUCT_PACKAGES += \
    bootctrl.bcb \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-impl.recovery \
    android.hardware.boot@1.0-service

PRODUCT_PACKAGES += \
    cuttlefish_dtb

# WLAN driver configuration files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/wpa_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_supplicant_overlay.conf

# Recovery mode
ifneq ($(TARGET_NO_RECOVERY),true)

PRODUCT_COPY_FILES += \
    device/marco_tulio/MarcoTulioOS/shared/config/init.recovery.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.cutf_cvm.rc \

endif

# Host packages to install
PRODUCT_HOST_PACKAGES += socket_vsock_proxy
