Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39352 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbeJBVWB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Oct 2018 17:22:01 -0400
From: Song Qiang <songqiang1304521@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        himanshujha199640@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Song Qiang <songqiang1304521@gmail.com>
Subject: [PATCH v3 0/3] Add  support for PNI RM3100 magnetometer
Date: Tue,  2 Oct 2018 22:38:09 +0800
Message-Id: <20181002143812.3661-1-songqiang1304521@gmail.com>
In-Reply-To: <20180925031724.21399-1-songqiang1304521@gmail.com>
References: <20180925031724.21399-1-songqiang1304521@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

The next 3 patches do the following:
 - The first patch adds PNI Sensor Corporation to the vendor prefix list.
 - The second patch adds devicetree binding for RM3100 magnetometer.
 - The third patch adds the driver for RM3100 magnetometer.

 -- Song Qiang

Changes in v3:
 - Change PNI to PNI Sensor Corporation in vendor-prefix.txt.
 - Sort header files in alpabetical order.
 - Add more specific doc for the mutex.
 - Fix the bug in the rm3100_set_cycle_count() where we always set the
   cycle count value to 100 no matter what val is.
 - Change some multiple else if to switch.
 - Remove iio_device_release_direct_mode() in the case claim direct mode
   fails.
 - Use the same buffer in rm3100_trigger_handler().
 - Add space around some operators.
 - Add manually unwind functions in case devm_add_action() fails.
 - Move devm_add_action before the devm_iio_device_register().
 - Move register defines and rm3100_data struct to *-core.c. 
 - Change some storage variable type of regmap from int to unsigned int.
 - Change 10e4 to 10^4.
 - Remove explicit cast of data pointer in rm3100_remove().
 - Remve dev in rm3100_data and use regmap_get_device() to obtain device
   pointer instead.
 - Change register bits alignment in defines.
 - Move RM3100_SCAN_BYTES to the top.
 - Change Channel endieness from LE to BE.
 - Adjust the place of comment about the 3 second wait time.
 - Some spell check.

Changes in v2:
	- Add scale channel.
	- Add EXPORT_SYMBOL_GPL() to export regmap confuguration structures.
	- Add sampling frequency available attribute.
	- Clean up headers and License declarations.
	- Change axis number to 3.
	- Remove bus specific part in compatible string.
	- Remove le32_to_cpu().
	- Check cycle count registers at *_probe().
	- Format comments.
	- Spell check.
	- Change prefix from RM_* to RM3100_*.
	- Check all error return paths.
	- Add devm_add_action() to avoid race condition when remove.

Song Qiang (3):
  dt-bindings: Add PNI to the vendor prefixes.
  dt-bindings: Add PNI RM3100 device tree binding.
  iio: magnetometer: Add driver support for PNI RM3100

 .../bindings/iio/magnetometer/pni,rm3100.txt  |  20 +
 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 MAINTAINERS                                   |   7 +
 drivers/iio/magnetometer/Kconfig              |  29 +
 drivers/iio/magnetometer/Makefile             |   4 +
 drivers/iio/magnetometer/rm3100-core.c        | 539 ++++++++++++++++++
 drivers/iio/magnetometer/rm3100-i2c.c         |  58 ++
 drivers/iio/magnetometer/rm3100-spi.c         |  64 +++
 drivers/iio/magnetometer/rm3100.h             |  17 +
 9 files changed, 739 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
 create mode 100644 drivers/iio/magnetometer/rm3100-core.c
 create mode 100644 drivers/iio/magnetometer/rm3100-i2c.c
 create mode 100644 drivers/iio/magnetometer/rm3100-spi.c
 create mode 100644 drivers/iio/magnetometer/rm3100.h

-- 
2.17.1
