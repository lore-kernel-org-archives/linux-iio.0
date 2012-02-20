Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-028.synserver.de ([212.40.185.28]:1077 "EHLO
	smtp-out-025.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752327Ab2BTSfw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 20 Feb 2012 13:35:52 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@kernel.org>, devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] staging:iio: Use dev_pm_ops
Date: Mon, 20 Feb 2012 19:37:05 +0100
Message-Id: <1329763025-29730-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use dev_pm_ops instead of legacy suspend/resume callbacks for IIO drivers.

Note that this patch introduces a few new #ifdef CONFIG_PM_SLEEP around the
suspend and resume callbacks to avoid warnings of unused functions if
CONFIG_PM_SLEEP is not defined.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>

---
Mostly only compile tested (With CONFIG_PM_SLEEP and without CONFIG_PM_SLEEP
though).
---
 drivers/staging/iio/addac/adt7316-i2c.c    |   18 +-----------------
 drivers/staging/iio/addac/adt7316-spi.c    |   18 +-----------------
 drivers/staging/iio/addac/adt7316.c        |   11 ++++++-----
 drivers/staging/iio/addac/adt7316.h        |    9 ++++++---
 drivers/staging/iio/dac/max517.c           |   18 ++++++++++++------
 drivers/staging/iio/light/tsl2563.c        |   26 ++++++++++++++++----------
 drivers/staging/iio/light/tsl2583.c        |   17 +++++++++++------
 drivers/staging/iio/magnetometer/hmc5843.c |   20 +++++++++++++-------
 8 files changed, 66 insertions(+), 71 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
index 2c03a39..9e128dd 100644
--- a/drivers/staging/iio/addac/adt7316-i2c.c
+++ b/drivers/staging/iio/addac/adt7316-i2c.c
@@ -125,30 +125,14 @@ static const struct i2c_device_id adt7316_i2c_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, adt7316_i2c_id);
 
-#ifdef CONFIG_PM
-static int adt7316_i2c_suspend(struct i2c_client *client, pm_message_t message)
-{
-	return adt7316_disable(&client->dev);
-}
-
-static int adt7316_i2c_resume(struct i2c_client *client)
-{
-	return adt7316_enable(&client->dev);
-}
-#else
-# define adt7316_i2c_suspend NULL
-# define adt7316_i2c_resume  NULL
-#endif
-
 static struct i2c_driver adt7316_driver = {
 	.driver = {
 		.name = "adt7316",
+		.pm = ADT7316_PM_OPS,
 		.owner  = THIS_MODULE,
 	},
 	.probe = adt7316_i2c_probe,
 	.remove = __devexit_p(adt7316_i2c_remove),
-	.suspend = adt7316_i2c_suspend,
-	.resume = adt7316_i2c_resume,
 	.id_table = adt7316_i2c_id,
 };
 module_i2c_driver(adt7316_driver);
diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/iio/addac/adt7316-spi.c
index 1ea3cd0..985f7d8 100644
--- a/drivers/staging/iio/addac/adt7316-spi.c
+++ b/drivers/staging/iio/addac/adt7316-spi.c
@@ -133,30 +133,14 @@ static const struct spi_device_id adt7316_spi_id[] = {
 
 MODULE_DEVICE_TABLE(spi, adt7316_spi_id);
 
-#ifdef CONFIG_PM
-static int adt7316_spi_suspend(struct spi_device *spi_dev, pm_message_t message)
-{
-	return adt7316_disable(&spi_dev->dev);
-}
-
-static int adt7316_spi_resume(struct spi_device *spi_dev)
-{
-	return adt7316_enable(&spi_dev->dev);
-}
-#else
-# define adt7316_spi_suspend NULL
-# define adt7316_spi_resume  NULL
-#endif
-
 static struct spi_driver adt7316_driver = {
 	.driver = {
 		.name = "adt7316",
+		.pm = ADT7316_PM_OPS,
 		.owner = THIS_MODULE,
 	},
 	.probe = adt7316_spi_probe,
 	.remove = __devexit_p(adt7316_spi_remove),
-	.suspend = adt7316_spi_suspend,
-	.resume = adt7316_spi_resume,
 	.id_table = adt7316_spi_id,
 };
 module_spi_driver(adt7316_driver);
diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 13c3929..fd6a454 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -2089,24 +2089,25 @@ static struct attribute_group adt7516_event_attribute_group = {
 	.name = "events",
 };
 
-#ifdef CONFIG_PM
-int adt7316_disable(struct device *dev)
+#ifdef CONFIG_PM_SLEEP
+static int adt7316_disable(struct device *dev)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return _adt7316_store_enabled(chip, 0);
 }
-EXPORT_SYMBOL(adt7316_disable);
 
-int adt7316_enable(struct device *dev)
+static int adt7316_enable(struct device *dev)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return _adt7316_store_enabled(chip, 1);
 }
