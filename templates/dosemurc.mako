# CPU shown to DOS, valid values:  "80[23456]86"
# Default: 80586

# $_cpu = "80586"

# Usage of cpu emulation: "off" (default on x86),
# "vm86" only (default on x86-64) or "full" (vm86 and DPMI, experimental!).
# Use "vm86sim" or "fullsim" to use simulation instead of JIT code generation.

# $_cpu_emu = "off"

# if possible use Pentium cycle counter for timing. Default: off

# $_rdtsc = (off)

# CPU speed, used in conjunction with the TSC
# Default 0 = calibrated by dosemu, else given (e.g.166.666)

# $_cpuspeed = (0)

# emulated FPU, (off) or (on), default = (on)

# $_mathco = (on)

# 0 = all CPU power to DOSEMU; default = 1 = nicest, then higher:more CPU power

# $_hogthreshold = (1)

##############################################################################
## Disk and file system settings

# List of hdimages or boot directories under
# ~/.dosemu, the system config directory (/etc/dosemu by default), or
# syshdimagedir (/var/lib/dosemu by default) assigned in this order
# such as "hdimage_c directory_d hdimage_e"
# Absolute pathnames are also allowed.
# If the name begins with '/dev/', then wholedisk or partition access is
# done instead of a virtual hdimage such as "/dev/hda", "/dev/hda1" or
# "/dev/hda1:ro" for readonly
# Currently mounted devices and swap are refused. Hdimages and devices may
# be mixed such as "hdimage_c /dev/hda1 /dev/hda3:ro". Default: "drives/*"

$_hdimage = "${nodedir}/drives/*"

# if you want to boot from a virtual floppy:
# file name of the floppy image under DOSEMU_LIB_DIR
# e.g. "floppyimage" disables $_hdimage
#      "floppyimage +hd" does _not_ disable $_hdimage. Default: ""

# $_vbootfloppy = ""

# floppy drive types: "threeinch" or "fiveinch" or "atapi" or empty,
# if non-existant. Optionally the device may be appended such as
# "threeinch:/dev/fd0". Default: "threeinch" for A:, "" for B:

# $_floppy_a = "threeinch"
# $_floppy_b = ""

# List of CDROM devices. Up to 4 are supported. You may also specify
# image files. You need to load cdrom.sys and mscdex/nwcdex/shsucdx.exe.
# Default: "/dev/cdrom"

$_cdrom = ""

# list of generic SCSI devices to make available for the builtin aspi driver
# (format of an entry is 'device:type:mappedtarget' such as
# "sg2:WORM sg3:Sequential-Access:6 sg4:CD-ROM" or
# "sg2:4 sg3:1:6 sg4:5" (which are equal). Default: ""

# $_aspi = ""

# whether to lock the full file on lredired drives for file locking requests
# or just one byte

# $_full_file_locks = (off)

# enable/disable long filename support for lredired drives;
# default: on

# $_lfn_support = (on)

# config.sys   -> config.XXX; default="" or 3 char.,

# $_emusys = ""

# system.ini   -> system.XXX; default="" or 3 char., (for Windows 3.x)

# $_emuini = ""

##############################################################################
## Memory settings

# conventional DOS memory size, in Kbytes, <= 768.
# Default: 640

# $_dosmem = (640)

# Extended Memory size. This memory is accessible via int15h and can be
# used by himem.sys and the internal XMS driver.
# Default: 8192

# $_xms = (8192)

# EMS (expanded memory) size in Kbytes;
# Warning: disabling EMS (off) is not recommended. Doing so will
# give you the additional 64K of UMB space, but as a side-effect
# it will also disable the protected mode DOS API translator,
# making many protected-mode apps to crash.
# Default: 8192

# $_ems = (8192)

# DOS segment in UMA where the EMS frame is put.
# Default: 0xe400

# $_ems_frame = (0xe400)

# the amount of EMS-mappable pages in UMA.
# Possible values: 0 to 12
# Default: 4

# $_ems_uma_pages = (4)

# the amount of EMS-mappable pages in conventional memory.
# Possible values: 0 to 24
# Default: 24

