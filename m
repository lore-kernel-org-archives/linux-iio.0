Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:19420 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751898AbbHLN1x (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 12 Aug 2015 09:27:53 -0400
From: sdliyong@gmail.com
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	cristina.opriceana@gmail.com, tolga.ceylan@gmail.com,
	k.kozlowski@samsung.com, sdliyong@gmail.com,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, marek@goldelico.com
Subject: [PATCH v2] staging: iio: hmc5843: Set iio name dynamically
Date: Wed, 12 Aug 2015 21:25:46 +0800
Message-Id: <1439385946-28388-1-git-send-email-sdliyong@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Yong Li <sdliyong@gmail.com>

Load the driver using the below command:
echo hmc5983 0x1e > /sys/bus/i2c/devices/i2c-?/new_device

In sysfs, the iio name is hmc5843, however the i2c name is hmc5983,
they are inconsistent.

With this patch, the iio name will be the same as the i2c device name

Signed-off-by: Yong Li <sdliyong@gmail.com>
---
 drivers/staging/iio/magnetometer/hmc5843.h      | 2 +-
 drivers/staging/iio/magnetometer/hmc5843_core.c | 4 ++--
 drivers/staging/iio/magnetometer/hmc5843_i2c.c  | 2 +-
 drivers/staging/iio/magnetometer/hmc5843_spi.c  | 3 ++-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.h b/drivers/staging/iio/magnetometer/hmc5843.h
index f3d0da2..06f35d3 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.h
+++ b/drivers/staging/iio/magnetometer/hmc5843.h
@@ -48,7 +48,7 @@ struct hmc5843_data {
 };
 
 int hmc5843_common_probe(struct device *dev, struct regmap *regmap,
-			 enum hmc5843_ids id);
+			 enum hmc5843_ids id, const char *name);
 int hmc5843_common_remove(struct device *dev);
 
 int hmc5843_common_suspend(struct device *dev);
diff --git a/drivers/staging/iio/magnetometer/hmc5843_core.c b/drivers/staging/iio/magnetometer/hmc5843_core.c
index fffca3a..4aab022 100644
--- a/drivers/staging/iio/magnetometer/hmc5843_core.c
+++ b/drivers/staging/iio/magnetometer/hmc5843_core.c
@@ -577,7 +577,7 @@ int hmc5843_common_resume(struct device *dev)
 EXPORT_SYMBOL(hmc5843_common_resume);
 
 int hmc5843_common_probe(struct device *dev, struct regmap *regmap,
-			 enum hmc5843_ids id)
+			 enum hmc5843_ids id, const char *name)
 {
 	struct hmc5843_data *data;
 	struct iio_dev *indio_dev;
@@ -597,7 +597,7 @@ int hmc5843_common_probe(struct device *dev, struct regmap *regmap,
 	mutex_init(&data->lock);
 
 	indio_dev->dev.parent = dev;
-	indio_dev->name = dev->driver->name;
+	indio_dev->name = name;
 	indio_dev->info = &hmc5843_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = data->variant->channels;
diff --git a/drivers/staging/iio/magnetometer/hmc5843_i2c.c b/drivers/staging/iio/magnetometer/hmc5843_i2c.c
index ff08667..3e06ceb 100644
--- a/drivers/staging/iio/magnetometer/hmc5843_i2c.c
+++ b/drivers/staging/iio/magnetometer/hmc5843_i2c.c
@@ -61,7 +61,7 @@ static int hmc5843_i2c_probe(struct i2c_client *cli,
 {
 	return hmc5843_common_probe(&cli->dev,
 			devm_regmap_init_i2c(cli, &hmc5843_i2c_regmap_config),
-			id->driver_data);
+			id->driver_data, id->name);
 }
 
 static int hmc5843_i2c_remove(struct i2c_client *client)
diff --git a/drivers/staging/iio/magnetometer/hmc5843_spi.c b/drivers/staging/iio/magnetometer/hmc5843_spi.c
index 8e658f7..8a80d01 100644
--- a/drivers/staging/iio/magnetometer/hmc5843_spi.c
+++ b/drivers/staging/iio/magnetometer/hmc5843_spi.c
@@ -59,6 +59,7 @@ static const struct regmap_config hmc5843_spi_regmap_config = {
 static int hmc5843_spi_probe(struct spi_device *spi)
 {
 	int ret;
+	const struct spi_device_id *id = spi_get_device_id(spi);
 
 	spi->mode = SPI_MODE_3;
 	spi->max_speed_hz = 8000000;
@@ -69,7 +70,7 @@ static int hmc5843_spi_probe(struct spi_device *spi)
 
 	return hmc5843_common_probe(&spi->dev,
 			devm_regmap_init_spi(spi, &hmc5843_spi_regmap_config),
-			HMC5983_ID);
+			id->driver_data, id->name);
 }
 
 static int hmc5843_spi_remove(struct spi_device *spi)
-- 
2.1.0

