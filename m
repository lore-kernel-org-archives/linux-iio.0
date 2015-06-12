Return-Path: <adriana.reus@intel.com>
From: Adriana Reus <adriana.reus@intel.com>
To: ggao@invensense.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adriana Reus <adriana.reus@intel.com>
Subject: [PATCH 2/2] iio: inv-mpu: Specify the expected format/precision for write channels
Date: Fri, 12 Jun 2015 18:10:23 +0300
Message-Id: <1434121823-26266-3-git-send-email-adriana.reus@intel.com>
In-Reply-To: <1434121823-26266-1-git-send-email-adriana.reus@intel.com>
References: <1434121823-26266-1-git-send-email-adriana.reus@intel.com>
List-ID: <linux-iio@vger.kernel.org>

The gyroscope needs IIO_VAL_INT_PLUS_NANO for the scale channel and
unless specified write returns MICRO by default.
This needs to be properly specified so that write operations into scale
have the expected behaviour.

Signed-off-by: Adriana Reus <adriana.reus@intel.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 096e545..4de5374 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -431,6 +431,23 @@ static int inv_mpu6050_write_gyro_scale(struct inv_mpu6050_state *st, int val)
 	return -EINVAL;
 }
 
+static int inv_write_raw_get_fmt(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_ANGL_VEL:
+			return IIO_VAL_INT_PLUS_NANO;
+		default:
+			return IIO_VAL_INT_PLUS_MICRO;
+		}
+	default:
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+
+	return -EINVAL;
+}
 static int inv_mpu6050_write_accel_scale(struct inv_mpu6050_state *st, int val)
 {
 	int result, i;
@@ -702,6 +719,7 @@ static const struct iio_info mpu_info = {
 	.driver_module = THIS_MODULE,
 	.read_raw = &inv_mpu6050_read_raw,
 	.write_raw = &inv_mpu6050_write_raw,
+	.write_raw_get_fmt = &inv_write_raw_get_fmt,
 	.attrs = &inv_attribute_group,
 	.validate_trigger = inv_mpu6050_validate_trigger,
 };
-- 
1.9.1
