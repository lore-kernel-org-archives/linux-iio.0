Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46766 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754155AbcDTNP2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 20 Apr 2016 09:15:28 -0400
From: Crestez Dan Leonard <leonard.crestez@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>,
	Ge Gao <GGao@invensense.com>
Subject: [PATCH 0/5] iio: inv_mpu6050: Cleanup chip types and add mpu9150
Date: Wed, 20 Apr 2016 16:15:08 +0300
Message-Id: <cover.1461156671.git.leonard.crestez@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This adds support for mpu9150 explictly. This device includes a MPU60X0 and
AK8975 inside the same package. It also cleans the chip_type <=> hw_info
mappings which were just a mess.

Crestez Dan Leonard (5):
  iio: inv_mpu6050: Cleanup hw_info mapping
  iio: inv_mpu6050: Remove inv_mpu6050_hw.num_reg
  iio: inv_mpu6050: Check WHO_AM_I register on probe
  iio: inv_mpu6050: Add spi_device_id for INV_MPU6500
  iio: inv_mpu6050: Add explicit support for MPU9150

 drivers/iio/imu/inv_mpu6050/Kconfig        | 10 ++++----
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 37 +++++++++++++++++++++++++++---
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  |  3 ++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  | 12 ++++++++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  | 20 ++++++++++++----
 5 files changed, 66 insertions(+), 16 deletions(-)

-- 
2.5.5

