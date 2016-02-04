Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:30176 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750966AbcBDJWG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 4 Feb 2016 04:22:06 -0500
From: Adriana Reus <adriana.reus@intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
	ggao@invensense.com, lucas.de.marchi@gmail.com,
	Adriana Reus <adriana.reus@intel.com>
Subject: [PATCH v2 0/4] iio: imu: inv_mpu6050: Split driver into core and I2C/SPI functionality
Date: Thu,  4 Feb 2016 11:20:24 +0200
Message-Id: <1454577628-12708-1-git-send-email-adriana.reus@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This series splits this driver into general and I2C/SPI specific functionality.
The first patch is a fix for a bug in the interrupt pin configuration.
The second patch changes all the I2C specific calls into regmap calls.
The third patch separated the remaining I2C specific part into a different component.
Finally the fourth patch adds SPI support for the MPU6000 chip.

No changes since v1 for the first two patches.
Small changes since v1 to the last two patches

Adriana Reus (4):
  iio: imu: inv-mpu6050: Fix interrupt pin configuration
  iio: imu: inv_mpu6050: Use regmap instead of i2c specific functions
  iio: imu: inv_mpu6050: Separate driver into core and i2c
    functionality.
  iio: imu: inv_mpu6050: Add SPI support for MPU6000

 drivers/iio/imu/inv_mpu6050/Kconfig           |  21 ++-
 drivers/iio/imu/inv_mpu6050/Makefile          |   8 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c    |  14 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 253 +++++---------------------
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     | 207 +++++++++++++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  17 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |  35 ++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c     |  87 +++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  10 +-
 9 files changed, 412 insertions(+), 240 deletions(-)
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c

-- 
1.9.1

