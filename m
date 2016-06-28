Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:45916 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752020AbcF1IqL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jun 2016 04:46:11 -0400
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
Subject: [PATCH 0/3] add support for Allwinner SoCs ADC
Date: Tue, 28 Jun 2016 10:45:37 +0200
Message-Id: <1467101897-15946-1-git-send-email-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The Allwinner SoCs all have an ADC that can also act as a touchscreen controller
and a thermal sensor. The first four channels can be used either for the ADC or
the touchscreen and the fifth channel is used for the thermal sensor. We
currently have a driver for the two latter functions in
drivers/input/touchscreen/sun4i-ts.c but we don't have access to the ADC feature
at all.

This adds initial support for Allwinner SoCs ADC with all features. Yet, the
touchscreen is not implemented but will be added later. To switch between
touchscreen and ADC modes, you need to poke few bits in registers and
(de)activate an interrupt (pen-up).
A MFD is provided to let the input driver activate the pen-up interrupt through
virtual interrupt, poke few bits via regmap and read data from the ADC driver
while both (and iio_hwmon) are probed by the MFD.

There exists slight modifications between the different SoCs ADC like the
address of some registers and the scale and offset to apply to thermal sensor
raw values. These modifications are done by drivers on different
platform_device_id passed by the MFD when probing subdrivers.

This also modifies iio-hwmon to allow probe deferring when no iio channel is
found. Currently when no iio channel is found, the probing of iio-hwmon fails.
This is problematic when iio-hwmon probes before the iio driver could register
iio channels to share.

Quentin Schulz (3):
  mfd: add support for Allwinner SoCs ADC
  iio: adc: add support for Allwinner SoCs ADC
  hwmon: iio_hwmon: defer probe when no channel is found

 drivers/hwmon/iio_hwmon.c           |   5 +-
 drivers/iio/adc/Kconfig             |  12 ++
 drivers/iio/adc/Makefile            |   1 +
 drivers/iio/adc/sunxi-gpadc-iio.c   | 371 ++++++++++++++++++++++++++++++++++++
 drivers/mfd/Kconfig                 |  14 ++
 drivers/mfd/Makefile                |   2 +
 drivers/mfd/sunxi-gpadc-mfd.c       | 188 ++++++++++++++++++
 include/linux/mfd/sunxi-gpadc-mfd.h |  14 ++
 8 files changed, 606 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/adc/sunxi-gpadc-iio.c
 create mode 100644 drivers/mfd/sunxi-gpadc-mfd.c
 create mode 100644 include/linux/mfd/sunxi-gpadc-mfd.h

-- 
2.5.0

