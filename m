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
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	thomas.petazzoni@free-electrons.com,
	antoine.tenart@free-electrons.com
Subject: [PATCH v2 0/4] add support for Allwinner SoCs ADC
Date: Fri, 15 Jul 2016 11:59:10 +0200
Message-Id: <1468576754-3273-1-git-send-email-quentin.schulz@free-electrons.com>
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
It exposes labels for channels read by iio_hwmon. Until now, there were no
way to identify what the exposed channels are representing. Now, if a
channel has its extend_name field set, this value will be exposed in a
sysfs file suffixed by _label. If the field is empty, no file will be
created.

Quentin Schulz (4):
  hwmon: iio_hwmon: defer probe when no channel is found
  iio: adc: add support for Allwinner SoCs ADC
  mfd: add support for Allwinner SoCs ADC
  hwmon: iio: add label for channels read by iio_hwmon

 drivers/hwmon/iio_hwmon.c           |  82 ++++++-
 drivers/iio/adc/Kconfig             |  12 ++
 drivers/iio/adc/Makefile            |   1 +
 drivers/iio/adc/sunxi-gpadc-iio.c   | 417 ++++++++++++++++++++++++++++++++++++
 drivers/mfd/Kconfig                 |  14 ++
 drivers/mfd/Makefile                |   2 +
 drivers/mfd/sunxi-gpadc-mfd.c       | 197 +++++++++++++++++
 include/linux/mfd/sunxi-gpadc-mfd.h |  23 ++
 8 files changed, 738 insertions(+), 10 deletions(-)
 create mode 100644 drivers/iio/adc/sunxi-gpadc-iio.c
 create mode 100644 drivers/mfd/sunxi-gpadc-mfd.c
 create mode 100644 include/linux/mfd/sunxi-gpadc-mfd.h

-- 
2.5.0
