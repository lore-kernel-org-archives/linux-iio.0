Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35968 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755319AbbLKQt3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 Dec 2015 11:49:29 -0500
Received: by mail-wm0-f51.google.com with SMTP id n186so38195424wmn.1
        for <linux-iio@vger.kernel.org>; Fri, 11 Dec 2015 08:49:29 -0800 (PST)
From: Marc Titinger <mtitinger@baylibre.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marc Titinger <mtitinger@baylibre.com>
Subject: [PATCH 1/3] iio: ina2xx: re-instate a sysfs show/store for the shunt resistor value
Date: Fri, 11 Dec 2015 17:49:15 +0100
Message-Id: <1449852557-3138-1-git-send-email-mtitinger@baylibre.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Different probe modules use different resistor values. The front-end
application may read a probe ID (from eeprom) and set the shunt value
accordingly.

Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
---
 drivers/iio/adc/ina2xx-adc.c | 52 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 615c203..fe42872 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -106,7 +106,7 @@ struct ina2xx_chip_info {
 	struct task_struct *task;
 	const struct ina2xx_config *config;
 	struct mutex state_lock;
-	long rshunt;
+	unsigned int shunt_resistor;
 	int avg;
 	s64 prev_ns;	/* track buffer capture time, check for underruns*/
 	int int_time_vbus; /* Bus voltage integration time uS */
@@ -353,6 +353,42 @@ static ssize_t ina2xx_allow_async_readout_store(struct device *dev,
 	return len;
 }
 
+static int set_shunt_resistor(struct ina2xx_chip_info *chip, unsigned int val)
+{
+	if (val <= 0 || val > chip->config->calibration_factor)
+		return -EINVAL;
+
+	chip->shunt_resistor = val;
+	return 0;
+}
+
+static ssize_t ina2xx_shunt_resistor_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct ina2xx_chip_info *chip = iio_priv(dev_to_iio_dev(dev));
+
+	return sprintf(buf, "%d\n", chip->shunt_resistor);
+}
+
+static ssize_t ina2xx_shunt_resistor_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t len)
+{
+	struct ina2xx_chip_info *chip = iio_priv(dev_to_iio_dev(dev));
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul((const char *) buf, 10, &val);
+	if (ret)
+		return ret;
+
+	ret = set_shunt_resistor(chip, val);
+	if (ret)
+		return ret;
+
+	return len;
+}
 
 #define INA2XX_CHAN(_type, _index, _address) { \
 	.type = (_type), \
@@ -547,9 +583,14 @@ static IIO_DEVICE_ATTR(in_allow_async_readout, S_IRUGO | S_IWUSR,
 		       ina2xx_allow_async_readout_show,
 		       ina2xx_allow_async_readout_store, 0);
 
+static IIO_DEVICE_ATTR(in_shunt_resistor, S_IRUGO | S_IWUSR,
+		       ina2xx_shunt_resistor_show,
+		       ina2xx_shunt_resistor_store, 0);
+
 static struct attribute *ina2xx_attributes[] = {
 	&iio_dev_attr_in_allow_async_readout.dev_attr.attr,
 	&iio_const_attr_integration_time_available.dev_attr.attr,
+	&iio_dev_attr_in_shunt_resistor.dev_attr.attr,
 	NULL,
 };
 
@@ -581,7 +622,7 @@ static int ina2xx_init(struct ina2xx_chip_info *chip, unsigned int config)
 	 * to the user for now.
 	 */
 	regval = DIV_ROUND_CLOSEST(chip->config->calibration_factor,
-			    chip->rshunt);
+			    chip->shunt_resistor);
 
 	return regmap_write(chip->regmap, INA2XX_CALIBRATION, regval);
 }
@@ -614,10 +655,9 @@ static int ina2xx_probe(struct i2c_client *client,
 			val = INA2XX_RSHUNT_DEFAULT;
 	}
 
-	if (val <= 0 || val > chip->config->calibration_factor)
-		return -ENODEV;
-
-	chip->rshunt = val;
+	ret = set_shunt_resistor(chip, val);
+	if (ret)
+		return ret;
 
 	mutex_init(&chip->state_lock);
 
-- 
1.9.1

