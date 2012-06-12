Return-Path: <leed.aguilar@ti.com>
From: Leed Aguilar <leed.aguilar@ti.com>
To: <linux-iio@vger.kernel.org>
CC: <leed.aguilar@ti.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter
 Clausen <lars@metafoo.de>
Subject: [PATCH] staging:iio:gyro:adis16080: remove sparse warnings
Date: Tue, 12 Jun 2012 16:25:21 -0400
Message-ID: <1339532721-2903-1-git-send-email-leed.aguilar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Removed the following sparse warning:

In function 'adis16080_read_raw':
warning: 'ut' may be used uninitialized in this function

Signed-off-by: Leed Aguilar <leed.aguilar@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/gyro/adis16080_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16080_core.c b/drivers/staging/iio/gyro/adis16080_core.c
index 11f1dcc..345e4fa 100644
--- a/drivers/staging/iio/gyro/adis16080_core.c
+++ b/drivers/staging/iio/gyro/adis16080_core.c
@@ -82,7 +82,7 @@ static int adis16080_read_raw(struct iio_dev *indio_dev,
 			     long mask)
 {
 	int ret = -EINVAL;
-	u16 ut;
+	u16 ut = 0;
 	/* Take the iio_dev status lock */
 
 	mutex_lock(&indio_dev->mlock);
-- 
1.7.1
