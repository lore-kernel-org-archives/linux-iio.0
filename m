Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:42642 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbbG0VsW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jul 2015 17:48:22 -0400
From: Luis Henriques <luis.henriques@canonical.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: inv-mpu: make inv_write_raw_get_fmt() more readable
Date: Mon, 27 Jul 2015 22:48:17 +0100
Message-Id: <1438033697-22772-1-git-send-email-luis.henriques@canonical.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Replace nested switch statements by a single if statement, making function
inv_write_raw_get_fmt() more readable.

Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 65ce86837177..afbc2d2b8608 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -434,19 +434,9 @@ static int inv_mpu6050_write_gyro_scale(struct inv_mpu6050_state *st, int val)
 static int inv_write_raw_get_fmt(struct iio_dev *indio_dev,
 				 struct iio_chan_spec const *chan, long mask)
 {
-	switch (mask) {
-	case IIO_CHAN_INFO_SCALE:
-		switch (chan->type) {
-		case IIO_ANGL_VEL:
-			return IIO_VAL_INT_PLUS_NANO;
-		default:
-			return IIO_VAL_INT_PLUS_MICRO;
-		}
-	default:
-		return IIO_VAL_INT_PLUS_MICRO;
-	}
-
-	return -EINVAL;
+	if ((mask == IIO_CHAN_INFO_SCALE) && (chan->type == IIO_ANGL_VEL))
+		return IIO_VAL_INT_PLUS_NANO;
+	return IIO_VAL_INT_PLUS_MICRO;
 }
 static int inv_mpu6050_write_accel_scale(struct inv_mpu6050_state *st, int val)
 {
