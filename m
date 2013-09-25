Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	sachin.kamat@linaro.org
Subject: [PATCH 16/32] staging: iio: addac: Use devm_iio_device_register
Date: Wed, 25 Sep 2013 16:19:52 +0530
Message-Id: <1380106208-6948-17-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
References: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/addac/adt7316-i2c.c |    6 ------
 drivers/staging/iio/addac/adt7316-spi.c |    6 ------
 drivers/staging/iio/addac/adt7316.c     |   12 +-----------
 drivers/staging/iio/addac/adt7316.h     |    1 -
 4 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
index ce7d91c..d824e71 100644
--- a/drivers/staging/iio/addac/adt7316-i2c.c
+++ b/drivers/staging/iio/addac/adt7316-i2c.c
@@ -108,11 +108,6 @@ static int adt7316_i2c_probe(struct i2c_client *client,
 	return adt7316_probe(&client->dev, &bus, id->name);
 }
 
-static int adt7316_i2c_remove(struct i2c_client *client)
-{
-	return adt7316_remove(&client->dev);
-}
-
 static const struct i2c_device_id adt7316_i2c_id[] = {
 	{ "adt7316", 0 },
 	{ "adt7317", 0 },
@@ -132,7 +127,6 @@ static struct i2c_driver adt7316_driver = {
 		.owner  = THIS_MODULE,
 	},
 	.probe = adt7316_i2c_probe,
-	.remove = adt7316_i2c_remove,
 	.id_table = adt7316_i2c_id,
 };
 module_i2c_driver(adt7316_driver);
diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/iio/addac/adt7316-spi.c
index 0db8ef5..584b8f9 100644
--- a/drivers/staging/iio/addac/adt7316-spi.c
+++ b/drivers/staging/iio/addac/adt7316-spi.c
@@ -116,11 +116,6 @@ static int adt7316_spi_probe(struct spi_device *spi_dev)
 	return adt7316_probe(&spi_dev->dev, &bus, spi_dev->modalias);
 }
 
-static int adt7316_spi_remove(struct spi_device *spi_dev)
-{
-	return adt7316_remove(&spi_dev->dev);
-}
-
 static const struct spi_device_id adt7316_spi_id[] = {
 	{ "adt7316", 0 },
 	{ "adt7317", 0 },
@@ -140,7 +135,6 @@ static struct spi_driver adt7316_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = adt7316_spi_probe,
-	.remove = adt7316_spi_remove,
 	.id_table = adt7316_spi_id,
 };
 module_spi_driver(adt7316_driver);
diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 80266e8..16a8201 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -2166,7 +2166,7 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 	if (ret)
 		return -EIO;
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret)
 		return ret;
 
@@ -2177,16 +2177,6 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 }
 EXPORT_SYMBOL(adt7316_probe);
 
-int adt7316_remove(struct device *dev)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-
-	iio_device_unregister(indio_dev);
-
-	return 0;
-}
-EXPORT_SYMBOL(adt7316_remove);
-
 MODULE_AUTHOR("Sonic Zhang <sonic.zhang@analog.com>");
 MODULE_DESCRIPTION("Analog Devices ADT7316/7/8 and ADT7516/7/9 digital"
 			" temperature sensor, ADC and DAC driver");
diff --git a/drivers/staging/iio/addac/adt7316.h b/drivers/staging/iio/addac/adt7316.h
index 4d3efff..2dbfb49 100644
--- a/drivers/staging/iio/addac/adt7316.h
+++ b/drivers/staging/iio/addac/adt7316.h
@@ -31,6 +31,5 @@ extern const struct dev_pm_ops adt7316_pm_ops;
 #define ADT7316_PM_OPS NULL
 #endif
 int adt7316_probe(struct device *dev, struct adt7316_bus *bus, const char *name);
-int adt7316_remove(struct device *dev);
 
 #endif
-- 
1.7.9.5
