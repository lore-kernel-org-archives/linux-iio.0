Return-Path: <mtitinger@baylibre.com>
From: Marc Titinger <mtitinger@baylibre.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux@roeck-us.net,
	jdelvare@suse.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lm-sensors@lm-sensors.org,
	Marc Titinger <mtitinger@baylibre.com>
Subject: [PATCH v3 0/2] IIO version of INA2xx
Date: Mon,  7 Dec 2015 10:09:33 +0100
Message-Id: <1449479375-4061-1-git-send-email-mtitinger@baylibre.com>
List-ID: <linux-iio@vger.kernel.org>

Version 3 of https://lkml.org/lkml/2015/11/25/245

  * rename ina2xx-iio to ian2xx-adc for consistency with other chips
    (ina2xx being the hwmon driver).
  * add an exclusion in the iio/adc/Kconfig: depends on !SENSORS_INA2XX
  * more typos and style fixes
  * make regmap config const with .max_register = INA2XX_MAX_REGISTERS

previous references:
  * following RFC started in https://lkml.org/lkml/2015/11/10/370
  * and feed back from https://lkml.org/lkml/2015/11/18/395
  * Version 2: https://lkml.org/lkml/2015/11/30/245

Marc Titinger (2):
  iio: ina2xx: add support for TI INA2xx Power Monitors
  iio: ina2xx: provide a sysfs parameter to allow async readout of the
    ADCs

 drivers/iio/adc/Kconfig      |  10 +
 drivers/iio/adc/Makefile     |   1 +
 drivers/iio/adc/ina2xx-adc.c | 706 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 717 insertions(+)
 create mode 100644 drivers/iio/adc/ina2xx-adc.c

-- 
1.9.1
