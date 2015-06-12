Return-Path: <adriana.reus@intel.com>
From: Adriana Reus <adriana.reus@intel.com>
To: ggao@invensense.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adriana Reus <adriana.reus@intel.com>
Subject: [PATCH 1/2] iio: inv-mpu: Export scale_available attributes
Date: Fri, 12 Jun 2015 18:10:22 +0300
Message-Id: <1434121823-26266-2-git-send-email-adriana.reus@intel.com>
In-Reply-To: <1434121823-26266-1-git-send-email-adriana.reus@intel.com>
References: <1434121823-26266-1-git-send-email-adriana.reus@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Export the available scales for accel and gyro in order
to hint the user-space as to what are the available valid values.

Signed-off-by: Adriana Reus <adriana.reus@intel.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 17d4bb1..096e545 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -673,6 +673,10 @@ static const struct iio_chan_spec inv_mpu_channels[] = {
 
 /* constant IIO attribute */
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("10 20 50 100 200 500");
+static IIO_CONST_ATTR(in_anglvel_scale_available,
+					  "0.000133090 0.000266181 0.000532362 0.001064724");
+static IIO_CONST_ATTR(in_accel_scale_available,
+					  "0.000598 0.001196 0.002392 0.004785");
 static IIO_DEV_ATTR_SAMP_FREQ(S_IRUGO | S_IWUSR, inv_fifo_rate_show,
 	inv_mpu6050_fifo_rate_store);
 static IIO_DEVICE_ATTR(in_gyro_matrix, S_IRUGO, inv_attr_show, NULL,
@@ -685,6 +689,8 @@ static struct attribute *inv_attributes[] = {
 	&iio_dev_attr_in_accel_matrix.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	&iio_const_attr_in_accel_scale_available.dev_attr.attr,
+	&iio_const_attr_in_anglvel_scale_available.dev_attr.attr,
 	NULL,
 };
 
-- 
1.9.1
