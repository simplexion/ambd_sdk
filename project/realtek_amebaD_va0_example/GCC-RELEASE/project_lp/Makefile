.PHONY: all clean flash debug setup

THIS_MAKEFILE := $(lastword $(MAKEFILE_LIST))
ASDK := $(patsubst %Makefile,%,$(THIS_MAKEFILE))asdk

ifneq ($(SRCDIR),)
MAKE_ARGS += "SRCDIR=$(SRCDIR)"
endif
ifneq ($(INCDIR),)
MAKE_ARGS += "INCDIR=$(INCDIR)"
endif
ifneq ($(CONFIGDIR),)
MAKE_ARGS += "CONFIGDIR=$(CONFIGDIR)"
endif

include $(ASDK)/config/.config

#*****************************************************************************#
#                               Object FILE LIST                              #
#*****************************************************************************#
OBJS = 

#*****************************************************************************#
#                        RULES TO GENERATE TARGETS                            #
#*****************************************************************************#

# Define the Rules to build the core targets
all: CORE_TARGETS
	#make -C $(ASDK) $(MAKE_ARGS) flashloader
	make -C $(ASDK) $(MAKE_ARGS) bootloader
ifeq ($(CONFIG_USER_CTRL_PS),y)
	make -C $(ASDK) $(MAKE_ARGS) ucps_image2
else
	make -C $(ASDK) $(MAKE_ARGS) image2
endif
	
rom2: CORE_TARGETS
	make -C $(ASDK) $(MAKE_ARGS) rom2

setup:
	make -C $(ASDK) $(MAKE_ARGS) $(MAKECMDGOALS)

flash:
	make -C $(ASDK) $(MAKE_ARGS) gdb

debug:
	make -C $(ASDK) $(MAKE_ARGS) debug
	
xip: CORE_TARGETS
	make -C $(ASDK) $(MAKE_ARGS) lib_all
	make -C $(ASDK) $(MAKE_ARGS) flashloader
	make -C $(ASDK) $(MAKE_ARGS) bootloader
ifeq ($(CONFIG_USER_CTRL_PS),y)
	make -C $(ASDK) $(MAKE_ARGS) ucps_image2
else
	make -C $(ASDK) $(MAKE_ARGS) image2
endif

rom_debug_if_need: CORE_TARGETS
	make -C $(ASDK) $(MAKE_ARGS) rom
	make -C $(ASDK) $(MAKE_ARGS) copy_rom

imgtool_flashloader:
	make -C $(ASDK) $(MAKE_ARGS) imgtool_flashloader

clean: CORE_TARGETS
	make -C $(ASDK) $(MAKE_ARGS) clean

clean_all: CORE_TARGETS
	#make -C $(ASDK) $(MAKE_ARGS) clean_rom
	make -C $(ASDK) $(MAKE_ARGS) clean_all

menuconfig: CORE_TARGETS
	make -C $(ASDK) $(MAKE_ARGS) menuconfig

gdb: CORE_TARGETS
	make -C $(ASDK) $(MAKE_ARGS) gdb #step2: load flash if need
	#please use tools\AmebaZ\Image Tool!!!!!!!!!!!!!!!!!!
	#user guide: WS_20160928_WLAN5_AmebaZ_Image_Tool_User_Guide_1v0

gdbloadrom: CORE_TARGETS
	make -C $(ASDK) $(MAKE_ARGS) gdbloadrom #step1: load rom if need

swdpwd: CORE_TARGETS
	make -C $(ASDK) $(MAKE_ARGS) swdpwd

#image2: CORE_TARGETS
#	make -C $(ASDK) $(MAKE_ARGS) image2
#
#bootloader: CORE_TARGETS
#	make -C $(ASDK) $(MAKE_ARGS) bootloader
#
#flashloader:
#	make -C $(ASDK) $(MAKE_ARGS) flashloader
#
#
#gdbboot: CORE_TARGETS
#	make -C $(ASDK) $(MAKE_ARGS) gdbboot #boot from RAM
#
#gdbbootxip: CORE_TARGETS
#	make -C $(ASDK) $(MAKE_ARGS) gdbbootxip #step3: boot from flash
#*****************************************************************************#
#              GENERATE OBJECT FILE 
#*****************************************************************************#
CORE_TARGETS: $(OBJS)

