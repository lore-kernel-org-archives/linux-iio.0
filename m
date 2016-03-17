Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:20055 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936036AbcCQQaZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 17 Mar 2016 12:30:25 -0400
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	daniel.baluta@intel.com, matt.ranostay@intel.com,
	lucas.demarchi@intel.com, cmo@melexis.com,
	linux-iio@vger.kernel.org, ggao@invensense.com,
	srinivas.pandruvada@linux.intel.com, adi.reus@gmail.com
Subject: [PATCH 0/3] Introduce support for INV MPU6050 secondary I2C master
Date: Thu, 17 Mar 2016 18:32:43 +0200
Message-Id: <1458232366-12773-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch series adds support for attaching external sensors to INV MPU6050
secondary I2C interface (acting as an I2C bus).

First patch fixes a bug when using ACPI, the second one moves the interrupt out
of probe trigger code preparing the third patch which actually does $Subject.

I2C secondary bus can support up to 5 slaves. Slaves 0-3 have a common way
of operation while the 4 one is completely different. This patch series
only implements support for the 4th slave because it has a cleaner interface
(although less efficent for bulk transfer) and also provides a way of
signalling when data recevied from slave is available.

Ge,

In order to prepare support for slaves 0-3 we need to find the answer for
the following questions:
	* when doing a read transaction after preparing I2C address, I2C
        remote register, etc how do we know when to read for available data?
	* how can we benefit from INV MPU6050 FIFO in case of external sensors?
	(will look into in-kernel buffer consumers)

Daniel Baluta (3):
  iio: imu: mpu6050: Fix name/chip_id when using ACPI
  iio: imu: mpu6050: Request IRQ outside of probe trigger
  iio: imu: mpu6050: Add support for auxiliary I2C master

 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 139 ++++++++++++++++++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     |  29 +++++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  38 +++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |   8 --
 4 files changed, 203 insertions(+), 11 deletions(-)

-- 
2.5.0

