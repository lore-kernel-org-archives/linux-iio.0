Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-136.synserver.de ([212.40.185.136]:1040 "EHLO
	smtp-out-134.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752169Ab3FNP6j (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 14 Jun 2013 11:58:39 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 7/7] staging:iio:ad7291: Rework regulator handling
Date: Fri, 14 Jun 2013 17:58:28 +0200
Message-Id: <1371225508-32190-7-git-send-email-lars@metafoo.de>
In-Reply-To: <1371225508-32190-1-git-send-email-lars@metafoo.de>
References: <1371225508-32190-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add platform_data for the driver which allows to specify whether an external
reference voltage is used or not. It is not possible to use the return value of
regulator_get() for this since the regulator framework is able to return a dummy
regulator in case no regulator has been specified. In this case the driver will
always get a valid regulator, no matter if it has been specified or not.  Also
make the regulator non-optional if platform_data states that an external
reference voltage should be used.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7291.c | 38 +++++++++++++++++++++++---------------
 drivers/staging/iio/adc/ad7291.h | 12 ++++++++++++
 2 files changed, 35 insertions(+), 15 deletions(-)
 create mode 100644 drivers/staging/iio/adc/ad7291.h

diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index c2709d6..3fc79e5 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -21,6 +21,8 @@
 #include <linux/iio/sysfs.h>
 #include <linux/iio/events.h>
 
+#include "ad7291.h"
+
 /*
  * Simplified handling
  *
@@ -76,7 +78,6 @@
 struct ad7291_chip_info {
 	struct i2c_client	*client;
 	struct regulator	*reg;
-	u16			int_vref_mv;
 	u16			command;
 	u16			c_mask;	/* Active voltage channels for events */
 	struct mutex		state_lock;
@@ -445,7 +446,15 @@ static int ad7291_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_VOLTAGE:
-			*val = chip->int_vref_mv;
+			if (chip->reg) {
+				int vref;
+				vref = regulator_get_voltage(chip->reg);
+				if (vref < 0)
+					return vref;
+				*val = vref / 1000;
+			} else {
+				*val = 2500;
+			}
 			*val2 = AD7291_BITS;
 			return IIO_VAL_FRACTIONAL_LOG2;
 		case IIO_TEMP:
@@ -513,9 +522,10 @@ static const struct iio_info ad7291_info = {
 static int ad7291_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
+	struct ad7291_platform_data *pdata = client->dev.platform_data;
 	struct ad7291_chip_info *chip;
 	struct iio_dev *indio_dev;
-	int ret = 0, voltage_uv = 0;
+	int ret = 0;
 
 	indio_dev = iio_device_alloc(sizeof(*chip));
 	if (indio_dev == NULL) {
@@ -524,12 +534,14 @@ static int ad7291_probe(struct i2c_client *client,
 	}
 	chip = iio_priv(indio_dev);
 
-	chip->reg = regulator_get(&client->dev, "vcc");
-	if (!IS_ERR(chip->reg)) {
+	if (pdata && pdata->use_external_ref) {
+		chip->reg = regulator_get(&client->dev, "vref");
+		if (IS_ERR(chip->reg))
+			goto error_free;
+
 		ret = regulator_enable(chip->reg);
 		if (ret)
 			goto error_put_reg;
-		voltage_uv = regulator_get_voltage(chip->reg);
 	}
 
 	mutex_init(&chip->state_lock);
@@ -542,12 +554,8 @@ static int ad7291_probe(struct i2c_client *client,
 			AD7291_T_SENSE_MASK | /* Tsense always enabled */
 			AD7291_ALERT_POLARITY; /* set irq polarity low level */
 
-	if (voltage_uv) {
-		chip->int_vref_mv = voltage_uv / 1000;
+	if (pdata && pdata->use_external_ref)
 		chip->command |= AD7291_EXT_REF;
-	} else {
-		chip->int_vref_mv = 2500; /* Build-in ref */
-	}
 
 	indio_dev->name = id->name;
 	indio_dev->channels = ad7291_channels;
@@ -590,12 +598,12 @@ error_unreg_irq:
 	if (client->irq)
 		free_irq(client->irq, indio_dev);
 error_disable_reg:
-	if (!IS_ERR(chip->reg))
+	if (chip->reg)
 		regulator_disable(chip->reg);
 error_put_reg:
-	if (!IS_ERR(chip->reg))
+	if (chip->reg)
 		regulator_put(chip->reg);
-
+error_free:
 	iio_device_free(indio_dev);
 error_ret:
 	return ret;
@@ -611,7 +619,7 @@ static int ad7291_remove(struct i2c_client *client)
 	if (client->irq)
 		free_irq(client->irq, indio_dev);
 
-	if (!IS_ERR(chip->reg)) {
+	if (chip->reg) {
 		regulator_disable(chip->reg);
 		regulator_put(chip->reg);
 	}
diff --git a/drivers/staging/iio/adc/ad7291.h b/drivers/staging/iio/adc/ad7291.h
new file mode 100644
index 0000000..bbd89fa
--- /dev/null
+++ b/drivers/staging/iio/adc/ad7291.h
@@ -0,0 +1,12 @@
+#ifndef __IIO_AD7291_H__
+#define __IIO_AD7291_H__
+
+/**
+ * struct ad7291_platform_data - AD7291 platform data
+ * @use_external_ref: Whether to use an external or internal reference voltage
+ */
+struct ad7291_platform_data {
+	bool use_external_ref;
+};
+
+#endif
-- 
1.8.0

