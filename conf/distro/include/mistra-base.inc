require conf/distro/poky.conf

DISTRO = "mistra-base"
DISTRO_NAME = "Mistra Distro Base"
DISTRO_VERSION = "4.0"

SDK_VENDOR = "-mistrasdk"

MAINTAINER = "Strahinja Jankovic <strahinja.p.jankovic@gmail.com>"

TARGET_VENDOR = "-mistra"

DISTROOVERRIDES = "mistra"

ARM_INSTRUCTION_SET:mistra ??= "thumb"

# Log information on images and packages
INHERIT += "buildhistory"
BUILDHISTORY_COMMIT = "1"

