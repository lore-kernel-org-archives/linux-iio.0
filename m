Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 49/50] staging:iio:light:tsl2583 allocate chip state with iio_dev
Date: Fri, 27 May 2011 19:36:29 +0100
Message-Id: <1306521390-24897-50-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
References: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

There are some unusual corners in the probe function of this
driver, so may need another look.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/light/tsl2583.c |   82 +++++++++++++++-------------------
 1 files changed, 36 insertions(+), 46 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 5694610..f5ab6f5 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -87,7 +87,6 @@ struct taos_settings {
 struct tsl2583_chip {
 	struct mutex als_mutex;
 	struct i2c_client *client;
-	struct iio_dev *iio_dev;
 	struct taos_als_info als_cur_info;
 	struct taos_settings taos_settings;
 	int als_time_scale;
@@ -467,7 +466,7 @@ static ssize_t taos_device_id(struct device *dev,
 struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2583_chip *chip = indio_dev->dev_data;
+	struct tsl2583_chip *chip = iio_priv(indio_dev);
 
 	return sprintf(buf, "%s\n", chip->client->name);
 }
@@ -476,7 +475,7 @@ static ssize_t taos_power_state_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2583_chip *chip = indio_dev->dev_data;
+	struct tsl2583_chip *chip = iio_priv(indio_dev);
 
 	return sprintf(buf, "%d\n", chip->taos_chip_status);
 }
@@ -485,7 +484,7 @@ static ssize_t taos_power_state_store(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2583_chip *chip = indio_dev->dev_data;
+	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	unsigned long value;
 
 	if (strict_strtoul(buf, 0, &value))
@@ -503,7 +502,7 @@ static ssize_t taos_gain_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2583_chip *chip = indio_dev->dev_data;
+	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	char gain[4] = {0};
 
 	switch (chip->taos_settings.als_gain) {
@@ -528,7 +527,7 @@ static ssize_t taos_gain_store(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2583_chip *chip = indio_dev->dev_data;
+	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	unsigned long value;
 
 	if (strict_strtoul(buf, 0, &value))
@@ -565,7 +564,7 @@ static ssize_t taos_als_time_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2583_chip *chip = indio_dev->dev_data;
+	struct tsl2583_chip *chip = iio_priv(indio_dev);
 
 	return sprintf(buf, "%d\n", chip->taos_settings.als_time);
 }
@@ -574,7 +573,7 @@ static ssize_t taos_als_time_store(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2583_chip *chip = indio_dev->dev_data;
+	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	unsigned long value;
 
 	if (strict_strtoul(buf, 0, &value))
@@ -602,7 +601,7 @@ static ssize_t taos_als_trim_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2583_chip *chip = indio_dev->dev_data;
+	struct tsl2583_chip *chip = iio_priv(indio_dev);
 
 	return sprintf(buf, "%d\n", chip->taos_settings.als_gain_trim);
 }
@@ -611,7 +610,7 @@ static ssize_t taos_als_trim_store(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2583_chip *chip = indio_dev->dev_data;
+	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	unsigned long value;
 
 	if (strict_strtoul(buf, 0, &value))
@@ -627,7 +626,7 @@ static ssize_t taos_als_cal_target_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2583_chip *chip = indio_dev->dev_data;
+	struct tsl2583_chip *chip = iio_priv(indio_dev);
 
 	return sprintf(buf, "%d\n", chip->taos_settings.als_cal_target);
 }
@@ -636,7 +635,7 @@ static ssize_t taos_als_cal_target_store(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2583_chip *chip = indio_dev->dev_data;
+	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	unsigned long value;
 
 	if (strict_strtoul(buf, 0, &value))
@@ -652,7 +651,7 @@ static ssize_t taos_lux_show(struct device *dev, struct device_attribute *attr,
 	char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2583_chip *chip = indio_dev->dev_data;
+	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	int lux;
 
 	lux = taos_get_lux(chip->client);
@@ -664,7 +663,7 @@ static ssize_t taos_do_calibrate(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2583_chip *chip = indio_dev->dev_data;
+	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	unsigned long value;
 
 	if (strict_strtoul(buf, 0, &value))
@@ -703,7 +702,7 @@ static ssize_t taos_luxtable_store(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct tsl2583_chip *chip = indio_dev->dev_data;
+	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	int value[ARRAY_SIZE(taos_device_lux)];
 	int n;
 
@@ -800,7 +799,8 @@ static int __devinit taos_probe(struct i2c_client *clientp,
 {
 	int i, ret = 0;
 	unsigned char buf[TSL258X_MAX_DEVICE_REGS];
-	static struct tsl2583_chip *chip;
+	struct tsl2583_chip *chip;
+	struct iio_dev *indio_dev;
 
 	if (!i2c_check_functionality(clientp->adapter,
 		I2C_FUNC_SMBUS_BYTE_DATA)) {
@@ -810,12 +810,15 @@ static int __devinit taos_probe(struct i2c_client *clientp,
 		return -EOPNOTSUPP;
 	}
 
-	chip = kzalloc(sizeof(struct tsl2583_chip), GFP_KERNEL);
-	if (!chip)
-		return -ENOMEM;
-
+	indio_dev = iio_allocate_device(sizeof(*chip));
+	if (indio_dev) {
+		ret = -ENOMEM;
+		dev_err(&clientp->dev, "iio allocation failed\n");
+		goto fail1;
+	}
+	chip = iio_priv(indio_dev);
 	chip->client = clientp;
-	i2c_set_clientdata(clientp, chip);
+	i2c_set_clientdata(clientp, indio_dev);
 
 	mutex_init(&chip->als_mutex);
 	chip->taos_chip_status = TSL258X_CHIP_UNKNOWN;
@@ -827,14 +830,14 @@ static int __devinit taos_probe(struct i2c_client *clientp,
 		if (ret < 0) {
 			dev_err(&clientp->dev, "i2c_smbus_write_bytes() to cmd "
 				"reg failed in taos_probe(), err = %d\n", ret);
-			goto fail1;
+			goto fail2;
 		}
 		ret = i2c_smbus_read_byte(clientp);
 		if (ret < 0) {
 			dev_err(&clientp->dev, "i2c_smbus_read_byte from "
 				"reg failed in taos_probe(), err = %d\n", ret);
 
-			goto fail1;
+			goto fail2;
 		}
 		buf[i] = ret;
 	}
@@ -842,31 +845,23 @@ static int __devinit taos_probe(struct i2c_client *clientp,
 	if (!taos_tsl258x_device(buf)) {
 		dev_info(&clientp->dev, "i2c device found but does not match "
 			"expected id in taos_probe()\n");
-		goto fail1;
+		goto fail2;
 	}
 
 	ret = i2c_smbus_write_byte(clientp, (TSL258X_CMD_REG | TSL258X_CNTRL));
 	if (ret < 0) {
 		dev_err(&clientp->dev, "i2c_smbus_write_byte() to cmd reg "
 			"failed in taos_probe(), err = %d\n", ret);
-		goto fail1;
-	}
-
-	chip->iio_dev = iio_allocate_device(0);
-	if (!chip->iio_dev) {
-		ret = -ENOMEM;
-		dev_err(&clientp->dev, "iio allocation failed\n");
-		goto fail1;
+		goto fail2;
 	}
 
-	chip->iio_dev->info = &tsl2583_info;
-	chip->iio_dev->dev.parent = &clientp->dev;
-	chip->iio_dev->dev_data = (void *)(chip);
-	chip->iio_dev->modes = INDIO_DIRECT_MODE;
-	ret = iio_device_register(chip->iio_dev);
+	indio_dev->info = &tsl2583_info;
+	indio_dev->dev.parent = &clientp->dev;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	ret = iio_device_register(indio_dev);
 	if (ret) {
 		dev_err(&clientp->dev, "iio registration failed\n");
-		goto fail1;
+		goto fail2;
 	}
 
 	/* Load up the V2 defaults (these are hard coded defaults for now) */
@@ -876,12 +871,10 @@ static int __devinit taos_probe(struct i2c_client *clientp,
 	taos_chip_on(clientp);
 
 	dev_info(&clientp->dev, "Light sensor found.\n");
-
 	return 0;
-
 fail1:
-	kfree(chip);
-
+	iio_free_device(indio_dev);
+fail2:
 	return ret;
 }
 
@@ -918,11 +911,8 @@ static int taos_resume(struct i2c_client *client)
 
 static int __devexit taos_remove(struct i2c_client *client)
 {
-	struct tsl2583_chip *chip = i2c_get_clientdata(client);
-
-	iio_device_unregister(chip->iio_dev);
+	iio_device_unregister(i2c_get_clientdata(client));
 
-	kfree(chip);
 	return 0;
 }
 
-- 
1.7.3.4
