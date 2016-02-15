Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:30864 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751949AbcBORx4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 15 Feb 2016 12:53:56 -0500
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Mark Brown <broonie@kernel.org>,
	"Andrew F. Davis" <afd@ti.com>,
	=?UTF-8?q?Gr=C3=A9gor=20Boirie?= <gregor.boirie@parrot.com>
Subject: [PATCH v1 2/5] iio:pressure:ms5611: use probed device name
Date: Mon, 15 Feb 2016 18:53:17 +0100
Message-ID: <d54f50a334cc606d207afdd994a28a3fbd246007.1455557806.git.gregor.boirie@parrot.com>
In-Reply-To: <5764f4978abda151dd053c56d08f1688b371635d.1455557806.git.gregor.boirie@parrot.com>
References: <5764f4978abda151dd053c56d08f1688b371635d.1455557806.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Grégor Boirie <gregor.boirie@parrot.com>

Use name of probed device instead of driver's one when registering device.

Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
---
 drivers/iio/pressure/ms5611.h      | 3 ++-
 drivers/iio/pressure/ms5611_core.c | 5 +++--
 drivers/iio/pressure/ms5611_i2c.c  | 2 +-
 drivers/iio/pressure/ms5611_spi.c  | 4 ++--
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/pressure/ms5611.h b/drivers/iio/pressure/ms5611.h
index 2d70dd6..8b08e4b 100644
--- a/drivers/iio/pressure/ms5611.h
+++ b/drivers/iio/pressure/ms5611.h
@@ -51,7 +51,8 @@ struct ms5611_state {
 	struct ms5611_chip_info *chip_info;
 };
 
-int ms5611_probe(struct iio_dev *indio_dev, struct device *dev, int type);
+int ms5611_probe(struct iio_dev *indio_dev, struct device *dev,
+                 const char* name, int type);
 int ms5611_remove(struct iio_dev *indio_dev);
 
 #endif /* _MS5611_H */
diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
index a2ff89e6..65d8fd2 100644
--- a/drivers/iio/pressure/ms5611_core.c
+++ b/drivers/iio/pressure/ms5611_core.c
@@ -298,7 +298,8 @@ static int ms5611_init(struct iio_dev *indio_dev)
 	return ms5611_read_prom(indio_dev);
 }
 
-int ms5611_probe(struct iio_dev *indio_dev, struct device *dev, int type)
+int ms5611_probe(struct iio_dev *indio_dev, struct device *dev,
+                 const char *name, int type)
 {
 	int ret;
 	struct ms5611_state *st = iio_priv(indio_dev);
@@ -306,7 +307,7 @@ int ms5611_probe(struct iio_dev *indio_dev, struct device *dev, int type)
 	mutex_init(&st->lock);
 	st->chip_info = &chip_info_tbl[type];
 	indio_dev->dev.parent = dev;
-	indio_dev->name = dev->driver->name;
+	indio_dev->name = name;
 	indio_dev->info = &ms5611_info;
 	indio_dev->channels = ms5611_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ms5611_channels);
diff --git a/drivers/iio/pressure/ms5611_i2c.c b/drivers/iio/pressure/ms5611_i2c.c
index 42706a8..ae67539 100644
--- a/drivers/iio/pressure/ms5611_i2c.c
+++ b/drivers/iio/pressure/ms5611_i2c.c
@@ -105,7 +105,7 @@ static int ms5611_i2c_probe(struct i2c_client *client,
 	st->read_adc_temp_and_pressure = ms5611_i2c_read_adc_temp_and_pressure;
 	st->client = client;
 
-	return ms5611_probe(indio_dev, &client->dev, id->driver_data);
+	return ms5611_probe(indio_dev, &client->dev, id->name, id->driver_data);
 }
 
 static int ms5611_i2c_remove(struct i2c_client *client)
diff --git a/drivers/iio/pressure/ms5611_spi.c b/drivers/iio/pressure/ms5611_spi.c
index c4bf4e8..5cc009e 100644
--- a/drivers/iio/pressure/ms5611_spi.c
+++ b/drivers/iio/pressure/ms5611_spi.c
@@ -105,8 +105,8 @@ static int ms5611_spi_probe(struct spi_device *spi)
 	st->read_adc_temp_and_pressure = ms5611_spi_read_adc_temp_and_pressure;
 	st->client = spi;
 
-	return ms5611_probe(indio_dev, &spi->dev,
-			    spi_get_device_id(spi)->driver_data);
+	return ms5611_probe(indio_dev, &spi->dev, spi_get_device_id(spi)->name,
+	                    spi_get_device_id(spi)->driver_data);
 }
 
 static int ms5611_spi_remove(struct spi_device *spi)
-- 
2.1.4

