Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:53300 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754176AbcGZHob (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jul 2016 03:44:31 -0400
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: jdelvare@suse.com, linux@roeck-us.net, jic23@kernel.org,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	maxime.ripard@free-electrons.com, wens@csie.org,
	lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	thomas.petazzoni@free-electrons.com,
	antoine.tenart@free-electrons.com
Subject: [PATCH v3 0/4] add support for Allwinner SoCs ADC
Date: Tue, 26 Jul 2016 09:43:43 +0200
Message-Id: <1469519027-11387-1-git-send-email-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The Allwinner SoCs all have an ADC that can also act as a touchscreen
controller and a thermal sensor. The first four channels can be used either
for the ADC or the touchscreen and the fifth channel is used for the
thermal sensor. We currently have a driver for the two latter functions in
drivers/input/touchscreen/sun4i-ts.c but we don't have access to the ADC
feature at all. It is meant to replace the current driver by using MFD and
subdrivers.

This adds initial support for Allwinner SoCs ADC with all features. Yet,
the touchscreen is not implemented but will be added later. To switch
between touchscreen and ADC modes, you need to poke a few bits in registers
and (de)activate an interrupt (pen-up).
An MFD is provided to let the input driver activate the pen-up interrupt
through a virtual interrupt, poke a few bits via regmap and read data from
the ADC driver while both (and iio_hwmon) are probed by the MFD.

There are slight variations between the different SoCs ADC like the address
of some registers and the scale and offset to apply to raw thermal sensor
values. These variations are handled by using different platform_device_id,
passed to the sub-drivers when they are probed by the MFD.

Currently when no iio channel is found, the probing of iio-hwmon fails.
This is problematic when iio-hwmon probes before the iio driver could
register iio channels to share. Thus, this modifies iio-hwmon to probe late
with late_initcall making sure all drivers which provides iio channels have
probed before iio_hwmon.

When an MFD cell has an of_compatible (meaning it is present in the Device
Tree), other nodes can reference it using a phandle.
However when the MFD cell is not declared in the Device Tree, the only way
other nodes can reference it are by using a phandle to the MFD. Then when
this MFD cell tries to register itself in one framework, the registration
is denied by the framework because it is not matching the of_node of the
node which is referenced by the phandle in one of the other nodes.
This reattaches the of_node of the MFD to the MFD cell device structure
when the MFD cell has no of_compatible.
We need this modification to register the thermal sensor in the thermal
framework.

Removal of proposed patch for iio_hwmon's iio channel's label in v3. The
patch induces irreversible ABI changes and will be handled as a separate
patch since I think it is not absolutely necessary to have labels yet in
iio_hwmon.

Quentin Schulz (4):
  hwmon: iio_hwmon: delay probing with late_initcall
  mfd: add support for Allwinner SoCs ADC
  mfd: mfd-core: reattach mfd of_node to cells without of_compatible
  iio: adc: add support for Allwinner SoCs ADC

 drivers/hwmon/iio_hwmon.c           |  16 +-
 drivers/iio/adc/Kconfig             |  12 +
 drivers/iio/adc/Makefile            |   1 +
 drivers/iio/adc/sunxi-gpadc-iio.c   | 513 ++++++++++++++++++++++++++++++++++++
 drivers/mfd/Kconfig                 |  15 ++
 drivers/mfd/Makefile                |   2 +
 drivers/mfd/mfd-core.c              |  14 +-
 drivers/mfd/sunxi-gpadc-mfd.c       | 189 +++++++++++++
 include/linux/mfd/sunxi-gpadc-mfd.h |  94 +++++++
 9 files changed, 850 insertions(+), 6 deletions(-)
 create mode 100644 drivers/iio/adc/sunxi-gpadc-iio.c
 create mode 100644 drivers/mfd/sunxi-gpadc-mfd.c
 create mode 100644 include/linux/mfd/sunxi-gpadc-mfd.h

-- 
2.5.0

