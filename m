Return-Path: <SRS0=SzcG=4D=collabora.co.uk=sebastian.reichel@kernel.org>
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Sebastian Reichel <sre@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: J Keerthy <j-keerthy@ti.com>,
	linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH 0/7] twl4030-madc cleanup
Date: Thu, 27 Apr 2017 17:30:05 +0200
Message-Id: <20170427153012.32310-1-sebastian.reichel@collabora.co.uk>
List-ID: <linux-iio@vger.kernel.org>

Hi,

Here are a few cleanup patches for the twl4030-madc
driver, that remove the last users of the driver's
legacy API and then remove it.

-- Sebastian

Sebastian Reichel (7):
  hwmon: twl4030-madc: drop driver
  power: supply: avoid unused twl4030-madc.h
  iio: adc: twl4030: Drop twl4030_get_madc_conversion()
  iio: adc: twl4030: Unexport twl4030_madc_conversion()
  iio: adc: twl4030: Drop struct twl4030_madc_user_parms
  iio: adc: twl4030: Remove twl4030_madc_request.func_cb
  iio: adc: twl4030: Fold twl4030-madc.h into driver

 drivers/hwmon/Kconfig                       |  10 --
 drivers/hwmon/Makefile                      |   1 -
 drivers/hwmon/twl4030-madc-hwmon.c          | 118 ----------------
 drivers/iio/adc/twl4030-madc.c              | 209 +++++++++++++++-------------
 drivers/power/supply/rx51_battery.c         |   1 -
 drivers/power/supply/twl4030_madc_battery.c |   1 -
 include/linux/i2c/twl4030-madc.h            | 147 -------------------
 7 files changed, 115 insertions(+), 372 deletions(-)
 delete mode 100644 drivers/hwmon/twl4030-madc-hwmon.c
 delete mode 100644 include/linux/i2c/twl4030-madc.h

-- 
2.11.0