-EXPORT_SYMBOL(adt7316_enable);
+
+SIMPLE_DEV_PM_OPS(adt7316_pm_ops, adt7316_disable, adt7316_enable);
+EXPORT_SYMBOL_GPL(adt7316_pm_ops);
 #endif
 
 static const struct iio_info adt7316_info = {
diff --git a/drivers/staging/iio/addac/adt7316.h b/drivers/staging/iio/addac/adt7316.h
index d34bd67..4d3efff 100644
--- a/drivers/staging/iio/addac/adt7316.h
+++ b/drivers/staging/iio/addac/adt7316.h
@@ -10,6 +10,7 @@
 #define _ADT7316_H_
 
 #include <linux/types.h>
+#include <linux/pm.h>
 
 #define ADT7316_REG_MAX_ADDR		0x3F
 
@@ -23,9 +24,11 @@ struct adt7316_bus {
 	int (*multi_write) (void *client, u8 first_reg, u8 count, u8 *data);
 };
 
-#ifdef CONFIG_PM
-int adt7316_disable(struct device *dev);
-int adt7316_enable(struct device *dev);
+#ifdef CONFIG_PM_SLEEP
+extern const struct dev_pm_ops adt7316_pm_ops;
+#define ADT7316_PM_OPS (&adt7316_pm_ops)
+#else
+#define ADT7316_PM_OPS NULL
 #endif
 int adt7316_probe(struct device *dev, struct adt7316_bus *bus, const char *name);
 int adt7316_remove(struct device *dev);
diff --git a/drivers/staging/iio/dac/max517.c b/drivers/staging/iio/dac/max517.c
index a4df6d7..41483c7 100644
--- a/drivers/staging/iio/dac/max517.c
+++ b/drivers/staging/iio/dac/max517.c
@@ -179,20 +179,27 @@ static struct attribute_group max518_attribute_group = {
 	.attrs = max518_attributes,
 };
 
-static int max517_suspend(struct i2c_client *client, pm_message_t mesg)
+#ifdef CONFIG_PM_SLEEP
+static int max517_suspend(struct device *dev)
 {
 	u8 outbuf = COMMAND_PD;
 
-	return i2c_master_send(client, &outbuf, 1);
+	return i2c_master_send(to_i2c_client(dev), &outbuf, 1);
 }
 
-static int max517_resume(struct i2c_client *client)
+static int max517_resume(struct device *dev)
 {
 	u8 outbuf = 0;
 
-	return i2c_master_send(client, &outbuf, 1);
+	return i2c_master_send(to_i2c_client(dev), &outbuf, 1);
 }
 
+static SIMPLE_DEV_PM_OPS(max517_pm_ops, max517_suspend, max517_resume);
+#define MAX517_PM_OPS (&max517_pm_ops)
+#else
+#define MAX517_PM_OPS NULL
+#endif
+
 static const struct iio_info max517_info = {
 	.attrs = &max517_attribute_group,
 	.driver_module = THIS_MODULE,
@@ -273,11 +280,10 @@ MODULE_DEVICE_TABLE(i2c, max517_id);
 static struct i2c_driver max517_driver = {
 	.driver = {
 		.name	= MAX517_DRV_NAME,
+		.pm		= MAX517_PM_OPS,
 	},
 	.probe		= max517_probe,
 	.remove		= max517_remove,
-	.suspend	= max517_suspend,
-	.resume		= max517_resume,
 	.id_table	= max517_id,
 };
 module_i2c_driver(max517_driver);
diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index ffca85e..aca1e03 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -118,7 +118,7 @@ struct tsl2563_chip {
 	struct delayed_work	poweroff_work;
 
 	/* Remember state for suspend and resume functions */
-	pm_message_t		state;
+	bool suspended;
 
 	struct tsl2563_gainlevel_coeff const *gainlevel;
 
@@ -315,7 +315,7 @@ static int tsl2563_get_adc(struct tsl2563_chip *chip)
 	int retry = 1;
 	int ret = 0;
 
-	if (chip->state.event != PM_EVENT_ON)
+	if (chip->suspended)
 		goto out;
 
 	if (!chip->int_enabled) {
@@ -810,9 +810,10 @@ static int tsl2563_remove(struct i2c_client *client)
 	return 0;
 }
 
-static int tsl2563_suspend(struct i2c_client *client, pm_message_t state)
+#ifdef CONFIG_PM_SLEEP
+static int tsl2563_suspend(struct device *dev)
 {
-	struct tsl2563_chip *chip = i2c_get_clientdata(client);
+	struct tsl2563_chip *chip = i2c_get_clientdata(to_i2c_client(dev));
 	int ret;
 
 	mutex_lock(&chip->lock);
@@ -821,16 +822,16 @@ static int tsl2563_suspend(struct i2c_client *client, pm_message_t state)
 	if (ret)
 		goto out;
 
-	chip->state = state;
+	chip->suspended = true;
 
 out:
 	mutex_unlock(&chip->lock);
 	return ret;
 }
 
-static int tsl2563_resume(struct i2c_client *client)
+static int tsl2563_resume(struct device *dev)
 {
-	struct tsl2563_chip *chip = i2c_get_clientdata(client);
+	struct tsl2563_chip *chip = i2c_get_clientdata(to_i2c_client(dev));
 	int ret;
 
 	mutex_lock(&chip->lock);
@@ -843,13 +844,19 @@ static int tsl2563_resume(struct i2c_client *client)
 	if (ret)
 		goto out;
 
-	chip->state.event = PM_EVENT_ON;
+	chip->suspended = false;
 
 out:
 	mutex_unlock(&chip->lock);
 	return ret;
 }
 
+static SIMPLE_DEV_PM_OPS(tsl2563_pm_ops, tsl2563_suspend, tsl2563_resume);
+#define TSL2563_PM_OPS (&tsl2563_pm_ops)
+#else
+#define TSL2563_PM_OPS NULL
+#endif
+
 static const struct i2c_device_id tsl2563_id[] = {
 	{ "tsl2560", 0 },
 	{ "tsl2561", 1 },
@@ -862,9 +869,8 @@ MODULE_DEVICE_TABLE(i2c, tsl2563_id);
 static struct i2c_driver tsl2563_i2c_driver = {
 	.driver = {
 		.name	 = "tsl2563",
+		.pm	= TSL2563_PM_OPS,
 	},
-	.suspend	= tsl2563_suspend,
-	.resume		= tsl2563_resume,
 	.probe		= tsl2563_probe,
 	.remove		= __devexit_p(tsl2563_remove),
 	.id_table	= tsl2563_id,
diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 5b6455a..9fe9a67 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -884,9 +884,10 @@ fail2:
 	return ret;
 }
 
-static int taos_suspend(struct i2c_client *client, pm_message_t state)
+#ifdef CONFIG_PM_SLEEP
+static int taos_suspend(struct device *dev)
 {
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	int ret = 0;
 
@@ -901,9 +902,9 @@ static int taos_suspend(struct i2c_client *client, pm_message_t state)
 	return ret;
 }
 
-static int taos_resume(struct i2c_client *client)
+static int taos_resume(struct device *dev)
 {
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	int ret = 0;
 
@@ -916,6 +917,11 @@ static int taos_resume(struct i2c_client *client)
 	return ret;
 }
 
+static SIMPLE_DEV_PM_OPS(taos_pm_ops, taos_suspend, taos_resume);
+#define TAOS_PM_OPS (&taos_pm_ops)
+#else
+#define TAOS_PM_OPS NULL
+#endif
 
 static int __devexit taos_remove(struct i2c_client *client)
 {
@@ -937,10 +943,9 @@ MODULE_DEVICE_TABLE(i2c, taos_idtable);
 static struct i2c_driver taos_driver = {
 	.driver = {
 		.name = "tsl2583",
+		.pm = TAOS_PM_OPS,
 	},
 	.id_table = taos_idtable,
-	.suspend	= taos_suspend,
-	.resume		= taos_resume,
 	.probe = taos_probe,
 	.remove = __devexit_p(taos_remove),
 };
diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index f2e85a9..d24992c 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -588,19 +588,26 @@ static int hmc5843_remove(struct i2c_client *client)
 	return 0;
 }
 
-static int hmc5843_suspend(struct i2c_client *client, pm_message_t mesg)
+#ifdef CONFIG_PM_SLEEP
+static int hmc5843_suspend(struct device *dev)
 {
-	hmc5843_configure(client, MODE_SLEEP);
+	hmc5843_configure(to_i2c_client(dev), MODE_SLEEP);
 	return 0;
 }
 
-static int hmc5843_resume(struct i2c_client *client)
+static int hmc5843_resume(struct device *dev)
 {
-	struct hmc5843_data *data = i2c_get_clientdata(client);
-	hmc5843_configure(client, data->operating_mode);
+	struct hmc5843_data *data = i2c_get_clientdata(to_i2c_client(dev));
+	hmc5843_configure(to_i2c_client(dev), data->operating_mode);
 	return 0;
 }
 
+static SIMPLE_DEV_PM_OPS(hmc5843_pm_ops, hmc5843_suspend, hmc5843_resume);
+#define HMC5843_PM_OPS (&hmc5843_pm_ops)
+#else
+#define HMC5843_PM_OPS NULL
+#endif
+
 static const struct i2c_device_id hmc5843_id[] = {
 	{ "hmc5843", 0 },
 	{ }
@@ -610,14 +617,13 @@ MODULE_DEVICE_TABLE(i2c, hmc5843_id);
 static struct i2c_driver hmc5843_driver = {
 	.driver = {
 		.name	= "hmc5843",
+		.pm	= HMC5843_PM_OPS,
 	},
 	.id_table	= hmc5843_id,
 	.probe		= hmc5843_probe,
 	.remove		= hmc5843_remove,
 	.detect		= hmc5843_detect,
 	.address_list	= normal_i2c,
-	.suspend	= hmc5843_suspend,
-	.resume		= hmc5843_resume,
 };
 module_i2c_driver(hmc5843_driver);
 
-- 
1.7.9