# $_ems_conv_pages = (24)

# DPMI memory size in Kbytes; default: 0x5000

# $_dpmi = (0x5000)

# DPMI base address; default: auto
# If the default value fails, try 0x10000000

# $_dpmi_base = (auto)

# Some DJGPP-compiled programs have the NULL pointer dereference bugs.
# They can work under Windows or QDPMI, but will crash under dosemu,
# because dosemu detects that kind of errors in DJGPP-based programs.
# If your program crashes with the "SIGSEGV" message, then enabling
# this option will likely to help.

# $_ignore_djgpp_null_derefs = (0)

# preferred mapping driver, one of: auto, mapshm, mapashm, mapfile
# Default: ""="auto"

# $_mapping= ""

##############################################################################
## Debug settings

# debug switches; same format as -D commandline option, default: ""="-a+cw".
# (but without the -D in front), normally written to ~/.dosemu/boot.log

# $_debug = "-a+cw"

# which i/o ports to trace (only displayed if you also use -D+T)
# see $_ports below for the syntax

# $_trace_ports = ""

##############################################################################
## Dosemu-specific hacks

# choose the time source for the RTC emulation. Possible values:
# "pit", "bios" and "linux". The "linux" time source will follow
# the system time changes, but it doesn't allow to set the time
# from DOS. "bios" time source is monotonous (will not follow
# the system time changes), but allows you to set time from DOS.

$_timemode = "linux"

# set this to some positive value (eg. Default: 10)
# if you want to play Doom or Duke3D with sound.

# $_cli_timeout = (10)

# try setting this to some lower positive value (eg. 5; default: 50)
# if you get problems with some DOS program
# freezing after some time.

# $_pic_watchdog = (50)

# list of temporary hacks, see release notes in the file ChangeLog.
# e.g "0:1 2:0", which means to set feature_0 to 1 and feature_2 to 0.
# Default: ""

# $_features= ""

##############################################################################
## Terminal related settings

# Character set used externally to dosemu
# Default: "" == use the character set from the locale or else:
# "cp437", "cp737", "cp773", "cp775", "cp850", "cp852", "cp857", "cp860",
# "cp861", "cp862", "cp863", "cp864", "cp865", "cp866", "cp869", "cp874",
# "cp1125", "cp1251"
# "iso8859-1", "iso8859-2", "iso8859-3", "iso8859-4", "iso8859-5", "iso8859-6",
# "iso8859-7", "iso8859-8", "iso8859_9", "iso8859-14", "iso8859-15", "koi8-r"
# "koi8-u", "koi8-ru", "utf8"

# $_external_char_set = ""

# Character set used by dos programs
# Default: "" == use "cp437" or else:
# "cp437", "cp737", "cp773", "cp775", "cp850", "cp852", "cp857", "cp860",
# "cp861", "cp862", "cp863", "cp864", "cp865", "cp866", "cp869", "cp874",
# "cp895", "cp1125", "cp1251", "bg-mik"

# $_internal_char_set = ""

# terminal with color support. Default: (on)

# $_term_color = (on)

# time between refreshes (units: 20 == 1 second). Default: 4

# $_term_updfreq = (4)

# xterm, putty and compatibles window title. Default: %s - DOSEMU
# where %s is the DOS program's name. Use "" to not change the title

$_xterm_title = ""

# Video adapter style used: one of: vga, ega, mda, mga, cga, none
# Default: "vga"; none=dumb terminal mode.

# $_video = "vga"

##############################################################################
## Keyboard related settings

# Keyboard layout: default: 'auto' (which tries to generate the table from
# the current Linux console settings)
# or one of: finnish(-latin1), de(-latin1), be, it, us, uk, dk(-latin1),
# keyb-no, no-latin1, dvorak, pl, po, sg(-latin1), fr(-latin1), sf(-latin1),
# es(-latin1), sw, hu(-latin2), hu-cwi, keyb-user, hr-cp852, hr-latin2,
# cz-qwerty, cz-qwertz, ru, tr.

$_layout = "us"

