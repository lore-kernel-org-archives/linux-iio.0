Return-Path: <SRS0=r0Dv=BZ=users.sourceforge.net=elfring@kernel.org>
To: linux-iio@vger.kernel.org, Andreas Dannenberg <dannenberg@ti.com>,
 Felipe Balbi <balbi@ti.com>, Hartmut Knaack <knaack.h@gmx.de>,
 Javier Martinez Canillas <javier@osg.samsung.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] iio/light/opt3001: Use common error handling code in
 opt3001_get_lux()
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Message-ID: <c0b3ce73-db0d-c481-51be-2047b07c9f63@users.sourceforge.net>
Date: Thu, 26 Oct 2017 14:17:30 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 26 Oct 2017 14:06:49 +0200

* Add jump targets so that two error messages are stored only once
  at the end of this function implementation.

* Adjust condition checks.

* Replace string literals by references to two global constant variables
  in eight functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/iio/light/opt3001.c | 88 +++++++++++++++++++--------------------------
 1 file changed, 36 insertions(+), 52 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 54d88b60e303..23d7d4e6ae61 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -77,6 +77,9 @@
 #define OPT3001_RESULT_READY_SHORT	150
 #define OPT3001_RESULT_READY_LONG	1000
 
+static char const read_failure[] = "failed to read register %02x\n";
+static char const write_failure[] = "failed to write register %02x\n";
+
 struct opt3001 {
 	struct i2c_client	*client;
 	struct device		*dev;
@@ -246,11 +249,8 @@ static int opt3001_get_lux(struct opt3001 *opt, int *val, int *val2)
 		ret = i2c_smbus_write_word_swapped(opt->client,
 					OPT3001_LOW_LIMIT,
 					OPT3001_LOW_LIMIT_EOC_ENABLE);
-		if (ret < 0) {
-			dev_err(opt->dev, "failed to write register %02x\n",
-					OPT3001_LOW_LIMIT);
-			return ret;
-		}
+		if (ret)
+			goto report_write_failure;
 
 		/* Allow IRQ to access the device despite lock being set */
 		opt->ok_to_ignore_lock = true;
@@ -261,20 +261,16 @@ static int opt3001_get_lux(struct opt3001 *opt, int *val, int *val2)
 
 	/* Configure for single-conversion mode and start a new conversion */
 	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
-	if (ret < 0) {
-		dev_err(opt->dev, "failed to read register %02x\n",
-				OPT3001_CONFIGURATION);
-		goto err;
-	}
+	if (ret < 0)
+		goto report_read_failure;
 
 	reg = ret;
 	opt3001_set_mode(opt, &reg, OPT3001_CONFIGURATION_M_SINGLE);
 
 	ret = i2c_smbus_write_word_swapped(opt->client, OPT3001_CONFIGURATION,
 			reg);
-	if (ret < 0) {
-		dev_err(opt->dev, "failed to write register %02x\n",
-				OPT3001_CONFIGURATION);
+	if (ret) {
+		dev_err(opt->dev, write_failure, OPT3001_CONFIGURATION);
 		goto err;
 	}
 
@@ -292,11 +288,8 @@ static int opt3001_get_lux(struct opt3001 *opt, int *val, int *val2)
 		/* Check result ready flag */
 		ret = i2c_smbus_read_word_swapped(opt->client,
 						  OPT3001_CONFIGURATION);
-		if (ret < 0) {
-			dev_err(opt->dev, "failed to read register %02x\n",
-				OPT3001_CONFIGURATION);
-			goto err;
-		}
+		if (ret < 0)
+			goto report_read_failure;
 
 		if (!(ret & OPT3001_CONFIGURATION_CRF)) {
 			ret = -ETIMEDOUT;
@@ -306,8 +299,7 @@ static int opt3001_get_lux(struct opt3001 *opt, int *val, int *val2)
 		/* Obtain value */
 		ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_RESULT);
 		if (ret < 0) {
-			dev_err(opt->dev, "failed to read register %02x\n",
-				OPT3001_RESULT);
+			dev_err(opt->dev, read_failure, OPT3001_RESULT);
 			goto err;
 		}
 		opt->result = ret;
@@ -336,11 +328,8 @@ static int opt3001_get_lux(struct opt3001 *opt, int *val, int *val2)
 		ret = i2c_smbus_write_word_swapped(opt->client,
 						   OPT3001_LOW_LIMIT,
 						   value);
-		if (ret < 0) {
-			dev_err(opt->dev, "failed to write register %02x\n",
-					OPT3001_LOW_LIMIT);
-			return ret;
-		}
+		if (ret)
+			goto report_write_failure;
 	}
 
 	exponent = OPT3001_REG_EXPONENT(opt->result);
@@ -349,6 +338,14 @@ static int opt3001_get_lux(struct opt3001 *opt, int *val, int *val2)
 	opt3001_to_iio_ret(opt, exponent, mantissa, val, val2);
 
 	return IIO_VAL_INT_PLUS_MICRO;
+
+report_read_failure:
+	dev_err(opt->dev, read_failure, OPT3001_CONFIGURATION);
+	goto err;
+
+report_write_failure:
+	dev_err(opt->dev, write_failure, OPT3001_LOW_LIMIT);
+	return ret;
 }
 
 static int opt3001_get_int_time(struct opt3001 *opt, int *val, int *val2)
