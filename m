Return-Path: <mpa@pengutronix.de>
From: Markus Pargmann <mpa@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 0/7] iio: bmg160: Add SPI connection
Date: Wed, 29 Jul 2015 15:46:02 +0200
Message-Id: <1438177569-18772-1-git-send-email-mpa@pengutronix.de>
List-ID: <linux-iio@vger.kernel.org>

Hi,

bmg160 and bmi055 can be used via I2C and SPI. This series converts the driver
to regmap and splits core driver and I2C/SPI.

I only have a board which has a bmi055 connected via SPI. I am not able to test
the I2C part. Would be great if someone could test that the I2C driver is still
working.

Best regards,

Markus


Markus Pargmann (7):
  iio: bmg160: IIO_BUFFER and IIO_TRIGGERED_BUFFER are required
  iio: bmg160: Use i2c regmap instead of direct i2c access
  iio: bmg160: Remove i2c_client from data struct
  iio: bmg160: Use generic dev_drvdata
  iio: bmg160: Remove remaining uses of i2c_client
  iio: bmg160: Separate i2c and core driver
  iio: bmg160: Add SPI driver

 drivers/iio/gyro/Kconfig                     |  32 ++-
 drivers/iio/gyro/Makefile                    |   4 +-
 drivers/iio/gyro/bmg160.h                    |  10 +
 drivers/iio/gyro/{bmg160.c => bmg160_core.c} | 356 +++++++++++----------------
 drivers/iio/gyro/bmg160_i2c.c                |  73 ++++++
 drivers/iio/gyro/bmg160_spi.c                |  59 +++++
 6 files changed, 312 insertions(+), 222 deletions(-)
 create mode 100644 drivers/iio/gyro/bmg160.h
 rename drivers/iio/gyro/{bmg160.c => bmg160_core.c} (74%)
 create mode 100644 drivers/iio/gyro/bmg160_i2c.c
 create mode 100644 drivers/iio/gyro/bmg160_spi.c

-- 
2.1.4
