Return-Path: <weiyj.lk@gmail.com>
MIME-Version: 1.0
Date: Thu, 4 Jul 2013 21:46:34 +0800
Message-ID: <CAPgLHd-v0MJWgtjY66Ky87ieQYxXg_9bFQxB0N5zoibshCV7Jg@mail.gmail.com>
Subject: [PATCH] staging:iio:ad7291: add missing .driver_module to struct iio_info
From: Wei Yongjun <weiyj.lk@gmail.com>
To: jic23@cam.ac.uk, gregkh@linuxfoundation.org, lars@metafoo.de,
	wfp5p@virginia.edu
Cc: yongjun_wei@trendmicro.com.cn, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add missing .driver_module of struct iio_info. This prevents the
module from being removed from underneath its users.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/staging/iio/adc/ad7291.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index 3fc79e5..a2e61c2 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -517,6 +517,7 @@ static const struct iio_info ad7291_info = {
 	.read_event_value = &ad7291_read_event_value,
 	.write_event_value = &ad7291_write_event_value,
 	.event_attrs = &ad7291_event_attribute_group,
+	.driver_module = THIS_MODULE,
 };
 
 static int ad7291_probe(struct i2c_client *client,