@@ -366,8 +363,7 @@ static int opt3001_set_int_time(struct opt3001 *opt, int time)
 
 	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
 	if (ret < 0) {
-		dev_err(opt->dev, "failed to read register %02x\n",
-				OPT3001_CONFIGURATION);
+		dev_err(opt->dev, read_failure, OPT3001_CONFIGURATION);
 		return ret;
 	}
 
@@ -521,7 +517,7 @@ static int opt3001_write_event_value(struct iio_dev *iio,
 
 	ret = i2c_smbus_write_word_swapped(opt->client, reg, value);
 	if (ret < 0) {
-		dev_err(opt->dev, "failed to write register %02x\n", reg);
+		dev_err(opt->dev, write_failure, reg);
 		goto err;
 	}
 
@@ -562,8 +558,7 @@ static int opt3001_write_event_config(struct iio_dev *iio,
 
 	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
 	if (ret < 0) {
-		dev_err(opt->dev, "failed to read register %02x\n",
-				OPT3001_CONFIGURATION);
+		dev_err(opt->dev, read_failure, OPT3001_CONFIGURATION);
 		goto err;
 	}
 
@@ -573,8 +568,7 @@ static int opt3001_write_event_config(struct iio_dev *iio,
 	ret = i2c_smbus_write_word_swapped(opt->client, OPT3001_CONFIGURATION,
 			reg);
 	if (ret < 0) {
-		dev_err(opt->dev, "failed to write register %02x\n",
-				OPT3001_CONFIGURATION);
+		dev_err(opt->dev, write_failure, OPT3001_CONFIGURATION);
 		goto err;
 	}
 
@@ -602,8 +596,7 @@ static int opt3001_read_id(struct opt3001 *opt)
 
 	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_MANUFACTURER_ID);
 	if (ret < 0) {
-		dev_err(opt->dev, "failed to read register %02x\n",
-				OPT3001_MANUFACTURER_ID);
+		dev_err(opt->dev, read_failure, OPT3001_MANUFACTURER_ID);
 		return ret;
 	}
 
@@ -612,8 +605,7 @@ static int opt3001_read_id(struct opt3001 *opt)
 
 	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_DEVICE_ID);
 	if (ret < 0) {
-		dev_err(opt->dev, "failed to read register %02x\n",
-				OPT3001_DEVICE_ID);
+		dev_err(opt->dev, read_failure, OPT3001_DEVICE_ID);
 		return ret;
 	}
 
@@ -632,8 +624,7 @@ static int opt3001_configure(struct opt3001 *opt)
 
 	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
 	if (ret < 0) {
-		dev_err(opt->dev, "failed to read register %02x\n",
-				OPT3001_CONFIGURATION);
+		dev_err(opt->dev, read_failure, OPT3001_CONFIGURATION);
 		return ret;
 	}
 
@@ -661,15 +652,13 @@ static int opt3001_configure(struct opt3001 *opt)
 	ret = i2c_smbus_write_word_swapped(opt->client, OPT3001_CONFIGURATION,
 			reg);
 	if (ret < 0) {
-		dev_err(opt->dev, "failed to write register %02x\n",
-				OPT3001_CONFIGURATION);
+		dev_err(opt->dev, write_failure, OPT3001_CONFIGURATION);
 		return ret;
 	}
 
 	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_LOW_LIMIT);
 	if (ret < 0) {
-		dev_err(opt->dev, "failed to read register %02x\n",
-				OPT3001_LOW_LIMIT);
+		dev_err(opt->dev, read_failure, OPT3001_LOW_LIMIT);
 		return ret;
 	}
 
@@ -678,8 +667,7 @@ static int opt3001_configure(struct opt3001 *opt)
 
 	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_HIGH_LIMIT);
 	if (ret < 0) {
-		dev_err(opt->dev, "failed to read register %02x\n",
-				OPT3001_HIGH_LIMIT);
+		dev_err(opt->dev, read_failure, OPT3001_HIGH_LIMIT);
 		return ret;
 	}
 
@@ -700,8 +688,7 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
 
 	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
 	if (ret < 0) {
-		dev_err(opt->dev, "failed to read register %02x\n",
-				OPT3001_CONFIGURATION);
+		dev_err(opt->dev, read_failure, OPT3001_CONFIGURATION);
 		goto out;
 	}
 
@@ -722,8 +709,7 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
 	} else if (ret & OPT3001_CONFIGURATION_CRF) {
 		ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_RESULT);
 		if (ret < 0) {
-			dev_err(opt->dev, "failed to read register %02x\n",
-					OPT3001_RESULT);
+			dev_err(opt->dev, read_failure, OPT3001_RESULT);
 			goto out;
 		}
 		opt->result = ret;
@@ -810,8 +796,7 @@ static int opt3001_remove(struct i2c_client *client)
 
 	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
 	if (ret < 0) {
-		dev_err(opt->dev, "failed to read register %02x\n",
-				OPT3001_CONFIGURATION);
+		dev_err(opt->dev, read_failure, OPT3001_CONFIGURATION);
 		return ret;
 	}
 
@@ -821,8 +806,7 @@ static int opt3001_remove(struct i2c_client *client)
 	ret = i2c_smbus_write_word_swapped(opt->client, OPT3001_CONFIGURATION,
 			reg);
 	if (ret < 0) {
-		dev_err(opt->dev, "failed to write register %02x\n",
-				OPT3001_CONFIGURATION);
+		dev_err(opt->dev, write_failure, OPT3001_CONFIGURATION);
 		return ret;
 	}
 
-- 
2.14.3
