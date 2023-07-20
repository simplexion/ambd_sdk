
.PHONY: all clean flash debug setup mp

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

#*****************************************************************************#
#                               Object FILE LIST                              #
#*****************************************************************************#
OBJS = 

#*****************************************************************************#
#                        RULES TO GENERATE TARGETS                            #
#*****************************************************************************#

# Define the Rules to build the core targets
all: CORE_TARGETS
	make -C $(ASDK) $(MAKE_ARGS) image3_s
	make -C $(ASDK) $(MAKE_ARGS) bootloader
	make -C $(ASDK) $(MAKE_ARGS) image2_ns
	
mp: CORE_TARGETS
	make -C $(ASDK) $(MAKE_ARGS) mp_image3_s
	make -C $(ASDK) $(MAKE_ARGS) bootloader
	make -C $(ASDK) $(MAKE_ARGS) mp_image2_ns
	
image2: CORE_TARGETS
	make -C $(ASDK) $(MAKE_ARGS) image2_ns
	
setup:
	make -C $(ASDK) $(MAKE_ARGS) $(MAKECMDGOALS)

flash:
	make -C $(ASDK) $(MAKE_ARGS) gdb

debug:
	make -C $(ASDK) $(MAKE_ARGS) debug

xip: CORE_TARGETS
	make -C $(ASDK) $(MAKE_ARGS) lib_all
	make -C $(ASDK) $(MAKE_ARGS) image3_s
	make -C $(ASDK) $(MAKE_ARGS) bootloader
	make -C $(ASDK) $(MAKE_ARGS) image2_ns

rom_debug_if_need: CORE_TARGETS
	make -C $(ASDK) $(MAKE_ARGS) rom_ns
	make -C $(ASDK) $(MAKE_ARGS) rom
	make -C $(ASDK) $(MAKE_ARGS) copy_rom

rom2: CORE_TARGETS
	make -C $(ASDK) $(MAKE_ARGS) rom2

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


#not use now
#bootloader: CORE_TARGETS
#	make -C $(ASDK) $(MAKE_ARGS) bootloader
#img2: CORE_TARGETS
#	make -C $(ASDK) $(MAKE_ARGS) image2_ns
#img3: CORE_TARGETS
#	make -C $(ASDK) $(MAKE_ARGS) image3_s
#clean_xip: CORE_TARGETS
#	make -C $(ASDK) $(MAKE_ARGS) clean_xip
#
#gdb_all: CORE_TARGETS
#	make -C $(ASDK) $(MAKE_ARGS) gdb_all
#gdbboot: CORE_TARGETS
#	make -C $(ASDK) $(MAKE_ARGS) gdbboot #boot from RAM
#gdbbootxip: CORE_TARGETS
#	make -C $(ASDK) $(MAKE_ARGS) gdbbootxip #step3: boot from flash
#gdbloadromall: CORE_TARGETS
#	make -C $(ASDK) $(MAKE_ARGS) gdbloadromall #step1: load rom if need
#*****************************************************************************#
#              GENERATE OBJECT FILE 
#*****************************************************************************#
CORE_TARGETS: $(OBJS)

