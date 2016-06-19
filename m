Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:35060 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbcFSSgE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jun 2016 14:36:04 -0400
Received: by mail-lf0-f51.google.com with SMTP id l188so25440556lfe.2
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2016 11:34:43 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Christoph Mair <christoph.mair@gmail.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Marek Belisko <marek@goldelico.com>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Eric Andersson <eric.andersson@unixphere.com>,
	Neil Brown <neilb@suse.de>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 8/9] iio: pressure: bmp280: add support for the BMP058 EOC interrupt
Date: Sun, 19 Jun 2016 20:34:01 +0200
Message-Id: <1466361242-2994-9-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1466361242-2994-1-git-send-email-linus.walleij@linaro.org>
References: <1466361242-2994-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The first version of this sensor, BMP058, supports sending an
End-of-Conversion (EOC) interrupt. Add code to support this using
a completion, in a similar vein as drivers/misc/bmp058.c does.

Make sure to check that we are given a rising edge, because the
EOC line goes from low-to-high when the conversion is ready.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/pressure/bmp280-core.c | 83 ++++++++++++++++++++++++++++++++++----
 drivers/iio/pressure/bmp280-i2c.c  |  3 +-
 drivers/iio/pressure/bmp280-spi.c  |  3 +-
 drivers/iio/pressure/bmp280.h      |  3 +-
 4 files changed, 81 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index af422d224db4..ca9ed843efcc 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -25,6 +25,9 @@
 #include <linux/iio/sysfs.h>
 #include <linux/gpio/consumer.h>
 #include <linux/regulator/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h> /* For irq_get_irq_data() */
+#include <linux/completion.h>
 
 #include "bmp280.h"
 
@@ -32,6 +35,8 @@ struct bmp280_data {
 	struct device *dev;
 	struct mutex lock;
 	struct regmap *regmap;
+	struct completion done;
+	bool use_eoc;
 	const struct bmp280_chip_info *chip_info;
 	struct regulator *vddd;
 	struct regulator *vdda;
@@ -435,16 +440,32 @@ static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
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
@@ -686,16 +707,28 @@ static const struct bmp280_chip_info bmp180_chip_info = {
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
 	struct bmp280_data *data;
 	unsigned int chip_id;
 	struct gpio_desc *gpiod;
+	unsigned long irq_trig;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
@@ -763,5 +796,39 @@ int bmp280_common_probe(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	return devm_iio_device_register(dev, indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret) {
+		dev_err(dev, "unable to register IIO device\n");
+		return ret;
+	}
+
+	/*
+	 * Attempt to grab an optional EOC IRQ - only the BMP058 has this
+	 * however as it happens, the BMP058 shares the chip ID of BMP180
+	 * so we look for an IRQ if we have that.
+	 */
+	if (irq <= 0 || (chip_id  != BMP180_CHIP_ID))
+		return 0;
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
 }
diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
index b422600f34e0..eb2b727109b8 100644
--- a/drivers/iio/pressure/bmp280-i2c.c
+++ b/drivers/iio/pressure/bmp280-i2c.c
@@ -32,7 +32,8 @@ static int bmp280_i2c_probe(struct i2c_client *client,
 	return bmp280_common_probe(&client->dev,
 				   regmap,
 				   id->driver_data,
-				   id->name);
+				   id->name,
+				   client->irq);
 }
 
 static const struct acpi_device_id bmp280_acpi_i2c_match[] = {
diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index a24ea5f62c5e..cfb6248ceb1f 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -44,7 +44,8 @@ static int bmp280_spi_probe(struct spi_device *spi)
 	return bmp280_common_probe(&spi->dev,
 				   regmap,
 				   id->driver_data,
-				   id->name);
+				   id->name,
+				   spi->irq);
 }
 
 static const struct of_device_id bmp280_of_spi_match[] = {
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 9249956bc8bf..ad0e5778c6b5 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -82,4 +82,5 @@ extern const struct regmap_config bmp280_regmap_config;
 int bmp280_common_probe(struct device *dev,
 			struct regmap *regmap,
 			unsigned int chip,
-			const char *name);
+			const char *name,
+			int irq);
-- 
2.4.11

