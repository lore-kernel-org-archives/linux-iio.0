Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:41864 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630Ab2KSSnD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 19 Nov 2012 13:43:03 -0500
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 168/493] staging: iio: remove use of __devinit
Date: Mon, 19 Nov 2012 13:21:57 -0500
Message-Id: <1353349642-3677-168-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devinit is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: linux-iio@vger.kernel.org 
Cc: devel@driverdev.osuosl.org 
---
 drivers/staging/iio/accel/adis16201_core.c          | 2 +-
 drivers/staging/iio/accel/adis16203_core.c          | 2 +-
 drivers/staging/iio/accel/adis16204_core.c          | 2 +-
 drivers/staging/iio/accel/adis16209_core.c          | 2 +-
 drivers/staging/iio/accel/adis16220_core.c          | 2 +-
 drivers/staging/iio/accel/adis16240_core.c          | 2 +-
 drivers/staging/iio/accel/kxsd9.c                   | 4 ++--
 drivers/staging/iio/accel/lis3l02dq_core.c          | 2 +-
 drivers/staging/iio/accel/sca3000_core.c            | 2 +-
 drivers/staging/iio/adc/ad7192.c                    | 2 +-
 drivers/staging/iio/adc/ad7280a.c                   | 2 +-
 drivers/staging/iio/adc/ad7291.c                    | 2 +-
 drivers/staging/iio/adc/ad7298_core.c               | 2 +-
 drivers/staging/iio/adc/ad7606_par.c                | 2 +-
 drivers/staging/iio/adc/ad7606_spi.c                | 2 +-
 drivers/staging/iio/adc/ad7780.c                    | 2 +-
 drivers/staging/iio/adc/ad7793.c                    | 2 +-
 drivers/staging/iio/adc/ad7816.c                    | 2 +-
 drivers/staging/iio/adc/ad799x_core.c               | 2 +-
 drivers/staging/iio/adc/adt7410.c                   | 6 +++---
 drivers/staging/iio/adc/lpc32xx_adc.c               | 2 +-
 drivers/staging/iio/adc/mxs-lradc.c                 | 2 +-
 drivers/staging/iio/adc/spear_adc.c                 | 2 +-
 drivers/staging/iio/addac/adt7316-i2c.c             | 2 +-
 drivers/staging/iio/addac/adt7316-spi.c             | 2 +-
 drivers/staging/iio/addac/adt7316.c                 | 2 +-
 drivers/staging/iio/cdc/ad7150.c                    | 2 +-
 drivers/staging/iio/cdc/ad7152.c                    | 2 +-
 drivers/staging/iio/cdc/ad7746.c                    | 2 +-
 drivers/staging/iio/frequency/ad5930.c              | 2 +-
 drivers/staging/iio/frequency/ad9832.c              | 2 +-
 drivers/staging/iio/frequency/ad9834.c              | 2 +-
 drivers/staging/iio/frequency/ad9850.c              | 2 +-
 drivers/staging/iio/frequency/ad9852.c              | 2 +-
 drivers/staging/iio/frequency/ad9910.c              | 2 +-
 drivers/staging/iio/frequency/ad9951.c              | 2 +-
 drivers/staging/iio/gyro/adis16060_core.c           | 4 ++--
 drivers/staging/iio/gyro/adis16080_core.c           | 2 +-
 drivers/staging/iio/gyro/adis16130_core.c           | 2 +-
 drivers/staging/iio/gyro/adis16260_core.c           | 2 +-
 drivers/staging/iio/gyro/adxrs450_core.c            | 2 +-
 drivers/staging/iio/iio_hwmon.c                     | 2 +-
 drivers/staging/iio/iio_simple_dummy.c              | 2 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c     | 2 +-
 drivers/staging/iio/imu/adis16400_core.c            | 2 +-
 drivers/staging/iio/light/isl29018.c                | 2 +-
 drivers/staging/iio/light/isl29028.c                | 2 +-
 drivers/staging/iio/light/tsl2563.c                 | 2 +-
 drivers/staging/iio/light/tsl2583.c                 | 2 +-
 drivers/staging/iio/light/tsl2x7x_core.c            | 2 +-
 drivers/staging/iio/magnetometer/ak8975.c           | 2 +-
 drivers/staging/iio/magnetometer/hmc5843.c          | 2 +-
 drivers/staging/iio/meter/ade7753.c                 | 2 +-
 drivers/staging/iio/meter/ade7754.c                 | 2 +-
 drivers/staging/iio/meter/ade7758_core.c            | 2 +-
 drivers/staging/iio/meter/ade7759.c                 | 2 +-
 drivers/staging/iio/meter/ade7854-i2c.c             | 2 +-
 drivers/staging/iio/meter/ade7854-spi.c             | 2 +-
 drivers/staging/iio/resolver/ad2s1200.c             | 2 +-
 drivers/staging/iio/resolver/ad2s1210.c             | 4 ++--
 drivers/staging/iio/resolver/ad2s90.c               | 2 +-
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c   | 2 +-
 drivers/staging/iio/trigger/iio-trig-gpio.c         | 2 +-
 drivers/staging/iio/trigger/iio-trig-periodic-rtc.c | 2 +-
 64 files changed, 69 insertions(+), 69 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
