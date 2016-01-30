Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:47094 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932125AbcA3Jow (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 30 Jan 2016 04:44:52 -0500
From: Adriana Reus <adriana.reus@intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
	ggao@invensense.com, Adriana Reus <adriana.reus@intel.com>
Subject: [RFC PATCH 0/5] iio: imu: inv_mpu6050: Split driver into core and I2C/SPI functionality
Date: Sat, 30 Jan 2016 11:43:43 +0200
Message-Id: <1454147028-22449-1-git-send-email-adriana.reus@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This series splits this driver into general and I2C/SPI specific funtionality.
The first patch is a fix for a bug in the interrupt pin configuration.
The second patch is a minor clean up in preparation for the split.
The third patch changes all the I2C specific calls into regmap calls.
The third patch separated the remaining I2C specific part into a different component.
Finally the fourth patch adds SPI support for the MPU6000 chip.

Adriana Reus (5):
  iio: imu: inv-mpu6050: Fix interrupt pin configuration
  iio: inv_mpu6050: Remove unused parameter
  iio: imu: inv_mpu6050: Use regmap instead of i2c specific functions
  iio: imu: inv_mpu6050: Separate driver into core and i2c
    functionality.
  iio: imu: inv_mpu6050: Add SPI support for MPU6000

 drivers/iio/imu/inv_mpu6050/Kconfig           |  15 +-
 drivers/iio/imu/inv_mpu6050/Makefile          |   8 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c    |  14 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 259 ++++++--------------------
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     | 209 +++++++++++++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  15 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |  34 ++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c     |  80 ++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  10 +-
 9 files changed, 402 insertions(+), 242 deletions(-)
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c

-- 
1.9.1