# bypass normal keyboard input on the Linux console, maybe dangerous
# default: (auto), use only with -s or -k, or (0): off, use -k, or (1): on.

# $_rawkeyboard = (0)

# 30 == Ctrl-^ (Ctrl-6 on US keyboards), special-sequence prefix for terminals
# use Ctrl-^ h for help

# $_escchar = (30)

##############################################################################
## Mouse settings

# Use internal mouse driver. Default = (on).

# $_mouse_internal = (on)

## ** Below mouse settings are IGNORED for any DOSEMU session except at the
## ** Linux console using suid/sudo/root, the -s switch, and $_graphics=(1).

# Mouse protocol: one of (microsoft, mousesystems, logitech, mmseries,
# mouseman, hitachi, busmouse, ps2, imps2).
# Default: "microsoft"

# $_mouse = "microsoft"

# Mouse device: if you want to use the internal mouse driver, you can give
# the real mouse device such as "/dev/input/mice", "/dev/mouse", "/dev/psaux"
# (for PS/2), or "/dev/gpmdata" (for GPM repeater usage).
# if you intend to use a DOS serial mouse driver instead, then set this to
# one of "com1", "com2", "com3", "com4", and the internal mouse driver will
# be disabled.
# The default "" means: do not read the mouse device directly (no mouse in
# console "$_graphics=(1)" mode, but GPM can still be used in other modes).

# $_mouse_dev = ""

# Default: "" or one or more of: "emulate3buttons cleardtr"

# $_mouse_flags = ""

# baudrate, default: 0 == don't set

# $_mouse_baud = (0)

##############################################################################
## Joystick config

# 1st and 2nd joystick device
# e.g. "/dev/js0" or default: "/dev/js0 /dev/js1"
#      (or "" if you don't want joystick support)

$_joy_device = ""

# range for joystick axis readings, must be > 0, default: 1

# $_joy_dos_min = (1)

# avoid setting the maximum to > 250, default: 150

# $_joy_dos_max = (150)

# the higher, the less sensitive - useful if you have a wobbly joystick.
# default: 1

# $_joy_granularity = (1)

# delay between nonblocking linux joystick reads increases performance if >0
# and processor>=Pentium recommended: 1-50ms or 0 if unsure. default: 1

# $_joy_latency = (1)

##############################################################################
## Serial port settings

# use e.g. "/dev/mouse", "/dev/ttyS0", "/dev/ttyS1", ...
#
# All "/dev/ttyXX" may be suffixed by the IRQ
# used (instead of the default one), such as "/dev/ttyS2 irq 5"
# or "/dev/ttyS3 irq 9".
#
# "low_latency" keyword may be used to switch the uart into a low_latency
# mode. This may be needed for the software flow control (XOFF) to work right.
# It is not supported by most uart drivers and slows down the transfer.
#
# "pseudo" keyword may be used to force the pseudo-TTY mode.
# A wrong but quick way to bypass the hardware flow control.
#
# "rtscts" keyword may be used as a wrong but quick way to enforce the
# hardware flow control.
#
# "virtual" keyword may be used to redirect the COM port to the terminal.
# A wrong but quick way for the sysop to play his BBS door games locally.
#
# Default: ""

$_com1 = "${modem_path}"
# $_com2 = ""
# $_com3 = ""
# $_com4 = ""

# $_com5 = ""
# $_com6 = ""
# $_com7 = ""
# $_com8 = ""
# $_com9 = ""
# $_com10 = ""
# $_com11 = ""
# $_com12 = ""
# $_com13 = ""
# $_com14 = ""
# $_com15 = ""
# $_com16 = ""

# tty lock directory. Empty string "" means no tty locks.
# default: "/var/lock"

$_ttylocks = ""

##############################################################################
## Printer and parallel port settings

# Print commands to use for LPT1, LPT2 and LPT3.
# Default: "lpr -l", "lpr -l -P lpt2", and "" (disabled)
# Which means: use the default print queue for LPT1, "lpt2" queue for LPT2.
# "-l" means raw printing mode (no preprocessing).

