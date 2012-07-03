Return-Path: <sha@pengutronix.de>
From: Sascha Hauer <s.hauer@pengutronix.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
	Sonic Zhang <sonic.zhang@analog.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 3/3] staging iio adt7410: make 16bit mode default
Date: Tue,  3 Jul 2012 11:21:28 +0200
Message-Id: <1341307288-1926-4-git-send-email-s.hauer@pengutronix.de>
In-Reply-To: <1341307288-1926-1-git-send-email-s.hauer@pengutronix.de>
References: <1341307288-1926-1-git-send-email-s.hauer@pengutronix.de>
List-ID: <linux-iio@vger.kernel.org>

In 13bit mode the lower three bits of the adc value contain
flags. The driver does not use these flags at all, so make 16bit
mode the default.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/staging/iio/adc/adt7410.c |   24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/adc/adt7410.c b/drivers/staging/iio/adc/adt7410.c
index f9188e5..f8dd567 100644
--- a/drivers/staging/iio/adc/adt7410.c
+++ b/drivers/staging/iio/adc/adt7410.c
@@ -756,13 +756,15 @@ static int __devinit adt7410_probe(struct i2c_client *client,
 			goto error_unreg_ct_irq;
 	}
 
-	if (client->irq && adt7410_platform_data[0]) {
+	ret = adt7410_i2c_read_byte(chip, ADT7410_CONFIG, &chip->config);
+	if (ret) {
+		ret = -EIO;
+		goto error_unreg_int_irq;
+	}
 
-		ret = adt7410_i2c_read_byte(chip, ADT7410_CONFIG, &chip->config);
-		if (ret) {
-			ret = -EIO;
-			goto error_unreg_int_irq;
-		}
+	chip->config |= ADT7410_RESOLUTION;
+
+	if (client->irq && adt7410_platform_data[0]) {
 
 		/* set irq polarity low level */
 		chip->config &= ~ADT7410_CT_POLARITY;
@@ -771,12 +773,12 @@ static int __devinit adt7410_probe(struct i2c_client *client,
 			chip->config |= ADT7410_INT_POLARITY;
 		else
 			chip->config &= ~ADT7410_INT_POLARITY;
+	}
 
-		ret = adt7410_i2c_write_byte(chip, ADT7410_CONFIG, chip->config);
-		if (ret) {
-			ret = -EIO;
-			goto error_unreg_int_irq;
-		}
+	ret = adt7410_i2c_write_byte(chip, ADT7410_CONFIG, chip->config);
+	if (ret) {
+		ret = -EIO;
+		goto error_unreg_int_irq;
 	}
 	ret = iio_device_register(indio_dev);
 	if (ret)
-- 
1.7.10
