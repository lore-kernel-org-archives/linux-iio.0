Return-Path: <SRS0=Vyki=II=xevo.com=mkelly@kernel.org>
From: Martin Kelly <mkelly@xevo.com>
To: linux-iio@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Martin Kelly <mkelly@xevo.com>
Subject: [PATCH] iio: imu: inv_mpu6050: add comment about frequencies
Date: Mon, 21 May 2018 11:41:54 -0700
Message-Id: <20180521184154.29548-1-mkelly@xevo.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Although the driver allows frequencies between 4 and 1000 Hz, only the
frequencies advertised in the available frequencies file are backed
properly by a low-pass filter to prevent aliasing, so it's best to use
them. Since this is not obvious to the user, add a comment explaining
what's going on.

Signed-off-by: Martin Kelly <mkelly@xevo.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 43fba5f7532b..f9c0624505a2 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -798,7 +798,14 @@ static const struct iio_chan_spec inv_mpu_channels[] = {
 	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_MPU6050_SCAN_ACCL_Z),
 };
 
-/* constant IIO attribute */
+/*
+ * The user can choose any frequency between INV_MPU6050_MIN_FIFO_RATE and
+ * INV_MPU6050_MAX_FIFO_RATE, but only these frequencies are matched by the
+ * low-pass filter. Specifically, each of these sampling rates are about twice
+ * the bandwidth of a corresponding low-pass filter, which should eliminate
+ * aliasing following the Nyquist principle. By picking a frequency different
+ * from these, the user risks aliasing effects.
+ */
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("10 20 50 100 200 500");
 static IIO_CONST_ATTR(in_anglvel_scale_available,
 					  "0.000133090 0.000266181 0.000532362 0.001064724");
-- 
2.11.0
