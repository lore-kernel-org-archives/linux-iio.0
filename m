Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/3] iio: imu: inv_mpu6050: Added adapter class
Date: Mon, 15 Dec 2014 13:19:22 -0800
Message-Id: <1418678363-22437-3-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1418678363-22437-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1418678363-22437-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

To use i2c auto detect to work we need to have a non zero class.
The closest class is I2C_CLASS_HWMON, as it defined to be used
with all hw monitoring drivers.

Also this class is already used by some iio driver, hid drivers, led
and misc drivers. So this is not new that this is used outside
hwmon drivers.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index f73e60b..4af2d24 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -813,7 +813,7 @@ static int inv_mpu_probe(struct i2c_client *client,
 	st->mux_adapter = i2c_add_mux_adapter(client->adapter,
 					      &client->dev,
 					      indio_dev,
-					      0, 0, 0,
+					      0, 0, I2C_CLASS_HWMON,
 					      inv_mpu6050_select_bypass,
 					      inv_mpu6050_deselect_bypass);
 	if (!st->mux_adapter) {
-- 
1.9.3
