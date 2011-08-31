Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 11/12] iio: ad7291: reset device and setup irq before it is enabled
Date: Wed, 31 Aug 2011 12:57:39 +0200
Message-ID: <1314788260-5791-11-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1314788260-5791-1-git-send-email-michael.hennerich@analog.com>
References: <1314788260-5791-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>


Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/ad7291.c |   27 ++++++++++++++++-----------
 1 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index 334951c..0811c5e 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -589,8 +589,10 @@ static int __devinit ad7291_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, indio_dev);
 
 	chip->client = client;
-	/* Tsense always enabled */
-	chip->command = AD7291_NOISE_DELAY | AD7291_T_SENSE_MASK;
+
+	chip->command = AD7291_NOISE_DELAY |
+			AD7291_T_SENSE_MASK | /* Tsense always enabled */
+			AD7291_ALERT_POLARITY; /* set irq polarity low level */
 
 	if (voltage_uv) {
 		chip->int_vref_mv = voltage_uv / 1000;
@@ -607,6 +609,18 @@ static int __devinit ad7291_probe(struct i2c_client *client,
 	indio_dev->info = &ad7291_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
+	ret = ad7291_i2c_write(chip, AD7291_COMMAND, AD7291_RESET);
+	if (ret) {
+		ret = -EIO;
+		goto error_disable_reg;
+	}
+
+	ret = ad7291_i2c_write(chip, AD7291_COMMAND, chip->command);
+	if (ret) {
+		ret = -EIO;
+		goto error_disable_reg;
+	}
+
 	if (client->irq > 0) {
 		ret = request_threaded_irq(client->irq,
 					   NULL,
@@ -616,15 +630,6 @@ static int __devinit ad7291_probe(struct i2c_client *client,
 					   indio_dev);
 		if (ret)
 			goto error_disable_reg;
-
-		/* set irq polarity low level */
-		chip->command |= AD7291_ALERT_POLARITY;
-	}
-
-	ret = ad7291_i2c_write(chip, AD7291_COMMAND, chip->command);
-	if (ret) {
-		ret = -EIO;
-		goto error_unreg_irq;
 	}
 
 	ret = iio_device_register(indio_dev);
-- 
1.7.0.4