# $_lpt1 = "lpr -l"
# $_lpt2 = "lpr -l -P lpt2"
# $_lpt3 = ""

# idle time in seconds before spooling out. Default: (20)

# $_printer_timeout = (20)

##############################################################################
## Speaker and sound settings

# speaker: default: "emulated", or "native" (console only) or "" (off)

$_speaker = ""

# sound support on/off; use (2) for newer experimental sound code

$_sound = (off)

# (emulated!) Sound Blaster base i/o port, default: (0x220)

# $_sb_base = (0x220)

# Sound Blaster IRQ setting, default: (5)

# $_sb_irq = (5)

# Sound Blaster 8 bit DMA setting, default: (1)

# $_sb_dma = (1)

# Sound Blaster 16 bit DMA setting, default: (5)

# $_sb_hdma = (5)

# Sound device, default: "/dev/dsp"

# $_sb_dsp = "/dev/dsp"

# Sound mixer device, default: ""; use "/dev/mixer" if you allow that dosemu
# changes the volume

# $_sb_mixer = ""

# Midi base i/o port

# $_mpu_base = (0x330)

# The following options are driver-specific and it is not necessary to alter
# the default values in most cases. Read sound-usage.txt for more.
# Defaults: min_frags: 4, max_frags: 0x20, stalled_frags: 2, do_post: off,
# min_extra_frags: 2, dac_freq: 6000.

# $_oss_min_frags = (4)
# $_oss_max_frags = (0x20)
# $_oss_stalled_frags = (2)
# $_oss_do_post = (off)
# $_oss_min_extra_frags = (2)
# $_oss_dac_freq = (6000)

##############################################################################
## Network settings

# Enable built-in Packet Driver. Default: on

# $_pktdriver = (on)

# Virtual networking type. "direct" for direct NIC access, "tap" for
# using the TAP virtual device.
# NOTE: "direct" method needs root privileges.
# Default: "tap"

# $_vnet = "tap"

# Network device for Packet Driver. For direct NIC access mode, can be
# set to, for example, "eth0". For TAP virtual networking mode, should
# be set either explicitly, like "tap0", to bind to an existing TAP
# device, or left blank for dynamic TAP device allocation. Any setting
# that does not start with "tap", is ignored in TAP mode and respected
# only in direct mode.
# Default: "eth0" (which, with the TAP mode being a default, is ignored)

# $_netdev = "eth0"

# use Novell 802.3 hack. Default: off

# $_novell_hack = (off)

# NOTE: IPX needs root privileges unless you setup /proc/net/ipx_route
# in advance.
# Default: (off)

# $_ipxsupport = (off)

# IPX network address to use. One of those listed in /proc/net/ipx/interface.
# Address 0 means use the network to which the primary interface, if exist,
# is attached to.
# Default: 0

# $_ipx_network = (0)

##############################################################################
## Setting specific to the X Window System (xdosemu, dosemu -X)

# time between refreshes (units: 20 == 1 second). Default: 5

# $_X_updfreq = (5)

# Title in the top bar of the window. Default = "DOS in a BOX"

# $_X_title = "DOS in a BOX"

# Show name of running app in the top bar of the window. Default: on

# $_X_title_show_appname = (on)

# Text for icon, when minimized. Default = "xdosemu"

# $_X_icon_name = "xdosemu"

# Start DOSEMU in fullscreen mode. Default = "off"

# $_X_fullscreen = (off)

# on==translate keyboard via dosemu keytables, or 'off' or 'auto'. Default:auto

# $_X_keycode = (auto)

# blink rate for the cursor

# $_X_blinkrate = (12)

# name of the X font that is used (e.g. "vga") default = "" (bitmap fonts)

# $_X_font = ""

# Use shared memory extensions. Faster, but problematic with remote X.
# Default: on

# $_X_mitshm = (on)

# share the colormap with other applications. Default: off

# $_X_sharecmap = (off)

# Set fixed aspect for resizing the graphics window. Default: on

# $_X_fixed_aspect = (on)

# Always use an aspect ratio of 4:3 for graphics. Default: off

# $_X_aspect_43 = (off)

