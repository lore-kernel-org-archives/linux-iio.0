Return-Path: <sha@pengutronix.de>
From: Sascha Hauer <s.hauer@pengutronix.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
	Sonic Zhang <sonic.zhang@analog.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 1/3] staging iio adt7410: sysfs store function must return length
Date: Tue,  3 Jul 2012 11:21:26 +0200
Message-Id: <1341307288-1926-2-git-send-email-s.hauer@pengutronix.de>
In-Reply-To: <1341307288-1926-1-git-send-email-s.hauer@pengutronix.de>
References: <1341307288-1926-1-git-send-email-s.hauer@pengutronix.de>
List-ID: <linux-iio@vger.kernel.org>

Otherwise a write to the resolution entry never returns.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/staging/iio/adc/adt7410.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/adt7410.c b/drivers/staging/iio/adc/adt7410.c
index d7d9ad9..fa54a40 100644
--- a/drivers/staging/iio/adc/adt7410.c
+++ b/drivers/staging/iio/adc/adt7410.c
@@ -257,7 +257,7 @@ static ssize_t adt7410_store_resolution(struct device *dev,
 
 	chip->config = config;
 
-	return ret;
+	return len;
 }
 
 static IIO_DEVICE_ATTR(resolution, S_IRUGO | S_IWUSR,
-- 
1.7.10
