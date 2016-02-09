Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:58080 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753107AbcBIPjk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 9 Feb 2016 10:39:40 -0500
From: Adriana Reus <adriana.reus@intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
	ggao@invensense.com, daniel.baluta@intel.com, mwelling@ieee.org,
	lucas.de.marchi@gmail.com, adi.reus@gmail.com,
	Adriana Reus <adriana.reus@intel.com>
Subject: [PATCH v3 0/4] iio: imu: inv_mpu6050: Split driver into core and I2C/SPI functionality
Date: Tue,  9 Feb 2016 17:38:16 +0200
Message-Id: <1455032300-12466-1-git-send-email-adriana.reus@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This series splits this driver into general and I2C/SPI specific functionality.
The first patch is a fix for a bug in the interrupt pin configuration.
The second patch changes all the I2C specific calls into regmap calls.
The third patch separated the remaining I2C specific part into a different component.
Finally the fourth patch adds SPI support for the MPU6000 chip.

No changes since v2 for the first two patches.
Adressed comments for the last two patches

Adriana Reus (4):
  iio: imu: inv-mpu6050: Fix interrupt pin configuration
  iio: imu: inv_mpu6050: Use regmap instead of i2c specific functions
  iio: imu: inv_mpu6050: Separate driver into core and i2c
    functionality.
  iio: imu: inv_mpu6050: Add SPI support for MPU6000

 drivers/iio/imu/inv_mpu6050/Kconfig           |  21 ++-
 drivers/iio/imu/inv_mpu6050/Makefile          |   8 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c    |  18 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 258 ++++++--------------------
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     | 207 +++++++++++++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  19 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |  35 ++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c     | 106 +++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  10 +-
 9 files changed, 440 insertions(+), 242 deletions(-)
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c

-- 
1.9.1