# Use linear filtering for >15 bpp interpolation. Default: off

# $_X_lin_filt = (off)

# Use bi-linear filtering for >15 bpp interpolation. Default: off

# $_X_bilin_filt = (off)

# initial size factor for video mode 0x13 (320x200)

# $_X_mode13fact = (2)

# "x,y" of initial windows size (defaults to ""=float)

# $_X_winsize = ""

# gamma correction. Default: 1.0

# $_X_gamma = (1.0)

# size (in Kbytes) of the frame buffer for emulated vga. Default: 4096

# $_X_vgaemu_memsize = (4096)

# use linear frame buffer in VESA modes. Default: on

# $_X_lfb = (on)

# use protected mode interface for VESA modes. Default: on

# $_X_pm_interface = (on)

# KeySym name to activate mouse grab, ""=off. Default: "Home" (ctrl+alt+home)

# $_X_mgrab_key = "Home"

# List of vesamodes to add. The list has to contain SPACE separated
# "xres,yres" pairs, as follows: "xres,yres ... xres,yres". Default: ""

# $_X_vesamode = ""

# pause xdosemu if it loses focus

# $_X_background_pause = (off)

##############################################################################
## Direct hardware access

# NOTE: the settings below here that are marked [priv] are only valid in
# a system-wide dosemu.conf and cannot be changed by ~/.dosemurc.
# For these settings to take effect, DOSEMU must be run with root privileges;
# run it as root, via sudo, or suid with adjustments in dosemu.users,
# and using the -s switch.

# [priv] list of portnumbers such as "0x1ce 0x1cf 0x238" or
# "0x1ce range 0x280,0x29f 310" or "range 0x1a0,(0x1a0+15)". Default: ""
# $_ports = "device /dev/null fast 0x200"
# $_ports = $_ports, " device /dev/lp0 range 0x378 0x37a"
# The blank is important
# "device" means: if the ports are registered, open this device to block
# access. The open must be successful or access to the ports will be denied.
# If you know what you are doing, use /dev/null to fake a device to block

# $_ports = ""

# [priv] list of IRQ numbers (2-15) to pass to DOS such as "3 8 10".Default: ""
# This does not work on x86-64.

# $_irqpassing = ""

# [priv] DOS memory to map directly: list of segment values/ranges such as

# "0xc8000 range 0xcc000,0xcffff". Default: ""

# $_hardware_ram = ""

# [priv] (on): give access to the PCI configuration space.
# (auto): restricted, mostly emulated access if the video card requires it.
# Default: (auto)

# $_pci = (auto)

##############################################################################
## Console video

# The following settings apply to direct console video only (not in X)
# Many are privileged, and need suid/sudo/root and the -s switch.

# use 'console' video (direct video ram access). Default:
# (auto) -- use only if KMS is not active

# $_console = (auto)

# use the cards BIOS to set graphics and allow direct port i/o. Default:
# (auto) -- use only if KMS is not active

# $_graphics = (auto)

# [priv] run the VGA card's initialization BIOS routine (most cards don't
# need this). Default: (0)

# $_vbios_post = (0)

# [priv] set the address of your VBIOS (e.g. 0xc000, 0xe000).
# Default: (0)=autodetect.

# $_vbios_seg = (0)

# [priv] set the size of your BIOS (e.g. 0x10000, 0x8000).

# Default: (0)=autodetect.

# $_vbios_size = (0)

# [priv] amount in K of (real) video RAM to save/restore
# when switching virtual consoles. (auto) means all video RAM,
# which can take *too* long if you have a lot of the video memory.
# (off) means no video RAM saving.
# Default: 4096

# $_vmemsize = (4096)

# [priv] real chipset: one of: plainvga, trident, et4000, diamond, avance
# cirrus, matrox, wdvga, paradise, ati, s3, sis, svgalib
# these drivers are likely to be out of date for modern cards; "vesa"
# will probably work; if not, try "plainvga". Default: "vesa"

# $_chipset = "vesa"

# [priv] if you have one vga _plus_ one hgc (2 monitors)

# $_dualmon = (0)
