Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from email.invensense.com ([12.199.206.106]:28056 "EHLO
	email.invensense.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964838AbbFKRhB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 11 Jun 2015 13:37:01 -0400
From: Ge Gao <GGao@invensense.com>
To: Adriana Reus <adriana.reus@intel.com>,
	"jic23@kernel.org" <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] iio: inv-mpu: Specify the expected format/precision
 for write channels
Date: Thu, 11 Jun 2015 17:31:51 +0000
Message-ID: <E7747D604FBC9F43A71AA431AFF4476299C52ADD@IUSEXCH01.invcorp.invensense.com>
References: <1434121823-26266-1-git-send-email-adriana.reus@intel.com>
 <1434121823-26266-3-git-send-email-adriana.reus@intel.com>
In-Reply-To: <1434121823-26266-3-git-send-email-adriana.reus@intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

These code looks good to me.
Thanks.

Best Regards,

Ge GAO


-----Original Message-----
From: Adriana Reus [mailto:adriana.reus@intel.com] 
Sent: Friday, June 12, 2015 8:10 AM
To: Ge Gao; jic23@kernel.org
Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; Adriana Reus
Subject: [PATCH 2/2] iio: inv-mpu: Specify the expected format/precision for write channels

The gyroscope needs IIO_VAL_INT_PLUS_NANO for the scale channel and unless specified write returns MICRO by default.
This needs to be properly specified so that write operations into scale have the expected behaviour.

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
+				 struct iio_chan_spec const *chan, long mask) {
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
 static int inv_mpu6050_write_accel_scale(struct inv_mpu6050_state *st, int val)  {
 	int result, i;
@@ -702,6 +719,7 @@ static const struct iio_info mpu_info = {
 	.driver_module = THIS_MODULE,
 	.read_raw = &inv_mpu6050_read_raw,
 	.write_raw = &inv_mpu6050_write_raw,
+	.write_raw_get_fmt = &inv_write_raw_get_fmt,
 	.attrs = &inv_attribute_group,
 	.validate_trigger = inv_mpu6050_validate_trigger,  };
--
1.9.1

