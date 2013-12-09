Return-Path: <beomho.seo@samsung.com>
Message-id: <52A5284D.4080906@samsung.com>
Date: Mon, 09 Dec 2013 11:17:49 +0900
From: Beomho Seo <beomho.seo@samsung.com>
MIME-version: 1.0
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] iio: cm36651: Changed return value of read function
Content-type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Hello,

I have fixed cm36651 driver.
Some return value of callback have been changed to IIO_VAL_INT.
If not IIO_VAL_INT, driver will print wrong value(*_read_int_time) or not print(*_read_prox_thresh).

Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
---
 drivers/iio/light/cm36651.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/cm36651.c b/drivers/iio/light/cm36651.c
index 21df571..0206eab 100644
--- a/drivers/iio/light/cm36651.c
+++ b/drivers/iio/light/cm36651.c
@@ -387,7 +387,7 @@ static int cm36651_read_int_time(struct cm36651_data *cm36651,
 		return -EINVAL;
 	}

-	return IIO_VAL_INT_PLUS_MICRO;
+	return IIO_VAL_INT;
 }

 static int cm36651_write_int_time(struct cm36651_data *cm36651,
@@ -494,7 +494,7 @@ static int cm36651_read_prox_thresh(struct iio_dev *indio_dev,

 	*val = cm36651->ps_ctrl_regs[CM36651_PS_THD];

-	return 0;
+	return IIO_VAL_INT;
 }

 static int cm36651_write_prox_thresh(struct iio_dev *indio_dev,
-- 
1.7.9.5
-- 
Best Regards,

Beomho Seo, Assistant Engineer
System S/W Lab., Software Center, Samsung Electronics
