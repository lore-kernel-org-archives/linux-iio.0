Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, <drivers@analog.com>,
	<device-drivers-devel@blackfin.uclinux.org>, Michael Hennerich
	<michael.hennerich@analog.com>
Subject: [PATCH 2/6] IIO: GYRO: ADXRS450: Cleanup result extraction and update license notice
Date: Fri, 29 Apr 2011 12:58:37 +0200
Message-ID: <1304074721-18159-2-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1304074721-18159-1-git-send-email-michael.hennerich@analog.com>
References: <1304074721-18159-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Cleanup result extraction and update license notice, no functional changes.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/gyro/adxrs450_core.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
index a1a71b7..c02e3ef 100644
--- a/drivers/staging/iio/gyro/adxrs450_core.c
+++ b/drivers/staging/iio/gyro/adxrs450_core.c
@@ -3,7 +3,7 @@
  *
  * Copyright 2011 Analog Devices Inc.
  *
- * Licensed under the GPL-2 or later.
+ * Licensed under the GPL-2.
  */
 
 #include <linux/interrupt.h>
@@ -69,7 +69,7 @@ static int adxrs450_spi_read_reg_16(struct device *dev,
 		goto error_ret;
 	}
 
-	*val = (st->rx[1] & 0x1f) << 11 | st->rx[2] << 3 | (st->rx[3] & 0xe0) >> 5;
+	*val = (be32_to_cpu(*(u32 *)st->rx) >> 5) & 0xFFFF;
 
 error_ret:
 	mutex_unlock(&st->buf_lock);
@@ -152,7 +152,8 @@ static int adxrs450_spi_sensor_data(struct device *dev, u16 *val)
 		goto error_ret;
 	}
 
-	*val = (st->rx[0] & 0x03) << 14 | st->rx[1] << 6 | (st->rx[2] & 0xfc) >> 2;
+	*val = (be32_to_cpu(*(u32 *)st->rx) >> 10) & 0xFFFF;
+
 error_ret:
 	mutex_unlock(&st->buf_lock);
 	return ret;
-- 
1.6.0.2