index bb83fd1..21da0a1 100644
--- a/drivers/staging/iio/accel/adis16201_core.c
+++ b/drivers/staging/iio/accel/adis16201_core.c
@@ -500,7 +500,7 @@ static const struct iio_info adis16201_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int __devinit adis16201_probe(struct spi_device *spi)
+static int adis16201_probe(struct spi_device *spi)
 {
 	int ret;
 	struct adis16201_state *st;
diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index 45d7402..6f9c359 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -434,7 +434,7 @@ static const struct iio_info adis16203_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int __devinit adis16203_probe(struct spi_device *spi)
+static int adis16203_probe(struct spi_device *spi)
 {
 	int ret;
 	struct iio_dev *indio_dev;
diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
index 7ab2cc0..632c17a 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -493,7 +493,7 @@ static const struct iio_info adis16204_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int __devinit adis16204_probe(struct spi_device *spi)
+static int adis16204_probe(struct spi_device *spi)
 {
 	int ret;
 	struct adis16204_state *st;
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index 508a861..3467624 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -508,7 +508,7 @@ static const struct iio_info adis16209_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int __devinit adis16209_probe(struct spi_device *spi)
+static int adis16209_probe(struct spi_device *spi)
 {
 	int ret;
 	struct adis16209_state *st;
diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
index 9b26466..0ce4fe8 100644
--- a/drivers/staging/iio/accel/adis16220_core.c
+++ b/drivers/staging/iio/accel/adis16220_core.c
@@ -601,7 +601,7 @@ static const struct iio_info adis16220_info = {
 	.read_raw = &adis16220_read_raw,
 };
 
-static int __devinit adis16220_probe(struct spi_device *spi)
+static int adis16220_probe(struct spi_device *spi)
 {
 	int ret;
 	struct adis16220_state *st;
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index 638bbed..03c91a8 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -553,7 +553,7 @@ static const struct iio_info adis16240_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int __devinit adis16240_probe(struct spi_device *spi)
+static int adis16240_probe(struct spi_device *spi)
 {
 	int ret;
 	struct adis16240_state *st;
diff --git a/drivers/staging/iio/accel/kxsd9.c b/drivers/staging/iio/accel/kxsd9.c
index b432c6b..8dc04a3 100644
--- a/drivers/staging/iio/accel/kxsd9.c
+++ b/drivers/staging/iio/accel/kxsd9.c
@@ -200,7 +200,7 @@ static const struct attribute_group kxsd9_attribute_group = {
 	.attrs = kxsd9_attributes,
 };
 
-static int __devinit kxsd9_power_up(struct kxsd9_state *st)
+static int kxsd9_power_up(struct kxsd9_state *st)
 {
 	int ret;
 
@@ -222,7 +222,7 @@ static const struct iio_info kxsd9_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int __devinit kxsd9_probe(struct spi_device *spi)
+static int kxsd9_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
 	struct kxsd9_state *st;
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index dbb9617..bc07ca9 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -675,7 +675,7 @@ static const struct iio_info lis3l02dq_info = {
 	.attrs = &lis3l02dq_attribute_group,
 };
 
-static int __devinit lis3l02dq_probe(struct spi_device *spi)
+static int lis3l02dq_probe(struct spi_device *spi)
 {
 	int ret;
 	struct lis3l02dq_state *st;
diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 6955187..c50159d 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -1139,7 +1139,7 @@ static const struct iio_info sca3000_info_with_temp = {
 	.driver_module = THIS_MODULE,
 };
 
-static int __devinit sca3000_probe(struct spi_device *spi)
+static int sca3000_probe(struct spi_device *spi)
 {
 	int ret;
 	struct sca3000_state *st;
diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 7fad227..434cf76 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -606,7 +606,7 @@ static const struct iio_chan_spec ad7192_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(8),
 };
 
-static int __devinit ad7192_probe(struct spi_device *spi)
+static int ad7192_probe(struct spi_device *spi)
 {
 	const struct ad7192_platform_data *pdata = spi->dev.platform_data;
 	struct ad7192_state *st;
diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 1623dc8..7b0e5b5 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -832,7 +832,7 @@ static const struct ad7280_platform_data ad7793_default_pdata = {
 	.thermistor_term_en = true,
 };
 
-static int __devinit ad7280_probe(struct spi_device *spi)
+static int ad7280_probe(struct spi_device *spi)
 {
 	const struct ad7280_platform_data *pdata = spi->dev.platform_data;
 	struct ad7280_state *st;
diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index 86325cb..55f193a 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -580,7 +580,7 @@ static const struct iio_info ad7291_info = {
 	.event_attrs = &ad7291_event_attribute_group,
 };
 
-static int __devinit ad7291_probe(struct i2c_client *client,
+static int ad7291_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
 	struct ad7291_chip_info *chip;
diff --git a/drivers/staging/iio/adc/ad7298_core.c b/drivers/staging/iio/adc/ad7298_core.c
index 13be112..cb7e40e 100644
--- a/drivers/staging/iio/adc/ad7298_core.c
+++ b/drivers/staging/iio/adc/ad7298_core.c
@@ -175,7 +175,7 @@ static const struct iio_info ad7298_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int __devinit ad7298_probe(struct spi_device *spi)
+static int ad7298_probe(struct spi_device *spi)
 {
 	struct ad7298_platform_data *pdata = spi->dev.platform_data;
 	struct ad7298_state *st;
diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/staging/iio/adc/ad7606_par.c
index 864bab8..971c57a 100644
--- a/drivers/staging/iio/adc/ad7606_par.c
+++ b/drivers/staging/iio/adc/ad7606_par.c
@@ -47,7 +47,7 @@ static const struct ad7606_bus_ops ad7606_par8_bops = {
 	.read_block	= ad7606_par8_read_block,
 };
 
-static int __devinit ad7606_par_probe(struct platform_device *pdev)
+static int ad7606_par_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct iio_dev *indio_dev;
diff --git a/drivers/staging/iio/adc/ad7606_spi.c b/drivers/staging/iio/adc/ad7606_spi.c
index ba7779cd..6fd48c4 100644
--- a/drivers/staging/iio/adc/ad7606_spi.c
+++ b/drivers/staging/iio/adc/ad7606_spi.c
@@ -39,7 +39,7 @@ static const struct ad7606_bus_ops ad7606_spi_bops = {
 	.read_block	= ad7606_spi_read_block,
 };
 
-static int __devinit ad7606_spi_probe(struct spi_device *spi)
+static int ad7606_spi_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
 
diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index a6b261e..bace04b 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -164,7 +164,7 @@ static const struct iio_info ad7780_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int __devinit ad7780_probe(struct spi_device *spi)
+static int ad7780_probe(struct spi_device *spi)
 {
 	struct ad7780_platform_data *pdata = spi->dev.platform_data;
 	struct ad7780_state *st;
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index 1fe68f7..d07b016 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -441,7 +441,7 @@ static const struct ad7793_chip_info ad7793_chip_info_tbl[] = {
 	},
 };
 
-static int __devinit ad7793_probe(struct spi_device *spi)
+static int ad7793_probe(struct spi_device *spi)
 {
 	const struct ad7793_platform_data *pdata = spi->dev.platform_data;
 	struct ad7793_state *st;
diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index edce954..51b94cc 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -341,7 +341,7 @@ static const struct iio_info ad7816_info = {
  * device probe and remove
  */
 
-static int __devinit ad7816_probe(struct spi_device *spi_dev)
+static int ad7816_probe(struct spi_device *spi_dev)
 {
 	struct ad7816_chip_info *chip;
 	struct iio_dev *indio_dev;
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 913e6f2..4f49092 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -854,7 +854,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	},
 };
 
-static int __devinit ad799x_probe(struct i2c_client *client,
+static int ad799x_probe(struct i2c_client *client,
 				   const struct i2c_device_id *id)
 {
 	int ret;
diff --git a/drivers/staging/iio/adc/adt7410.c b/drivers/staging/iio/adc/adt7410.c
index 9eaa338..f90de26 100644
--- a/drivers/staging/iio/adc/adt7410.c
+++ b/drivers/staging/iio/adc/adt7410.c
@@ -695,7 +695,7 @@ static const struct iio_info adt7410_info = {
  * device probe and remove
  */
 
-static int __devinit adt7410_probe(struct device *dev, int irq,
+static int adt7410_probe(struct device *dev, int irq,
 	const char *name, const struct adt7410_ops *ops)
 {
 	unsigned long *adt7410_platform_data = dev->platform_data;
@@ -876,7 +876,7 @@ static const struct adt7410_ops adt7410_i2c_ops = {
 	.write_byte = adt7410_i2c_write_byte,
 };
 
-static int __devinit adt7410_i2c_probe(struct i2c_client *client,
+static int adt7410_i2c_probe(struct i2c_client *client,
 	const struct i2c_device_id *id)
 {
 	return adt7410_probe(&client->dev, client->irq, id->name,
@@ -1030,7 +1030,7 @@ static const struct adt7410_ops adt7310_spi_ops = {
 	.write_byte = adt7310_spi_write_byte,
 };
 
-static int __devinit adt7310_spi_probe(struct spi_device *spi)
+static int adt7310_spi_probe(struct spi_device *spi)
 {
 	return adt7410_probe(&spi->dev, spi->irq,
 		spi_get_device_id(spi)->name, &adt7310_spi_ops);
diff --git a/drivers/staging/iio/adc/lpc32xx_adc.c b/drivers/staging/iio/adc/lpc32xx_adc.c
index 0eb80c4..e503686 100644
--- a/drivers/staging/iio/adc/lpc32xx_adc.c
+++ b/drivers/staging/iio/adc/lpc32xx_adc.c
@@ -126,7 +126,7 @@ static irqreturn_t lpc32xx_adc_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __devinit lpc32xx_adc_probe(struct platform_device *pdev)
+static int lpc32xx_adc_probe(struct platform_device *pdev)
 {
 	struct lpc32xx_adc_info *info = NULL;
 	struct resource *res;
diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index f501ab2..53b3322 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -466,7 +466,7 @@ static void mxs_lradc_hw_stop(struct mxs_lradc *lradc)
 		writel(0, lradc->base + LRADC_DELAY(i));
 }
 
-static int __devinit mxs_lradc_probe(struct platform_device *pdev)
+static int mxs_lradc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct mxs_lradc *lradc;
diff --git a/drivers/staging/iio/adc/spear_adc.c b/drivers/staging/iio/adc/spear_adc.c
index 61f6735..23a58df 100644
--- a/drivers/staging/iio/adc/spear_adc.c
+++ b/drivers/staging/iio/adc/spear_adc.c
@@ -291,7 +291,7 @@ static const struct iio_info spear_adc_iio_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int __devinit spear_adc_probe(struct platform_device *pdev)
+static int spear_adc_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
index 84ef136..ca10ebe 100644
--- a/drivers/staging/iio/addac/adt7316-i2c.c
+++ b/drivers/staging/iio/addac/adt7316-i2c.c
@@ -92,7 +92,7 @@ static int adt7316_i2c_multi_write(void *client, u8 reg, u8 count, u8 *data)
  * device probe and remove
  */
 
-static int __devinit adt7316_i2c_probe(struct i2c_client *client,
+static int adt7316_i2c_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
 	struct adt7316_bus bus = {
diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/iio/addac/adt7316-spi.c
index e6efd4b..5c03854 100644
--- a/drivers/staging/iio/addac/adt7316-spi.c
+++ b/drivers/staging/iio/addac/adt7316-spi.c
@@ -89,7 +89,7 @@ static int adt7316_spi_write(void *client, u8 reg, u8 val)
  * device probe and remove
  */
 
-static int __devinit adt7316_spi_probe(struct spi_device *spi_dev)
+static int adt7316_spi_probe(struct spi_device *spi_dev)
 {
 	struct adt7316_bus bus = {
 		.client = spi_dev,
diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 8fb014a..487f5e0 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -2125,7 +2125,7 @@ static const struct iio_info adt7516_info = {
 /*
  * device probe and remove
  */
-int __devinit adt7316_probe(struct device *dev, struct adt7316_bus *bus,
+int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 		const char *name)
 {
 	struct adt7316_chip_info *chip;
diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 3b4d987..4759b5e 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -551,7 +551,7 @@ static const struct iio_info ad7150_info = {
  * device probe and remove
  */
 
-static int __devinit ad7150_probe(struct i2c_client *client,
+static int ad7150_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
 	int ret;
diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
index c7b92cb..42d63be 100644
--- a/drivers/staging/iio/cdc/ad7152.c
+++ b/drivers/staging/iio/cdc/ad7152.c
@@ -474,7 +474,7 @@ static const struct iio_chan_spec ad7152_channels[] = {
  * device probe and remove
  */
 
-static int __devinit ad7152_probe(struct i2c_client *client,
+static int ad7152_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
 	int ret = 0;
diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 9466640..05e9691 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -694,7 +694,7 @@ static const struct iio_info ad7746_info = {
  * device probe and remove
  */
 
-static int __devinit ad7746_probe(struct i2c_client *client,
+static int ad7746_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
 	struct ad7746_platform_data *pdata = client->dev.platform_data;
diff --git a/drivers/staging/iio/frequency/ad5930.c b/drivers/staging/iio/frequency/ad5930.c
index 35953b8..87c232e 100644
--- a/drivers/staging/iio/frequency/ad5930.c
+++ b/drivers/staging/iio/frequency/ad5930.c
@@ -91,7 +91,7 @@ static const struct iio_info ad5930_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int __devinit ad5930_probe(struct spi_device *spi)
+static int ad5930_probe(struct spi_device *spi)
 {
 	struct ad5930_state *st;
 	struct iio_dev *idev;
diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index af39299..6d1f0f2 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -201,7 +201,7 @@ static const struct iio_info ad9832_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int __devinit ad9832_probe(struct spi_device *spi)
+static int ad9832_probe(struct spi_device *spi)
 {
 	struct ad9832_platform_data *pdata = spi->dev.platform_data;
 	struct iio_dev *indio_dev;
diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index dc962e5..f768083 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -314,7 +314,7 @@ static const struct iio_info ad9833_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int __devinit ad9834_probe(struct spi_device *spi)
+static int ad9834_probe(struct spi_device *spi)
 {
 	struct ad9834_platform_data *pdata = spi->dev.platform_data;
 	struct ad9834_state *st;
diff --git a/drivers/staging/iio/frequency/ad9850.c b/drivers/staging/iio/frequency/ad9850.c
index 96b18d7..d3ee5db 100644
--- a/drivers/staging/iio/frequency/ad9850.c
+++ b/drivers/staging/iio/frequency/ad9850.c
@@ -77,7 +77,7 @@ static const struct iio_info ad9850_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int __devinit ad9850_probe(struct spi_device *spi)
+static int ad9850_probe(struct spi_device *spi)
 {
 	struct ad9850_state *st;
 	struct iio_dev *idev;
diff --git a/drivers/staging/iio/frequency/ad9852.c b/drivers/staging/iio/frequency/ad9852.c
index 3ce3002..669e2cf 100644
--- a/drivers/staging/iio/frequency/ad9852.c
+++ b/drivers/staging/iio/frequency/ad9852.c
@@ -226,7 +226,7 @@ static const struct iio_info ad9852_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int __devinit ad9852_probe(struct spi_device *spi)
+static int ad9852_probe(struct spi_device *spi)
 {
 	struct ad9852_state *st;
 	struct iio_dev *idev;
diff --git a/drivers/staging/iio/frequency/ad9910.c b/drivers/staging/iio/frequency/ad9910.c
index 6a44506..eb69fbd 100644
--- a/drivers/staging/iio/frequency/ad9910.c
+++ b/drivers/staging/iio/frequency/ad9910.c
@@ -361,7 +361,7 @@ static const struct iio_info ad9910_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int __devinit ad9910_probe(struct spi_device *spi)
+static int ad9910_probe(struct spi_device *spi)
 {
 	struct ad9910_state *st;
 	struct iio_dev *idev;
diff --git a/drivers/staging/iio/frequency/ad9951.c b/drivers/staging/iio/frequency/ad9951.c
index 81e105e..1b71629 100644
--- a/drivers/staging/iio/frequency/ad9951.c
+++ b/drivers/staging/iio/frequency/ad9951.c
@@ -170,7 +170,7 @@ static const struct iio_info ad9951_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int __devinit ad9951_probe(struct spi_device *spi)
+static int ad9951_probe(struct spi_device *spi)
 {
 	struct ad9951_state *st;
 	struct iio_dev *idev;
diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
index 8c7fd27..1323b03 100644
--- a/drivers/staging/iio/gyro/adis16060_core.c
+++ b/drivers/staging/iio/gyro/adis16060_core.c
@@ -145,7 +145,7 @@ static const struct iio_chan_spec adis16060_channels[] = {
 	}
 };
 
-static int __devinit adis16060_r_probe(struct spi_device *spi)
+static int adis16060_r_probe(struct spi_device *spi)
 {
 	int ret;
 	struct adis16060_state *st;
@@ -192,7 +192,7 @@ static int __devexit adis16060_r_remove(struct spi_device *spi)
 	return 0;
 }
 
-static int __devinit adis16060_w_probe(struct spi_device *spi)
+static int adis16060_w_probe(struct spi_device *spi)
 {
 	int ret;
 	struct iio_dev *indio_dev = adis16060_iio_dev;
diff --git a/drivers/staging/iio/gyro/adis16080_core.c b/drivers/staging/iio/gyro/adis16080_core.c
index 1e7e50e..64c5b0b 100644
--- a/drivers/staging/iio/gyro/adis16080_core.c
+++ b/drivers/staging/iio/gyro/adis16080_core.c
@@ -138,7 +138,7 @@ static const struct iio_info adis16080_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int __devinit adis16080_probe(struct spi_device *spi)
+static int adis16080_probe(struct spi_device *spi)
 {
 	int ret;
 	struct adis16080_state *st;
diff --git a/drivers/staging/iio/gyro/adis16130_core.c b/drivers/staging/iio/gyro/adis16130_core.c
index fa4276d..f16219d 100644
--- a/drivers/staging/iio/gyro/adis16130_core.c
+++ b/drivers/staging/iio/gyro/adis16130_core.c
@@ -116,7 +116,7 @@ static const struct iio_info adis16130_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int __devinit adis16130_probe(struct spi_device *spi)
+static int adis16130_probe(struct spi_device *spi)
 {
 	int ret;
 	struct adis16130_state *st;
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index 11d1ef1..19b161a 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -605,7 +605,7 @@ static const struct iio_info adis16260_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int __devinit adis16260_probe(struct spi_device *spi)
+static int adis16260_probe(struct spi_device *spi)
 {
 	int ret;
 	struct adis16260_platform_data *pd = spi->dev.platform_data;
diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
index a3edc2d..d98f291 100644
--- a/drivers/staging/iio/gyro/adxrs450_core.c
+++ b/drivers/staging/iio/gyro/adxrs450_core.c
@@ -365,7 +365,7 @@ static const struct iio_info adxrs450_info = {
 	.write_raw = &adxrs450_write_raw,
 };
 
-static int __devinit adxrs450_probe(struct spi_device *spi)
+static int adxrs450_probe(struct spi_device *spi)
 {
 	int ret;
 	struct adxrs450_state *st;
diff --git a/drivers/staging/iio/iio_hwmon.c b/drivers/staging/iio/iio_hwmon.c
index b43cbb8..98df671 100644
--- a/drivers/staging/iio/iio_hwmon.c
+++ b/drivers/staging/iio/iio_hwmon.c
@@ -69,7 +69,7 @@ static void iio_hwmon_free_attrs(struct iio_hwmon_state *st)
 		}
 }
 
-static int __devinit iio_hwmon_probe(struct platform_device *pdev)
+static int iio_hwmon_probe(struct platform_device *pdev)
 {
 	struct iio_hwmon_state *st;
 	struct sensor_device_attribute *a;
diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
index dc6c728..a865adf 100644
--- a/drivers/staging/iio/iio_simple_dummy.c
+++ b/drivers/staging/iio/iio_simple_dummy.c
@@ -378,7 +378,7 @@ static int iio_dummy_init_device(struct iio_dev *indio_dev)
  *                      const struct i2c_device_id *id)
  * SPI: iio_dummy_probe(struct spi_device *spi)
  */
-static int __devinit iio_dummy_probe(int index)
+static int iio_dummy_probe(int index)
 {
 	int ret;
 	struct iio_dev *indio_dev;
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 8cde955..eed53c0 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -697,7 +697,7 @@ static void ad5933_work(struct work_struct *work)
 	mutex_unlock(&indio_dev->mlock);
 }
 
-static int __devinit ad5933_probe(struct i2c_client *client,
+static int ad5933_probe(struct i2c_client *client,
 				   const struct i2c_device_id *id)
 {
 	int ret, voltage_uv = 0;
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 73b4635..a9b2773 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -1206,7 +1206,7 @@ static const struct iio_info adis16400_info = {
 	.attrs = &adis16400_attribute_group,
 };
 
-static int __devinit adis16400_probe(struct spi_device *spi)
+static int adis16400_probe(struct spi_device *spi)
 {
 	int ret;
 	struct adis16400_state *st;
diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 6280ed7..7bc9cfd 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -543,7 +543,7 @@ static const struct regmap_config isl29018_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static int __devinit isl29018_probe(struct i2c_client *client,
+static int isl29018_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct isl29018_chip *chip;
diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index 17e9150..b72217f 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -475,7 +475,7 @@ static const struct regmap_config isl29028_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static int __devinit isl29028_probe(struct i2c_client *client,
+static int isl29028_probe(struct i2c_client *client,
 	const struct i2c_device_id *id)
 {
 	struct isl29028_chip *chip;
diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index 5f7e887..ece6dad 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -705,7 +705,7 @@ static const struct iio_info tsl2563_info = {
 	.write_event_config = &tsl2563_write_interrupt_config,
 };
 
-static int __devinit tsl2563_probe(struct i2c_client *client,
+static int tsl2563_probe(struct i2c_client *client,
 				const struct i2c_device_id *device_id)
 {
 	struct iio_dev *indio_dev;
diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index c873054..1ed3501 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -799,7 +799,7 @@ static const struct iio_info tsl2583_info = {
  * Client probe function - When a valid device is found, the driver's device
  * data structure is updated, and initialization completes successfully.
  */
-static int __devinit taos_probe(struct i2c_client *clientp,
+static int taos_probe(struct i2c_client *clientp,
 		      const struct i2c_device_id *idp)
 {
 	int i, ret;
diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
index 5c77908..8bfe527 100644
--- a/drivers/staging/iio/light/tsl2x7x_core.c
+++ b/drivers/staging/iio/light/tsl2x7x_core.c
@@ -1897,7 +1897,7 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
 	},
 };
 
-static int __devinit tsl2x7x_probe(struct i2c_client *clientp,
+static int tsl2x7x_probe(struct i2c_client *clientp,
 	const struct i2c_device_id *id)
 {
 	int ret;
diff --git a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
index a2ba22d..ca9ed7b 100644
--- a/drivers/staging/iio/magnetometer/ak8975.c
+++ b/drivers/staging/iio/magnetometer/ak8975.c
@@ -409,7 +409,7 @@ static const struct iio_info ak8975_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int __devinit ak8975_probe(struct i2c_client *client,
+static int ak8975_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	struct ak8975_data *data;
diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index 233f2b8..c543523 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -665,7 +665,7 @@ static const struct iio_info hmc5843_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int __devinit hmc5843_probe(struct i2c_client *client,
+static int hmc5843_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct hmc5843_data *data;
diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
index c9ffcdb..8cd721f 100644
--- a/drivers/staging/iio/meter/ade7753.c
+++ b/drivers/staging/iio/meter/ade7753.c
@@ -512,7 +512,7 @@ static const struct iio_info ade7753_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int __devinit ade7753_probe(struct spi_device *spi)
+static int ade7753_probe(struct spi_device *spi)
 {
 	int ret;
 	struct ade7753_state *st;
diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
index 21463eb..185e887 100644
--- a/drivers/staging/iio/meter/ade7754.c
+++ b/drivers/staging/iio/meter/ade7754.c
@@ -535,7 +535,7 @@ static const struct iio_info ade7754_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int __devinit ade7754_probe(struct spi_device *spi)
+static int ade7754_probe(struct spi_device *spi)
 {
 	int ret;
 	struct ade7754_state *st;
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 6950d1f..ff8013a 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -881,7 +881,7 @@ static const struct iio_info ade7758_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int __devinit ade7758_probe(struct spi_device *spi)
+static int ade7758_probe(struct spi_device *spi)
 {
 	int ret;
 	struct ade7758_state *st;
diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
index 729ce94..1d55fba 100644
--- a/drivers/staging/iio/meter/ade7759.c
+++ b/drivers/staging/iio/meter/ade7759.c
@@ -458,7 +458,7 @@ static const struct iio_info ade7759_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int __devinit ade7759_probe(struct spi_device *spi)
+static int ade7759_probe(struct spi_device *spi)
 {
 	int ret;
 	struct ade7759_state *st;
diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
index 16412ca..2fbdcc5 100644
--- a/drivers/staging/iio/meter/ade7854-i2c.c
+++ b/drivers/staging/iio/meter/ade7854-i2c.c
@@ -201,7 +201,7 @@ out:
 	return ret;
 }
 
-static int __devinit ade7854_i2c_probe(struct i2c_client *client,
+static int ade7854_i2c_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
 	int ret;
diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
index b3845e6..e4ced89 100644
--- a/drivers/staging/iio/meter/ade7854-spi.c
+++ b/drivers/staging/iio/meter/ade7854-spi.c
@@ -300,7 +300,7 @@ error_ret:
 	return ret;
 }
 
-static int __devinit ade7854_spi_probe(struct spi_device *spi)
+static int ade7854_spi_probe(struct spi_device *spi)
 {
 	int ret;
 	struct ade7854_state *st;
diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
index bbb4c93..f978af0 100644
--- a/drivers/staging/iio/resolver/ad2s1200.c
+++ b/drivers/staging/iio/resolver/ad2s1200.c
@@ -99,7 +99,7 @@ static const struct iio_info ad2s1200_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int __devinit ad2s1200_probe(struct spi_device *spi)
+static int ad2s1200_probe(struct spi_device *spi)
 {
 	struct ad2s1200_state *st;
 	struct iio_dev *indio_dev;
diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 5c5d01a..6361eb9 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -610,7 +610,7 @@ static const struct attribute_group ad2s1210_attribute_group = {
 	.attrs = ad2s1210_attributes,
 };
 
-static int __devinit ad2s1210_initial(struct ad2s1210_state *st)
+static int ad2s1210_initial(struct ad2s1210_state *st)
 {
 	unsigned char data;
 	int ret;
@@ -681,7 +681,7 @@ static void ad2s1210_free_gpios(struct ad2s1210_state *st)
 	gpio_free_array(ad2s1210_gpios, ARRAY_SIZE(ad2s1210_gpios));
 }
 
-static int __devinit ad2s1210_probe(struct spi_device *spi)
+static int ad2s1210_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
 	struct ad2s1210_state *st;
diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index f15c0af..8790ae4 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -58,7 +58,7 @@ static const struct iio_chan_spec ad2s90_chan = {
 	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
 };
 
-static int __devinit ad2s90_probe(struct spi_device *spi)
+static int ad2s90_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
 	struct ad2s90_state *st;
diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
index eb976d8..d1eb029 100644
--- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
+++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
@@ -180,7 +180,7 @@ static const struct iio_trigger_ops iio_bfin_tmr_trigger_ops = {
 	.set_trigger_state = iio_bfin_tmr_set_state,
 };
 
-static int __devinit iio_bfin_tmr_trigger_probe(struct platform_device *pdev)
+static int iio_bfin_tmr_trigger_probe(struct platform_device *pdev)
 {
 	struct iio_bfin_timer_trigger_pdata *pdata = pdev->dev.platform_data;
 	struct bfin_tmr_state *st;
diff --git a/drivers/staging/iio/trigger/iio-trig-gpio.c b/drivers/staging/iio/trigger/iio-trig-gpio.c
index 5f53393..47eabea 100644
--- a/drivers/staging/iio/trigger/iio-trig-gpio.c
+++ b/drivers/staging/iio/trigger/iio-trig-gpio.c
@@ -51,7 +51,7 @@ static const struct iio_trigger_ops iio_gpio_trigger_ops = {
 	.owner = THIS_MODULE,
 };
 
-static int __devinit iio_gpio_trigger_probe(struct platform_device *pdev)
+static int iio_gpio_trigger_probe(struct platform_device *pdev)
 {
 	struct iio_gpio_trigger_info *trig_info;
 	struct iio_trigger *trig, *trig2;
diff --git a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
index 079dce7..879ca3b 100644
--- a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
+++ b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
@@ -101,7 +101,7 @@ static const struct iio_trigger_ops iio_prtc_trigger_ops = {
 	.set_trigger_state = &iio_trig_periodic_rtc_set_state,
 };
 
-static int __devinit iio_trig_periodic_rtc_probe(struct platform_device *dev)
+static int iio_trig_periodic_rtc_probe(struct platform_device *dev)
 {
 	char **pdata = dev->dev.platform_data;
 	struct iio_prtc_trigger_info *trig_info;
-- 
1.8.0

