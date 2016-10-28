Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:50742 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758203AbcJ1KA1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 28 Oct 2016 06:00:27 -0400
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, Mark.Rutland@arm.com
Subject: [PATCH 00/10] staging: iio: tsl2583: staging cleanups
Date: Fri, 28 Oct 2016 06:00:11 -0400
Message-Id: <1477648821-3786-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch set begins cleaning up some of the major items that is
keeping the tsl2583 driver out of mainline. Highlights include device
tree support, converts the driver over to use the iio_chan_spec,
improved error handling, and fixes for some concurrency issues. There
is more work required to get this driver out of staging that I will
send later as a separate patch set.

Driver was tested using a TSL2581 hooked up to a Raspberry Pi 2.

The sysfs attributes were previously prefixed with illuminance0_ however
they are now prefixed with in_illuminance_. None of the IIO light
drivers in mainline have their sysfs attributes prefixed with
illuminance0_, however 8 of the IIO light drivers in mainline use the
in_illuminance_ prefix so I assume that this is the naming convention
that should be used for this driver as well.

sysfs attribute names before this patch set:

raspberrypi:/sys/bus/iio/devices/iio:device0$ ls -l
total 0
-r--r--r-- 1 root root 4096 Oct 27 20:27 dev
-rw-r--r-- 1 root root 4096 Oct 27 20:27 illuminance0_calibbias
--w------- 1 root root 4096 Oct 27 20:27 illuminance0_calibrate
-rw-r--r-- 1 root root 4096 Oct 27 20:27 illuminance0_calibscale
-r--r--r-- 1 root root 4096 Oct 27 20:27 illuminance0_calibscale_available
-r--r--r-- 1 root root 4096 Oct 27 20:27 illuminance0_input
-rw-r--r-- 1 root root 4096 Oct 27 20:27 illuminance0_input_target
-rw-r--r-- 1 root root 4096 Oct 27 20:27 illuminance0_integration_time
-r--r--r-- 1 root root 4096 Oct 27 20:27 illuminance0_integration_time_available
-rw-r--r-- 1 root root 4096 Oct 27 20:27 illuminance0_lux_table
-r--r--r-- 1 root root 4096 Oct 27 20:27 name
lrwxrwxrwx 1 root root    0 Oct 27 20:27 of_node ->
 ../../../../../../../firmware/devicetree/base/soc/i2c@7e804000/tsl2581@29/
drwxr-xr-x 2 root root    0 Oct 27 20:27 power/
-rw-r--r-- 1 root root 4096 Oct 27 20:27 power_state
lrwxrwxrwx 1 root root    0 Oct 27 20:27 subsystem -> ../../../../../../../bus/iio/
-rw-r--r-- 1 root root 4096 Oct 27 20:27 uevent

sysfs attribute names after this patch set:

raspberrypi:/sys/bus/iio/devices/iio:device0$ ls -l
total 0
-r--r--r-- 1 root root 4096 Oct 27 22:29 dev
-rw-r--r-- 1 root root 4096 Oct 27 22:29 in_illuminance_both_raw
-rw-r--r-- 1 root root 4096 Oct 27 22:29 in_illuminance_calibbias
--w------- 1 root root 4096 Oct 27 22:29 in_illuminance_calibrate
-rw-r--r-- 1 root root 4096 Oct 27 22:29 in_illuminance_calibscale
-r--r--r-- 1 root root 4096 Oct 27 22:29 in_illuminance_calibscale_available
-rw-r--r-- 1 root root 4096 Oct 27 22:29 in_illuminance_input
-rw-r--r-- 1 root root 4096 Oct 27 22:29 in_illuminance_input_target
-rw-r--r-- 1 root root 4096 Oct 27 22:29 in_illuminance_integration_time
-r--r--r-- 1 root root 4096 Oct 27 22:29 in_illuminance_integration_time_available
-rw-r--r-- 1 root root 4096 Oct 27 22:29 in_illuminance_ir_raw
-rw-r--r-- 1 root root 4096 Oct 27 22:29 in_illuminance_lux_table
-r--r--r-- 1 root root 4096 Oct 27 22:29 name
lrwxrwxrwx 1 root root    0 Oct 27 22:29 of_node ->
 ../../../../../../../firmware/devicetree/base/soc/i2c@7e804000/tsl2581@29/
drwxr-xr-x 2 root root    0 Oct 27 22:29 power/
lrwxrwxrwx 1 root root    0 Oct 27 22:29 subsystem ->
 ../../../../../../../bus/iio/
-rw-r--r-- 1 root root 4096 Oct 27 22:23 uevent

Brian Masney (10):
  staging: iio: tsl2583: add of_match table for device tree support
  staging: iio: tsl2583: check for error code from i2c_smbus_read_byte()
  staging: iio: tsl2583: return proper error code instead of -1
  staging: iio: tsl2583: remove redundant power_state sysfs attribute
  staging: iio: tsl2583: check return values from taos_chip_{on,off}
  staging: iio: tsl2583: convert to use iio_chan_spec and
    {read,write}_raw
  staging: iio: tsl2583: convert illuminance0_calibscale sysfs attr to
    use iio_chan_spec
  staging: iio: tsl2583: use IIO_*_ATTR* macros to create sysfs entries
  staging: iio: tsl2583: add error code to sysfs store functions
  staging: iio: tsl2583: add locking to sysfs attributes

 .../devicetree/bindings/iio/light/tsl2583.txt      |  26 ++
 drivers/staging/iio/light/tsl2583.c                | 509 +++++++++++----------
 2 files changed, 288 insertions(+), 247 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/tsl2583.txt

-- 
2.7.4

