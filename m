Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32180 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425202AbcBRPu7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 18 Feb 2016 10:50:59 -0500
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	wsa@the-dreams.de, linux-i2c@vger.kernel.org,
	lucas.demarchi@intel.com, daniel.baluta@intel.com,
	srinivas.pandruvada@linux.intel.com, ggao@invensense.com,
	adi.reus@gmail.com, cmo@melexis.com, mwelling@ieee.org
Subject: [RFC PATCH 0/9] iio: Fix ABBA deadlock in inv-mpu6050
Date: Thu, 18 Feb 2016 17:53:05 +0200
Message-Id: <1455810794-3188-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Sending this as an RFC because I don't know if style fixes are appropriate
for this driver and also not sure if deadlock fix is the best solution.

I2C people should only look at patches 8/9 and 9/9.

The mpu6050 accel+gyro combo has an auxiliary I2C bus, allowing for
an auxiliary sensor to be connected (eg. a magnetometer).

The mpu can either act as an I2C master (functionality not currently
implemented in the driver) or it can use a bypass multiplexer which
directly connects the auxiliary I2C bus pins to the main I2C bus pins [1]
Currently the driver implements the bypass mode via an I2C mux.

This patchset fixes a deadlock in inv-mpu6050 IMU which happens when
magnetometer (on auxiliary I2C bus) runs in parallel with accel or gyro.

First 7 patches do some cleanup in order to make INV MPU6050 code easier
to read.

Patch number 8 allows passing NULL select callbacks to i2c_mux_master_xfer
and i2c_mux_smbus_xfer.

Patch number 9 actually fixes the deadlock.

[1] (page 28, https://www.cdiweb.com/datasheets/invensense/MPU-6050_DataSheet_V3%204.pdf)

Adriana Reus (2):
  i2c: i2c-mux: Allow for NULL select callback
  iio: imu: inv_mpu6050: Fix deadlock between i2c adapter lock and mpu
    lock

Daniel Baluta (7):
  iio: imu: inv_mpu6050: Fix multiline comments style
  iio: imu: inv_mpu6050: Fix Yoda conditions
  iio: imu: inv_mpu6050: Fix newlines to make code easier to read
  iio: imu: inv_mpu6050: Remove unnecessary parentheses
  iio: imu: inv_mpu6050: Delete space before comma
  iio: imu: inv_mpu6050: Fix code indent for if statement
  iio: imu: inv_mpu6050: Fix alignment with open parenthesis

 drivers/i2c/i2c-mux.c                         |  10 ++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c    |   6 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 101 ++++++++++++++------------
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     |  90 ++++-------------------
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |  23 +++---
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  22 +++---
 6 files changed, 102 insertions(+), 150 deletions(-)

-- 
2.5.0

