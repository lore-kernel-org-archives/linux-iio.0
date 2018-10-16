Return-Path: <SRS0=y4vc=M4=gmail.com=nishadkamdar@kernel.org>
Date: Tue, 16 Oct 2018 20:16:27 +0530
From: Nishad Kamdar <nishadkamdar@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH] staging: iio: ad7816: Switch to the gpio descriptor interface
Message-ID: <20181016144623.GA9890@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Use the gpiod interface for rdwr_pin, convert_pin and busy_pin
instead of the deprecated old non-descriptor interface.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 72 +++++++++++++-------------------
 1 file changed, 30 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index bf76a8620bdb..190b751af866 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -7,7 +7,7 @@
  */
 
 #include <linux/interrupt.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -44,9 +44,9 @@
 
 struct ad7816_chip_info {
 	struct spi_device *spi_dev;
-	u16 rdwr_pin;
-	u16 convert_pin;
-	u16 busy_pin;
+	struct gpio_desc *rdwr_pin;
+	struct gpio_desc *convert_pin;
+	struct gpio_desc *busy_pin;
 	u8  oti_data[AD7816_CS_MAX + 1];
 	u8  channel_id;	/* 0 always be temperature */
 	u8  mode;
@@ -61,28 +61,28 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
 	int ret = 0;
 	__be16 buf;
 
-	gpio_set_value(chip->rdwr_pin, 1);
-	gpio_set_value(chip->rdwr_pin, 0);
+	gpiod_set_value(chip->rdwr_pin, 1);
+	gpiod_set_value(chip->rdwr_pin, 0);
 	ret = spi_write(spi_dev, &chip->channel_id, sizeof(chip->channel_id));
 	if (ret < 0) {
 		dev_err(&spi_dev->dev, "SPI channel setting error\n");
 		return ret;
 	}
-	gpio_set_value(chip->rdwr_pin, 1);
+	gpiod_set_value(chip->rdwr_pin, 1);
 
 	if (chip->mode == AD7816_PD) { /* operating mode 2 */
-		gpio_set_value(chip->convert_pin, 1);
-		gpio_set_value(chip->convert_pin, 0);
+		gpiod_set_value(chip->convert_pin, 1);
+		gpiod_set_value(chip->convert_pin, 0);
 	} else { /* operating mode 1 */
-		gpio_set_value(chip->convert_pin, 0);
-		gpio_set_value(chip->convert_pin, 1);
+		gpiod_set_value(chip->convert_pin, 0);
+		gpiod_set_value(chip->convert_pin, 1);
 	}
 
-	while (gpio_get_value(chip->busy_pin))
+	while (gpiod_get_value(chip->busy_pin))
 		cpu_relax();
 
-	gpio_set_value(chip->rdwr_pin, 0);
-	gpio_set_value(chip->rdwr_pin, 1);
+	gpiod_set_value(chip->rdwr_pin, 0);
+	gpiod_set_value(chip->rdwr_pin, 1);
 	ret = spi_read(spi_dev, &buf, sizeof(*data));
 	if (ret < 0) {
 		dev_err(&spi_dev->dev, "SPI data read error\n");
@@ -99,8 +99,8 @@ static int ad7816_spi_write(struct ad7816_chip_info *chip, u8 data)
 	struct spi_device *spi_dev = chip->spi_dev;
 	int ret = 0;
 
-	gpio_set_value(chip->rdwr_pin, 1);
-	gpio_set_value(chip->rdwr_pin, 0);
+	gpiod_set_value(chip->rdwr_pin, 1);
+	gpiod_set_value(chip->rdwr_pin, 0);
 	ret = spi_write(spi_dev, &data, sizeof(data));
 	if (ret < 0)
 		dev_err(&spi_dev->dev, "SPI oti data write error\n");
@@ -129,10 +129,10 @@ static ssize_t ad7816_store_mode(struct device *dev,
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
 
 	if (strcmp(buf, "full")) {
-		gpio_set_value(chip->rdwr_pin, 1);
+		gpiod_set_value(chip->rdwr_pin, 1);
 		chip->mode = AD7816_FULL;
 	} else {
-		gpio_set_value(chip->rdwr_pin, 0);
+		gpiod_set_value(chip->rdwr_pin, 0);
 		chip->mode = AD7816_PD;
 	}
 
@@ -345,15 +345,9 @@ static int ad7816_probe(struct spi_device *spi_dev)
 {
 	struct ad7816_chip_info *chip;
 	struct iio_dev *indio_dev;
-	unsigned short *pins = dev_get_platdata(&spi_dev->dev);
 	int ret = 0;
 	int i;
 
-	if (!pins) {
-		dev_err(&spi_dev->dev, "No necessary GPIO platform data.\n");
-		return -EINVAL;
-	}
-
 	indio_dev = devm_iio_device_alloc(&spi_dev->dev, sizeof(*chip));
 	if (!indio_dev)
 		return -ENOMEM;
@@ -364,34 +358,28 @@ static int ad7816_probe(struct spi_device *spi_dev)
 	chip->spi_dev = spi_dev;
 	for (i = 0; i <= AD7816_CS_MAX; i++)
 		chip->oti_data[i] = 203;
-	chip->rdwr_pin = pins[0];
-	chip->convert_pin = pins[1];
-	chip->busy_pin = pins[2];
 
-	ret = devm_gpio_request(&spi_dev->dev, chip->rdwr_pin,
-				spi_get_device_id(spi_dev)->name);
-	if (ret) {
+	chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_IN);
+	if (IS_ERR(chip->rdwr_pin)) {
+		ret = PTR_ERR(chip->rdwr_pin);
 		dev_err(&spi_dev->dev, "Fail to request rdwr gpio PIN %d.\n",
-			chip->rdwr_pin);
+			ret);
 		return ret;
 	}
-	gpio_direction_input(chip->rdwr_pin);
-	ret = devm_gpio_request(&spi_dev->dev, chip->convert_pin,
-				spi_get_device_id(spi_dev)->name);
-	if (ret) {
+	chip->convert_pin = devm_gpiod_get(&spi_dev->dev, "convert", GPIOD_IN);
+	if (IS_ERR(chip->convert_pin)) {
+		ret = PTR_ERR(chip->convert_pin);
 		dev_err(&spi_dev->dev, "Fail to request convert gpio PIN %d.\n",
-			chip->convert_pin);
+			ret);
 		return ret;
 	}
-	gpio_direction_input(chip->convert_pin);
-	ret = devm_gpio_request(&spi_dev->dev, chip->busy_pin,
-				spi_get_device_id(spi_dev)->name);
-	if (ret) {
+	chip->busy_pin = devm_gpiod_get(&spi_dev->dev, "busy", GPIOD_IN);
+	if (IS_ERR(chip->busy_pin)) {
+		ret = PTR_ERR(chip->busy_pin);
 		dev_err(&spi_dev->dev, "Fail to request busy gpio PIN %d.\n",
-			chip->busy_pin);
+			ret);
 		return ret;
 	}
-	gpio_direction_input(chip->busy_pin);
 
 	indio_dev->name = spi_get_device_id(spi_dev)->name;
 	indio_dev->dev.parent = &spi_dev->dev;
-- 
2.17.1
