LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional

LOCAL_SRC_FILES := \
	Exynos_OMX_Mpeg2dec.c \
	library_register.c

LOCAL_PRELINK_MODULE := false
LOCAL_MODULE := libOMX.Exynos.MPEG2.Decoder
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/omx

LOCAL_CFLAGS :=

ifeq ($(BOARD_USE_ANB), true)
LOCAL_CFLAGS += -DUSE_ANB
endif

ifeq ($(BOARD_USE_DMA_BUF), true)
LOCAL_CFLAGS += -DUSE_DMA_BUF
endif

ifeq ($(BOARD_USE_CSC_HW), true)
LOCAL_CFLAGS += -DUSE_CSC_HW
endif

ifeq ($(BOARD_USE_QOS_CTRL), true)
LOCAL_CFLAGS += -DUSE_QOS_CTRL
endif

ifeq ($(BOARD_USE_DUALDPB_MODE), true)
LOCAL_CFLAGS += -DUSE_DUALDPB_MODE
endif

LOCAL_ARM_MODE := arm

LOCAL_STATIC_LIBRARIES := libExynosOMX_Vdec libExynosOMX_OSAL libExynosOMX_Basecomponent \
	libswconverter libExynosVideoApi
LOCAL_SHARED_LIBRARIES := libc libdl libcutils libutils libui \
	libExynosOMX_Resourcemanager libcsc libexynosv4l2 libion_exynos
ifeq ($(TARGET_BOARD_PLATFORM),exynos5)
LOCAL_SHARED_LIBRARIES += libexynosgscaler
endif

LOCAL_C_INCLUDES := \
	$(EXYNOS_OMX_INC)/exynos \
	$(EXYNOS_OMX_TOP)/osal \
	$(EXYNOS_OMX_TOP)/core \
	$(EXYNOS_OMX_COMPONENT)/common \
	$(EXYNOS_OMX_COMPONENT)/video/dec \
	$(EXYNOS_VIDEO_CODEC)/v4l2/include \
	$(TOP)/hardware/samsung_slsi/exynos/include \
	$(TOP)/hardware/samsung_slsi/$(TARGET_BOARD_PLATFORM)-insignal/include

ifeq ($(BOARD_USE_KHRONOS_OMX_HEADER), true)
LOCAL_CFLAGS += -DUSE_KHRONOS_OMX_HEADER
LOCAL_C_INCLUDES += $(EXYNOS_OMX_INC)/khronos
else
LOCAL_C_INCLUDES += $(ANDROID_MEDIA_INC)/openmax
endif

include $(BUILD_SHARED_LIBRARY)
