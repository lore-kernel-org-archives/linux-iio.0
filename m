Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: knaack.h@gmx.de,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 0/2] iio: imu: inv_mpu6050: Add i2c mux for by pass
Date: Tue, 18 Nov 2014 09:53:02 -0800
Message-Id: <1416333184-1367-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

v1
Some minor formatting fix mostly suggested by Hartmut
fail probe if mux create fails
function parameter type matching i2c struct

v0
base version

Srinivas Pandruvada (2):
  iio: imu: inv_mpu6050: Add i2c mux for by pass
  iio: magnetometer: ak8975: remove INVN6500 enumeration

 drivers/iio/imu/inv_mpu6050/Kconfig        |   1 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 168 +++++++++++++++++++++++++++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |   9 ++
 drivers/iio/magnetometer/ak8975.c          |   1 -
 4 files changed, 172 insertions(+), 7 deletions(-)

-- 
1.9.3
