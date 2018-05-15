Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-by2nam01on0085.outbound.protection.outlook.com ([104.47.34.85]:55072
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752146AbeEOVyM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 15 May 2018 17:54:12 -0400
From: Martin Kelly <mkelly@xevo.com>
To: linux-iio@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Martin Kelly <mkelly@xevo.com>
Subject: [PATCH] iio: imu: inv_mpu6050: advertise max and min freqs
Date: Tue, 15 May 2018 14:53:49 -0700
Message-Id: <20180515215349.27482-1-mkelly@xevo.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Currently, we allow a minimum FIFO rate of 4 and a max of 1000, but we
advertise down to only 10 and up to 1000. Expand the advertised range to
reflect the full available range.

Signed-off-by: Martin Kelly <mkelly@xevo.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 43fba5f7532b..3f4862f09db3 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -799,7 +799,7 @@ static const struct iio_chan_spec inv_mpu_channels[] = {
 };
 
 /* constant IIO attribute */
-static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("10 20 50 100 200 500");
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("4 10 20 50 100 200 500 1000");
 static IIO_CONST_ATTR(in_anglvel_scale_available,
 					  "0.000133090 0.000266181 0.000532362 0.001064724");
 static IIO_CONST_ATTR(in_accel_scale_available,
-- 
2.11.0

