Return-Path: <quentin.schulz@free-electrons.com>
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: jdelvare@suse.com,
	linux@roeck-us.net,
	jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	maxime.ripard@free-electrons.com,
	wens@csie.org,
	lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
	thomas.petazzoni@free-electrons.com,
	antoine.tenart@free-electrons.com,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 0/3] add support for Allwinner SoCs ADC
Date: Thu,  8 Sep 2016 16:28:34 +0200
Message-Id: <1473344917-1524-1-git-send-email-quentin.schulz@free-electrons.com>
List-ID: <linux-iio@vger.kernel.org>

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

This also modifies iio-hwmon to allow probe deferring when no iio channel
is found. Currently when no iio channel is found, the probing of iio-hwmon
fails. This is problematic when iio-hwmon probes before the iio driver
could register iio channels to share.

Removal of proposed patch for iio_hwmon's iio channel's label in v3. The
patch induces irreversible ABI changes and will be handled as a separate
patch since I think it is not absolutely necessary to have labels yet in
iio_hwmon.

Removal of proposed patch for reattaching of_node of the MFD to the MFD
cell device structure in v3. As Lee Jones said, this patch might cause
"unintended side-effects for existing drivers.". Moreover, this patch
introduced a bug of multiple probe of this MFD driver I haven't identified
yet. This patch aimed at allowing the ADC driver (which is a child of the
MFD and not present in the DT) to register in the thermal framework. The
thermal driver has a phandle to the MFD node which is used to match against
the MFD of_node but since the ADC driver has no node in the DT, could not
register in the thermal framework. The other solution is to "impersonate"
the MFD when registering in the thermal framework since the device is only
used to match the phandle and the of_node, an other structure passed by
parameter being used to compute temperatures.

(in the ADC driver, probed by the MFD driver) instead of:
tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, info,
					   &sun4i_ts_tz_ops);
we now have:
tzd = devm_thermal_zone_of_sensor_register(pdev->dev.parent, 0, info,
					   &sun4i_ts_tz_ops);

Removal of proposed patch to use late_initcall for iio_hwmon probe deferring.

Quentin Schulz (3):
  hwmon: iio_hwmon: defer probe when no channel is found
  mfd: add support for Allwinner SoCs ADC
  iio: adc: add support for Allwinner SoCs ADC

 drivers/hwmon/iio_hwmon.c           |   5 +-
 drivers/iio/adc/Kconfig             |  13 +
 drivers/iio/adc/Makefile            |   1 +
 drivers/iio/adc/sun4i-gpadc-iio.c   | 543 ++++++++++++++++++++++++++++++++++++
 drivers/mfd/Kconfig                 |  15 +
 drivers/mfd/Makefile                |   2 +
 drivers/mfd/sun4i-gpadc-mfd.c       | 174 ++++++++++++
 include/linux/mfd/sun4i-gpadc-mfd.h |  94 +++++++
 8 files changed, 846 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/adc/sun4i-gpadc-iio.c
 create mode 100644 drivers/mfd/sun4i-gpadc-mfd.c
 create mode 100644 include/linux/mfd/sun4i-gpadc-mfd.h

-- 
2.5.0
