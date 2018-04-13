Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-co1nam03on0078.outbound.protection.outlook.com ([104.47.40.78]:38112
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753543AbeDMIZ1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 13 Apr 2018 04:25:27 -0400
From: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To: linux-iio@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH] iio: imu: inv_mpu6050: do not flush fifo when iio buffer is full
Date: Fri, 13 Apr 2018 10:25:06 +0200
Message-Id: <1523607906-22485-1-git-send-email-jmaneyrol@invensense.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

There is no need to flush fifo and loose all data when the iio
buffer is full. Just drop the data by ignoring the error as
commonly done in other drivers.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index ff81c6a..27c663c 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -170,10 +170,8 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 		if (result == 0)
 			timestamp = 0;
 
-		result = iio_push_to_buffers_with_timestamp(indio_dev, data,
-							    timestamp);
-		if (result)
-			goto flush_fifo;
+		iio_push_to_buffers_with_timestamp(indio_dev, data, timestamp);
+
 		fifo_count -= bytes_per_datum;
 	}
 
-- 
2.7.4

