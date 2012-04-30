Return-Path: <josephdanielwalter@gmail.com>
From: joseph daniel <josephdanielwalter@gmail.com>
To: Jonathan Cameron <jic23@cam.ac.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wolfram Sang <w.sang@pengutronix.de>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Cc: joseph daniel <josephdanielwalter@gmail.com>
Subject: [PATCH] staging/iio/meter: fix the coding style problem
Date: Tue,  1 May 2012 00:21:20 +0600
Message-Id: <1335810080-30717-1-git-send-email-josephdanielwalter@gmail.com>
List-ID: <linux-iio@vger.kernel.org>


Signed-off-by: joseph daniel <josephdanielwalter@gmail.com>
---
 Please consider this patch, previous one is wrong because my
 tabspace in vim was 4, instead 8. sorry..

 drivers/staging/iio/meter/ade7854-i2c.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
index 1e1faa0..ba97d6e 100644
--- a/drivers/staging/iio/meter/ade7854-i2c.c
+++ b/drivers/staging/iio/meter/ade7854-i2c.c
@@ -195,7 +195,10 @@ static int ade7854_i2c_read_reg_32(struct device *dev,
 	if (ret)
 		goto out;
 
-	*val = (st->rx[0] << 24) | (st->rx[1] << 16) | (st->rx[2] << 8) | st->rx[3];
+	*val =  (st->rx[0] << 24) |
+		(st->rx[1] << 16) |
+		(st->rx[2] << 8)  |
+		 st->rx[3];
 out:
 	mutex_unlock(&st->buf_lock);
 	return ret;
-- 
1.7.9.5
