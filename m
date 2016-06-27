Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:33024 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbcF0Qa7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jun 2016 12:30:59 -0400
Received: by mail-lf0-f41.google.com with SMTP id f6so159681491lfg.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Jun 2016 09:30:58 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Akinobu Mita <akinobu.mita@gmail.com>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Matt Ranostay <mranostay@gmail.com>
Cc: Christoph Mair <christoph.mair@gmail.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Marek Belisko <marek@goldelico.com>,
	Eric Andersson <eric.andersson@unixphere.com>,
	Neil Brown <neilb@suse.de>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 08/10 v3] iio: pressure: bmp280: add support for BMP085 EOC interrupt
Date: Mon, 27 Jun 2016 18:30:18 +0200
Message-Id: <1467045020-2665-9-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1467045020-2665-1-git-send-email-linus.walleij@linaro.org>
References: <1467045020-2665-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The first version of this sensor, BMP085, supports sending an
End-of-Conversion (EOC) interrupt. Add code to support this using
a completion, in a similar vein as drivers/misc/bmp085.c does.

Make sure to check that we are given a rising edge, because the
EOC line goes from low-to-high when the conversion is ready.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Fetch interrupt before registering IIO device
- Factor out a separate BMP058 IRQ fetch function
ChangeLog v1->v2:
- Fix spelling mistakes
- Rebase on all other stuff like changes in probe() etc
---
 drivers/iio/pressure/bmp280-core.c | 92 ++++++++++++++++++++++++++++++++++----
 drivers/iio/pressure/bmp280-i2c.c  |  3 +-
 drivers/iio/pressure/bmp280-spi.c  |  3 +-
 drivers/iio/pressure/bmp280.h      |  3 +-
 4 files changed, 89 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 09f96aa2da65..615def02164a 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -27,6 +27,9 @@
 #include <linux/iio/sysfs.h>
 #include <linux/gpio/consumer.h>
 #include <linux/regulator/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h> /* For irq_get_irq_data() */
+#include <linux/completion.h>
 
 #include "bmp280.h"
 
@@ -34,6 +37,8 @@ struct bmp280_data {
 	struct device *dev;
 	struct mutex lock;
 	struct regmap *regmap;
+	struct completion done;
+	bool use_eoc;
 	const struct bmp280_chip_info *chip_info;
 	struct regulator *vddd;
 	struct regulator *vdda;
@@ -595,16 +600,32 @@ static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
 	unsigned int delay_us;
 	unsigned int ctrl;
 
+	if (data->use_eoc)
+		init_completion(&data->done);
+
 	ret = regmap_write(data->regmap, BMP280_REG_CTRL_MEAS, ctrl_meas);
 	if (ret)
 		return ret;
 
-	if (ctrl_meas == BMP180_MEAS_TEMP)
-		delay_us = 4500;
-	else
-		delay_us = conversion_time_max[data->oversampling_press];
-
-	usleep_range(delay_us, delay_us + 1000);
+	if (data->use_eoc) {
+		/*
+		 * If we have a completion interrupt, use it, wait up to
+		 * 100ms. The longest conversion time listed is 76.5 ms for
+		 * advanced resolution mode.
+		 */
+		ret = wait_for_completion_timeout(&data->done,
+						  1 + msecs_to_jiffies(100));
+		if (!ret)
+			dev_err(data->dev, "timeout waiting for completion\n");
+	} else {
+		if (ctrl_meas == BMP180_MEAS_TEMP)
+			delay_us = 4500;
+		else
+			delay_us =
+				conversion_time_max[data->oversampling_press];
+
+		usleep_range(delay_us, delay_us + 1000);
+	}
 
 	ret = regmap_read(data->regmap, BMP280_REG_CTRL_MEAS, &ctrl);
 	if (ret)
@@ -846,10 +867,51 @@ static const struct bmp280_chip_info bmp180_chip_info = {
 	.read_press = bmp180_read_press,
 };
 
+static irqreturn_t bmp058_eoc_irq(int irq, void *d)
+{
+	struct bmp280_data *data = d;
+
+	complete(&data->done);
+
+	return IRQ_HANDLED;
+}
+
+int bmp058_fetch_eoc_irq(struct device *dev,
+			 const char *name,
+			 int irq,
+			 struct bmp280_data *data)
+{
+	unsigned long irq_trig;
+	int ret;
+
+	irq_trig = irqd_get_trigger_type(irq_get_irq_data(irq));
+	if (irq_trig != IRQF_TRIGGER_RISING) {
+		dev_err(dev, "non-rising trigger given for EOC interrupt, "
+			"trying to enforce it\n");
+		irq_trig = IRQF_TRIGGER_RISING;
+	}
+	ret = devm_request_threaded_irq(dev,
+			irq,
+			bmp058_eoc_irq,
+			NULL,
+			irq_trig,
+			name,
+			data);
+	if (ret) {
+		/* Bail out without IRQ but keep the driver in place */
+		dev_err(dev, "unable to request DRDY IRQ\n");
+		return 0;
+	}
+
+	data->use_eoc = true;
+	return 0;
+}
+
 int bmp280_common_probe(struct device *dev,
 			struct regmap *regmap,
 			unsigned int chip,
-			const char *name)
+			const char *name,
+			int irq)
 {
 	int ret;
 	struct iio_dev *indio_dev;
@@ -948,10 +1010,22 @@ int bmp280_common_probe(struct device *dev,
 
 	dev_set_drvdata(dev, data);
 
+	/*
+	 * Attempt to grab an optional EOC IRQ - only the BMP058 has this
+	 * however as it happens, the BMP058 shares the chip ID of BMP180
+	 * so we look for an IRQ if we have that.
+	 */
+	if (irq > 0 || (chip_id  == BMP180_CHIP_ID)) {
+		ret = bmp058_fetch_eoc_irq(dev, name, irq, data);
+		if (ret)
+			goto out_disable_vdda;
+	}
+
 	ret = devm_iio_device_register(dev, indio_dev);
-	if (ret)
+	if (ret) {
+		dev_err(dev, "unable to register IIO device\n");
 		goto out_disable_vdda;
-
+	}
 	return 0;
 
 out_disable_vdda:
diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
index 7c70ee172bba..8cf8a900bdaa 100644
--- a/drivers/iio/pressure/bmp280-i2c.c
+++ b/drivers/iio/pressure/bmp280-i2c.c
@@ -33,7 +33,8 @@ static int bmp280_i2c_probe(struct i2c_client *client,
 	return bmp280_common_probe(&client->dev,
 				   regmap,
 				   id->driver_data,
-				   id->name);
+				   id->name,
+				   client->irq);
 }
 
 static int bmp280_i2c_remove(struct i2c_client *client)
diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index 7e6bd495308e..2468224edb79 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -81,7 +81,8 @@ static int bmp280_spi_probe(struct spi_device *spi)
 	return bmp280_common_probe(&spi->dev,
 				   regmap,
 				   id->driver_data,
-				   id->name);
+				   id->name,
+				   spi->irq);
 }
 
 static int bmp280_spi_remove(struct spi_device *spi)
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index b9fc28ce9428..573334b8e93b 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -104,5 +104,6 @@ extern const struct regmap_config bmp280_regmap_config;
 int bmp280_common_probe(struct device *dev,
 			struct regmap *regmap,
 			unsigned int chip,
-			const char *name);
+			const char *name,
+			int irq);
 int bmp280_common_remove(struct device *dev);
-- 
2.4.11

