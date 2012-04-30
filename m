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
Date: Tue,  1 May 2012 01:26:17 +0600
Message-Id: <1335813977-8096-1-git-send-email-josephdanielwalter@gmail.com>
List-ID: <linux-iio@vger.kernel.org>


Signed-off-by: joseph daniel <josephdanielwalter@gmail.com>
---
Hi Lars,
	Thanks for review. how about the below change?
 drivers/staging/iio/meter/ade7854-i2c.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
index 1e1faa0..52bdb05 100644
--- a/drivers/staging/iio/meter/ade7854-i2c.c
+++ b/drivers/staging/iio/meter/ade7854-i2c.c
@@ -181,6 +181,7 @@ static int ade7854_i2c_read_reg_32(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ade7854_state *st = iio_priv(indio_dev);
+	uint32_t value;
 	int ret;
 
 	mutex_lock(&st->buf_lock);
@@ -195,7 +196,10 @@ static int ade7854_i2c_read_reg_32(struct device *dev,
 	if (ret)
 		goto out;
 
-	*val = (st->rx[0] << 24) | (st->rx[1] << 16) | (st->rx[2] << 8) | st->rx[3];
+	memcpy(&value, st->rx, sizeof(uint32_t));
+
+	*val = be32_to_cpu(value);
+
 out:
 	mutex_unlock(&st->buf_lock);
 	return ret;
-- 
1.7.9.5
