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

$(call inherit-product, device/marco_tulio/MarcoTulioOS/shared/phone/device.mk)
$(call inherit-product, device/marco_tulio/MarcoTulioOS/vsoc_x86/device.mk)

# Exclude features that are not available on AOSP devices.
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/aosp_excluded_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/aosp_excluded_hardware.xml

PRODUCT_NAME := aosp_cf_marcotulio_os_x86_phone
PRODUCT_DEVICE := vsoc_x86
PRODUCT_MODEL := Marco Tulio's Cuttlefish x86 phone
PRODUCT_PACKAGE_OVERLAYS := device/marco_tulio/MarcoTulioOS/vsoc_x86/phone/overlay
