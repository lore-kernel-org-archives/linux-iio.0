Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36908 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756061AbbKROjE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Nov 2015 09:39:04 -0500
Received: by wmww144 with SMTP id w144so75003920wmw.0
        for <linux-iio@vger.kernel.org>; Wed, 18 Nov 2015 06:39:03 -0800 (PST)
From: Marc Titinger <mtitinger@baylibre.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: daniel.baluta@intel.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, Marc Titinger <mtitinger@baylibre.com>
Subject: [RFC 9/9] iio: (RFC) illustrate creation/destruction of hrtimer trigger upon buffer enable
Date: Wed, 18 Nov 2015 15:38:35 +0100
Message-Id: <1447857515-23935-10-git-send-email-mtitinger@baylibre.com>
In-Reply-To: <1447857515-23935-1-git-send-email-mtitinger@baylibre.com>
References: <1447857515-23935-1-git-send-email-mtitinger@baylibre.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This also raises the question of how to programmatically set the period of
the hrtimer from the owner driver, I had to locally copy iio_hrtimer_info
Maybe this should go to linux/iio/hrtimer_trigger.h ?

Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
---
 drivers/iio/adc/ina2xx-iio.c | 74 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ina2xx-iio.c b/drivers/iio/adc/ina2xx-iio.c
index e47f30d..5f61296b 100644
--- a/drivers/iio/adc/ina2xx-iio.c
+++ b/drivers/iio/adc/ina2xx-iio.c
@@ -19,6 +19,7 @@
  *
  * Configurable 7-bit I2C slave address from 0x40 to 0x4F
  */
+
 #include <linux/module.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -32,6 +33,10 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
+#include <linux/iio/trigger.h>
+#include <linux/iio/sw_trigger.h>
+
+
 /*
  * INA2XX registers definition
  */
@@ -96,6 +101,7 @@ struct ina2xx_config {
 
 struct ina2xx_chip_info {
 	const struct ina2xx_config *config;
+	struct iio_sw_trigger *swtrig;
 	struct mutex state_lock;
 	long rshunt;
 	int avg;
@@ -283,6 +289,11 @@ static int ina2xx_write_raw(struct iio_dev *indio_dev,
 
 	mutex_lock(&chip->state_lock);
 
+	if (iio_buffer_enabled(indio_dev)) {
+		ret = -EBUSY;
+		goto _err;
+	}
+
 	ret = regmap_read(chip->regmap, INA2XX_CONFIG, &config);
 	if (ret < 0)
 		goto _err;
@@ -316,6 +327,13 @@ _err:
 	return ret;
 }
 
+/* FIXME */
+struct iio_hrtimer_info {
+        struct iio_sw_trigger swt;
+        struct hrtimer timer;
+        unsigned long sampling_frequency;
+        ktime_t period;
+};
 
 static ssize_t ina2xx_averaging_steps_show(struct device *dev,
 					   struct device_attribute *attr,
@@ -387,6 +405,7 @@ static int ina2xx_debug_reg(struct iio_dev *indio_dev,
 	return regmap_read(chip->regmap, reg, readval);
 }
 
+
 static s64 prev_ns;
 
 static irqreturn_t ina2xx_trigger_handler(int irq, void *p)
@@ -478,6 +497,58 @@ static int ina2xx_init(struct ina2xx_chip_info *chip, unsigned int config)
 	return ina2xx_calibrate(chip);
 }
 
+
+static int ina2xx_trigger_create(struct iio_dev *indio_dev)
+{
+	struct iio_sw_trigger *swtrig;
+	struct iio_hrtimer_info *info;
+	struct ina2xx_chip_info *chip = iio_priv(indio_dev);
+
+	swtrig = iio_sw_trigger_create("hrtimer", indio_dev->name);
+	if (IS_ERR(swtrig))
+		return -EINVAL;
+
+	info = iio_trigger_get_drvdata(swtrig->trigger);
+
+	mutex_lock(&chip->state_lock);
+
+	info->sampling_frequency = chip->freq;
+	info->period = ktime_set(0, NSEC_PER_SEC / chip->freq);
+
+	chip->swtrig = swtrig;
+	indio_dev->trig = swtrig->trigger;
+
+	mutex_unlock(&chip->state_lock);
+
+	iio_trigger_get(indio_dev->trig);
+
+	return 0;
+}
+
+int ina2xx_trigger_destroy(struct iio_dev *indio_dev)
+{
+	struct ina2xx_chip_info *chip = iio_priv(indio_dev);
+
+	mutex_lock(&chip->state_lock);
+
+	iio_trigger_put(indio_dev->trig);
+	iio_sw_trigger_destroy(chip->swtrig);
+
+	indio_dev->trig = NULL;
+
+	mutex_unlock(&chip->state_lock);
+
+	return 0;
+}
+
+
+static const struct iio_buffer_setup_ops ina2xx_buffer_setup_ops = {
+	.enable_trigger = &ina2xx_trigger_create,
+	.postenable = &iio_triggered_buffer_postenable,
+	.predisable = &iio_triggered_buffer_predisable,
+	.postdisable = &ina2xx_trigger_destroy,
+};
+
 static int ina2xx_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -547,7 +618,8 @@ static int ina2xx_probe(struct i2c_client *client,
 	}
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-					&ina2xx_trigger_handler, NULL);
+					&ina2xx_trigger_handler,
+					&ina2xx_buffer_setup_ops);
 	if (ret)
 		return ret;
 
-- 
1.9.1

