Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:41506 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754320Ab2KSSfP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 19 Nov 2012 13:35:15 -0500
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 448/493] staging: iio: remove use of __devexit
Date: Mon, 19 Nov 2012 13:26:37 -0500
Message-Id: <1353349642-3677-448-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devexit is no
longer needed.

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
 drivers/staging/iio/accel/kxsd9.c                   | 2 +-
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
 drivers/staging/iio/resolver/ad2s1210.c             | 2 +-
 drivers/staging/iio/resolver/ad2s90.c               | 2 +-
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c   | 2 +-
 drivers/staging/iio/trigger/iio-trig-gpio.c         | 2 +-
 drivers/staging/iio/trigger/iio-trig-periodic-rtc.c | 2 +-
 63 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
index 21da0a1..b1987db 100644
--- a/drivers/staging/iio/accel/adis16201_core.c
+++ b/drivers/staging/iio/accel/adis16201_core.c
@@ -567,7 +567,7 @@ error_ret:
 	return ret;
 }
 
-static int __devexit adis16201_remove(struct spi_device *spi)
+static int adis16201_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index 6f9c359..70bd231 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -500,7 +500,7 @@ error_ret:
 	return ret;
 }
 
-static int __devexit adis16203_remove(struct spi_device *spi)
+static int adis16203_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
index 632c17a..c089c93 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -558,7 +558,7 @@ error_ret:
 	return ret;
 }
 
-static int __devexit adis16204_remove(struct spi_device *spi)
+static int adis16204_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index 3467624..fd2274f 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -573,7 +573,7 @@ error_ret:
 	return ret;
 }
 
-static int __devexit adis16209_remove(struct spi_device *spi)
+static int adis16209_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
index 0ce4fe8..2b14b99 100644
--- a/drivers/staging/iio/accel/adis16220_core.c
+++ b/drivers/staging/iio/accel/adis16220_core.c
@@ -664,7 +664,7 @@ error_ret:
 	return ret;
 }
 
-static int __devexit adis16220_remove(struct spi_device *spi)
+static int adis16220_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index 03c91a8..833b488 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -618,7 +618,7 @@ error_ret:
 	return ret;
 }
 
-static int __devexit adis16240_remove(struct spi_device *spi)
+static int adis16240_remove(struct spi_device *spi)
 {
 
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
diff --git a/drivers/staging/iio/accel/kxsd9.c b/drivers/staging/iio/accel/kxsd9.c
index 8dc04a3..318331f 100644
--- a/drivers/staging/iio/accel/kxsd9.c
+++ b/drivers/staging/iio/accel/kxsd9.c
@@ -261,7 +261,7 @@ error_ret:
 	return ret;
 }
 
-static int __devexit kxsd9_remove(struct spi_device *spi)
+static int kxsd9_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
 	iio_device_free(spi_get_drvdata(spi));
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index bc07ca9..37ed1b8 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -782,7 +782,7 @@ err_ret:
 }
 
 /* fixme, confirm ordering in this function */
-static int __devexit lis3l02dq_remove(struct spi_device *spi)
+static int lis3l02dq_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct lis3l02dq_state *st = iio_priv(indio_dev);
diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index c50159d..414d3ca 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -1233,7 +1233,7 @@ error_ret:
 	return ret;
 }
 
-static int __devexit sca3000_remove(struct spi_device *spi)
+static int sca3000_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct sca3000_state *st = iio_priv(indio_dev);
diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 434cf76..5047019 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -686,7 +686,7 @@ error_put_reg:
 	return ret;
 }
 
-static int __devexit ad7192_remove(struct spi_device *spi)
+static int ad7192_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad7192_state *st = iio_priv(indio_dev);
diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 7b0e5b5..fa81a49 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -950,7 +950,7 @@ error_free_device:
 	return ret;
 }
 
-static int __devexit ad7280_remove(struct spi_device *spi)
+static int ad7280_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad7280_state *st = iio_priv(indio_dev);
diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index 55f193a..6e58e36 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -674,7 +674,7 @@ error_ret:
 	return ret;
 }
 
-static int __devexit ad7291_remove(struct i2c_client *client)
+static int ad7291_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct ad7291_chip_info *chip = iio_priv(indio_dev);
diff --git a/drivers/staging/iio/adc/ad7298_core.c b/drivers/staging/iio/adc/ad7298_core.c
index cb7e40e..a250e18 100644
--- a/drivers/staging/iio/adc/ad7298_core.c
+++ b/drivers/staging/iio/adc/ad7298_core.c
@@ -251,7 +251,7 @@ error_put_reg:
 	return ret;
 }
 
-static int __devexit ad7298_remove(struct spi_device *spi)
+static int ad7298_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad7298_state *st = iio_priv(indio_dev);
diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/staging/iio/adc/ad7606_par.c
index 971c57a..58cfdde 100644
--- a/drivers/staging/iio/adc/ad7606_par.c
+++ b/drivers/staging/iio/adc/ad7606_par.c
@@ -100,7 +100,7 @@ out1:
 	return ret;
 }
 
-static int __devexit ad7606_par_remove(struct platform_device *pdev)
+static int ad7606_par_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct resource *res;
diff --git a/drivers/staging/iio/adc/ad7606_spi.c b/drivers/staging/iio/adc/ad7606_spi.c
index 6fd48c4..6a8ecd7 100644
--- a/drivers/staging/iio/adc/ad7606_spi.c
+++ b/drivers/staging/iio/adc/ad7606_spi.c
@@ -55,7 +55,7 @@ static int ad7606_spi_probe(struct spi_device *spi)
 	return 0;
 }
 
-static int __devexit ad7606_spi_remove(struct spi_device *spi)
+static int ad7606_spi_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(&spi->dev);
 
diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index bace04b..e1f8860 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -248,7 +248,7 @@ error_put_reg:
 	return ret;
 }
 
-static int __devexit ad7780_remove(struct spi_device *spi)
+static int ad7780_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad7780_state *st = iio_priv(indio_dev);
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index d07b016..b0a57e4 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -522,7 +522,7 @@ error_put_reg:
 	return ret;
 }
 
-static int __devexit ad7793_remove(struct spi_device *spi)
+static int ad7793_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad7793_state *st = iio_priv(indio_dev);
diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 51b94cc..9284771 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -431,7 +431,7 @@ error_ret:
 	return ret;
 }
 
-static int __devexit ad7816_remove(struct spi_device *spi_dev)
+static int ad7816_remove(struct spi_device *spi_dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(&spi_dev->dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 4f49092..077eedb 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -932,7 +932,7 @@ error_put_reg:
 	return ret;
 }
 
-static __devexit int ad799x_remove(struct i2c_client *client)
+static int ad799x_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct ad799x_state *st = iio_priv(indio_dev);
diff --git a/drivers/staging/iio/adc/adt7410.c b/drivers/staging/iio/adc/adt7410.c
index f90de26..02cd5dc 100644
--- a/drivers/staging/iio/adc/adt7410.c
+++ b/drivers/staging/iio/adc/adt7410.c
@@ -792,7 +792,7 @@ error_ret:
 	return ret;
 }
 
-static int __devexit adt7410_remove(struct device *dev, int irq)
+static int adt7410_remove(struct device *dev, int irq)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	unsigned long *adt7410_platform_data = dev->platform_data;
@@ -883,7 +883,7 @@ static int adt7410_i2c_probe(struct i2c_client *client,
 		&adt7410_i2c_ops);
 }
 
-static int __devexit adt7410_i2c_remove(struct i2c_client *client)
+static int adt7410_i2c_remove(struct i2c_client *client)
 {
 	return adt7410_remove(&client->dev, client->irq);
 }
@@ -1036,7 +1036,7 @@ static int adt7310_spi_probe(struct spi_device *spi)
 		spi_get_device_id(spi)->name, &adt7310_spi_ops);
 }
 
-static int __devexit adt7310_spi_remove(struct spi_device *spi)
+static int adt7310_spi_remove(struct spi_device *spi)
 {
 	return adt7410_remove(&spi->dev, spi->irq);
 }
diff --git a/drivers/staging/iio/adc/lpc32xx_adc.c b/drivers/staging/iio/adc/lpc32xx_adc.c
index e503686..0bf2a6c 100644
--- a/drivers/staging/iio/adc/lpc32xx_adc.c
+++ b/drivers/staging/iio/adc/lpc32xx_adc.c
@@ -207,7 +207,7 @@ errout1:
 	return retval;
 }
 
-static int __devexit lpc32xx_adc_remove(struct platform_device *pdev)
+static int lpc32xx_adc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *iodev = platform_get_drvdata(pdev);
 	struct lpc32xx_adc_info *info = iio_priv(iodev);
diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index 53b3322..fb31b45 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -551,7 +551,7 @@ err_addr:
 	return ret;
 }
 
-static int __devexit mxs_lradc_remove(struct platform_device *pdev)
+static int mxs_lradc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *iio = platform_get_drvdata(pdev);
 	struct mxs_lradc *lradc = iio_priv(iio);
diff --git a/drivers/staging/iio/adc/spear_adc.c b/drivers/staging/iio/adc/spear_adc.c
index 23a58df..13052ce 100644
--- a/drivers/staging/iio/adc/spear_adc.c
+++ b/drivers/staging/iio/adc/spear_adc.c
@@ -401,7 +401,7 @@ errout1:
 	return ret;
 }
 
-static int __devexit spear_adc_remove(struct platform_device *pdev)
+static int spear_adc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *iodev = platform_get_drvdata(pdev);
 	struct spear_adc_info *info = iio_priv(iodev);
diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
index ca10ebe..ce7d91c 100644
--- a/drivers/staging/iio/addac/adt7316-i2c.c
+++ b/drivers/staging/iio/addac/adt7316-i2c.c
@@ -108,7 +108,7 @@ static int adt7316_i2c_probe(struct i2c_client *client,
 	return adt7316_probe(&client->dev, &bus, id->name);
 }
 
-static int __devexit adt7316_i2c_remove(struct i2c_client *client)
+static int adt7316_i2c_remove(struct i2c_client *client)
 {
 	return adt7316_remove(&client->dev);
 }
diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/iio/addac/adt7316-spi.c
index 5c03854..0db8ef5 100644
--- a/drivers/staging/iio/addac/adt7316-spi.c
+++ b/drivers/staging/iio/addac/adt7316-spi.c
@@ -116,7 +116,7 @@ static int adt7316_spi_probe(struct spi_device *spi_dev)
 	return adt7316_probe(&spi_dev->dev, &bus, spi_dev->modalias);
 }
 
-static int __devexit adt7316_spi_remove(struct spi_device *spi_dev)
+static int adt7316_spi_remove(struct spi_device *spi_dev)
 {
 	return adt7316_remove(&spi_dev->dev);
 }
diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 487f5e0..0b431bc 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -2216,7 +2216,7 @@ error_ret:
 }
 EXPORT_SYMBOL(adt7316_probe);
 
-int __devexit adt7316_remove(struct device *dev)
+int adt7316_remove(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adt7316_chip_info *chip = iio_priv(indio_dev);
diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 4759b5e..3c608c1 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -628,7 +628,7 @@ error_ret:
 	return ret;
 }
 
-static int __devexit ad7150_remove(struct i2c_client *client)
+static int ad7150_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
index 42d63be..3c92ba3 100644
--- a/drivers/staging/iio/cdc/ad7152.c
+++ b/drivers/staging/iio/cdc/ad7152.c
@@ -518,7 +518,7 @@ error_ret:
 	return ret;
 }
 
-static int __devexit ad7152_remove(struct i2c_client *client)
+static int ad7152_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 05e9691..466b82e 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -768,7 +768,7 @@ error_ret:
 	return ret;
 }
 
-static int __devexit ad7746_remove(struct i2c_client *client)
+static int ad7746_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
diff --git a/drivers/staging/iio/frequency/ad5930.c b/drivers/staging/iio/frequency/ad5930.c
index 87c232e..23777be 100644
--- a/drivers/staging/iio/frequency/ad5930.c
+++ b/drivers/staging/iio/frequency/ad5930.c
@@ -127,7 +127,7 @@ error_ret:
 	return ret;
 }
 
-static int __devexit ad5930_remove(struct spi_device *spi)
+static int ad5930_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
 	iio_device_free(spi_get_drvdata(spi));
diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 6d1f0f2..4e18380 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -324,7 +324,7 @@ error_put_reg:
 	return ret;
 }
 
-static int __devexit ad9832_remove(struct spi_device *spi)
+static int ad9832_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad9832_state *st = iio_priv(indio_dev);
diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index f768083..5cba3c0 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -424,7 +424,7 @@ error_put_reg:
 	return ret;
 }
 
-static int __devexit ad9834_remove(struct spi_device *spi)
+static int ad9834_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad9834_state *st = iio_priv(indio_dev);
diff --git a/drivers/staging/iio/frequency/ad9850.c b/drivers/staging/iio/frequency/ad9850.c
index d3ee5db..104f7a4 100644
--- a/drivers/staging/iio/frequency/ad9850.c
+++ b/drivers/staging/iio/frequency/ad9850.c
@@ -113,7 +113,7 @@ error_ret:
 	return ret;
 }
 
-static int __devexit ad9850_remove(struct spi_device *spi)
+static int ad9850_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
 	iio_device_free(spi_get_drvdata(spi));
diff --git a/drivers/staging/iio/frequency/ad9852.c b/drivers/staging/iio/frequency/ad9852.c
index 669e2cf..17ac825 100644
--- a/drivers/staging/iio/frequency/ad9852.c
+++ b/drivers/staging/iio/frequency/ad9852.c
@@ -264,7 +264,7 @@ error_ret:
 	return ret;
 }
 
-static int __devexit ad9852_remove(struct spi_device *spi)
+static int ad9852_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
 	iio_device_free(spi_get_drvdata(spi));
diff --git a/drivers/staging/iio/frequency/ad9910.c b/drivers/staging/iio/frequency/ad9910.c
index eb69fbd..e48f874 100644
--- a/drivers/staging/iio/frequency/ad9910.c
+++ b/drivers/staging/iio/frequency/ad9910.c
@@ -397,7 +397,7 @@ error_ret:
 	return ret;
 }
 
-static int __devexit ad9910_remove(struct spi_device *spi)
+static int ad9910_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
 	iio_device_free(spi_get_drvdata(spi));
diff --git a/drivers/staging/iio/frequency/ad9951.c b/drivers/staging/iio/frequency/ad9951.c
index 1b71629..8234e3c 100644
--- a/drivers/staging/iio/frequency/ad9951.c
+++ b/drivers/staging/iio/frequency/ad9951.c
@@ -208,7 +208,7 @@ error_ret:
 	return ret;
 }
 
-static int __devexit ad9951_remove(struct spi_device *spi)
+static int ad9951_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
 	iio_device_free(spi_get_drvdata(spi));
diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
index 1323b03..687c151 100644
--- a/drivers/staging/iio/gyro/adis16060_core.c
+++ b/drivers/staging/iio/gyro/adis16060_core.c
@@ -184,7 +184,7 @@ error_ret:
 }
 
 /* fixme, confirm ordering in this function */
-static int __devexit adis16060_r_remove(struct spi_device *spi)
+static int adis16060_r_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
 	iio_device_free(spi_get_drvdata(spi));
@@ -210,7 +210,7 @@ error_ret:
 	return ret;
 }
 
-static int __devexit adis16060_w_remove(struct spi_device *spi)
+static int adis16060_w_remove(struct spi_device *spi)
 {
 	return 0;
 }
diff --git a/drivers/staging/iio/gyro/adis16080_core.c b/drivers/staging/iio/gyro/adis16080_core.c
index 64c5b0b..3525a68 100644
--- a/drivers/staging/iio/gyro/adis16080_core.c
+++ b/drivers/staging/iio/gyro/adis16080_core.c
@@ -177,7 +177,7 @@ error_ret:
 }
 
 /* fixme, confirm ordering in this function */
-static int __devexit adis16080_remove(struct spi_device *spi)
+static int adis16080_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
 	iio_device_free(spi_get_drvdata(spi));
diff --git a/drivers/staging/iio/gyro/adis16130_core.c b/drivers/staging/iio/gyro/adis16130_core.c
index f16219d..835801e 100644
--- a/drivers/staging/iio/gyro/adis16130_core.c
+++ b/drivers/staging/iio/gyro/adis16130_core.c
@@ -154,7 +154,7 @@ error_ret:
 }
 
 /* fixme, confirm ordering in this function */
-static int __devexit adis16130_remove(struct spi_device *spi)
+static int adis16130_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
 	iio_device_free(spi_get_drvdata(spi));
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index 19b161a..ad8a478 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -703,7 +703,7 @@ error_ret:
 	return ret;
 }
 
-static int __devexit adis16260_remove(struct spi_device *spi)
+static int adis16260_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
index d98f291..f0ce81d 100644
--- a/drivers/staging/iio/gyro/adxrs450_core.c
+++ b/drivers/staging/iio/gyro/adxrs450_core.c
@@ -409,7 +409,7 @@ error_ret:
 	return ret;
 }
 
-static int __devexit adxrs450_remove(struct spi_device *spi)
+static int adxrs450_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
 	iio_device_free(spi_get_drvdata(spi));
diff --git a/drivers/staging/iio/iio_hwmon.c b/drivers/staging/iio/iio_hwmon.c
index 98df671..c7a5f97 100644
--- a/drivers/staging/iio/iio_hwmon.c
+++ b/drivers/staging/iio/iio_hwmon.c
@@ -170,7 +170,7 @@ error_ret:
 	return ret;
 }
 
-static int __devexit iio_hwmon_remove(struct platform_device *pdev)
+static int iio_hwmon_remove(struct platform_device *pdev)
 {
 	struct iio_hwmon_state *st = platform_get_drvdata(pdev);
 
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index eed53c0..779243d 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -787,7 +787,7 @@ error_put_reg:
 	return ret;
 }
 
-static __devexit int ad5933_remove(struct i2c_client *client)
+static int ad5933_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct ad5933_state *st = iio_priv(indio_dev);
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index a9b2773..9c8f5ab 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -1273,7 +1273,7 @@ error_ret:
 }
 
 /* fixme, confirm ordering in this function */
-static int __devexit adis16400_remove(struct spi_device *spi)
+static int adis16400_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev =  spi_get_drvdata(spi);
 
diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 7bc9cfd..b2b7b94 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -598,7 +598,7 @@ exit:
 	return err;
 }
 
-static int __devexit isl29018_remove(struct i2c_client *client)
+static int isl29018_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index b72217f..e52af77 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -526,7 +526,7 @@ exit_iio_free:
 	return ret;
 }
 
-static int __devexit isl29028_remove(struct i2c_client *client)
+static int isl29028_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index ece6dad..232d88f 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -805,7 +805,7 @@ fail1:
 	return err;
 }
 
-static int __devexit tsl2563_remove(struct i2c_client *client)
+static int tsl2563_remove(struct i2c_client *client)
 {
 	struct tsl2563_chip *chip = i2c_get_clientdata(client);
 	struct iio_dev *indio_dev = iio_priv_to_dev(chip);
diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 1ed3501..b377dd3 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -923,7 +923,7 @@ static SIMPLE_DEV_PM_OPS(taos_pm_ops, taos_suspend, taos_resume);
 #define TAOS_PM_OPS NULL
 #endif
 
-static int __devexit taos_remove(struct i2c_client *client)
+static int taos_remove(struct i2c_client *client)
 {
 	iio_device_unregister(i2c_get_clientdata(client));
 	iio_device_free(i2c_get_clientdata(client));
diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
index 8bfe527..9e50fbb 100644
--- a/drivers/staging/iio/light/tsl2x7x_core.c
+++ b/drivers/staging/iio/light/tsl2x7x_core.c
@@ -2026,7 +2026,7 @@ static int tsl2x7x_resume(struct device *dev)
 	return ret;
 }
 
-static int __devexit tsl2x7x_remove(struct i2c_client *client)
+static int tsl2x7x_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
diff --git a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
index ca9ed7b..28f080e 100644
--- a/drivers/staging/iio/magnetometer/ak8975.c
+++ b/drivers/staging/iio/magnetometer/ak8975.c
@@ -475,7 +475,7 @@ exit:
 	return err;
 }
 
-static int __devexit ak8975_remove(struct i2c_client *client)
+static int ak8975_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct ak8975_data *data = iio_priv(indio_dev);
diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index c543523..1a520ec 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -704,7 +704,7 @@ exit:
 	return err;
 }
 
-static int __devexit hmc5843_remove(struct i2c_client *client)
+static int hmc5843_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
index 8cd721f..51c3bde 100644
--- a/drivers/staging/iio/meter/ade7753.c
+++ b/drivers/staging/iio/meter/ade7753.c
@@ -555,7 +555,7 @@ error_ret:
 }
 
 /* fixme, confirm ordering in this function */
-static int __devexit ade7753_remove(struct spi_device *spi)
+static int ade7753_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
index 185e887..b50c89e 100644
--- a/drivers/staging/iio/meter/ade7754.c
+++ b/drivers/staging/iio/meter/ade7754.c
@@ -577,7 +577,7 @@ error_ret:
 }
 
 /* fixme, confirm ordering in this function */
-static int __devexit ade7754_remove(struct spi_device *spi)
+static int ade7754_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index ff8013a..3454e51 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -962,7 +962,7 @@ error_ret:
 	return ret;
 }
 
-static int __devexit ade7758_remove(struct spi_device *spi)
+static int ade7758_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ade7758_state *st = iio_priv(indio_dev);
diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
index 1d55fba..10b911b 100644
--- a/drivers/staging/iio/meter/ade7759.c
+++ b/drivers/staging/iio/meter/ade7759.c
@@ -499,7 +499,7 @@ error_ret:
 }
 
 /* fixme, confirm ordering in this function */
-static int __devexit ade7759_remove(struct spi_device *spi)
+static int ade7759_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
index 2fbdcc5..db9ef6c 100644
--- a/drivers/staging/iio/meter/ade7854-i2c.c
+++ b/drivers/staging/iio/meter/ade7854-i2c.c
@@ -231,7 +231,7 @@ static int ade7854_i2c_probe(struct i2c_client *client,
 	return ret;
 }
 
-static int __devexit ade7854_i2c_remove(struct i2c_client *client)
+static int ade7854_i2c_remove(struct i2c_client *client)
 {
 	return ade7854_remove(i2c_get_clientdata(client));
 }
diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
index e4ced89..f0984fa 100644
--- a/drivers/staging/iio/meter/ade7854-spi.c
+++ b/drivers/staging/iio/meter/ade7854-spi.c
@@ -330,7 +330,7 @@ static int ade7854_spi_probe(struct spi_device *spi)
 	return 0;
 }
 
-static int __devexit ade7854_spi_remove(struct spi_device *spi)
+static int ade7854_spi_remove(struct spi_device *spi)
 {
 	ade7854_remove(spi_get_drvdata(spi));
 
diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
index f978af0..4fe3499 100644
--- a/drivers/staging/iio/resolver/ad2s1200.c
+++ b/drivers/staging/iio/resolver/ad2s1200.c
@@ -149,7 +149,7 @@ error_ret:
 	return ret;
 }
 
-static int __devexit ad2s1200_remove(struct spi_device *spi)
+static int ad2s1200_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
 	iio_device_free(spi_get_drvdata(spi));
diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 6361eb9..ed07a34 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -736,7 +736,7 @@ error_ret:
 	return ret;
 }
 
-static int __devexit ad2s1210_remove(struct spi_device *spi)
+static int ad2s1210_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index 8790ae4..0aecfbc 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -98,7 +98,7 @@ error_ret:
 	return ret;
 }
 
-static int __devexit ad2s90_remove(struct spi_device *spi)
+static int ad2s90_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
 	iio_device_free(spi_get_drvdata(spi));
diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
index d1eb029..42798da 100644
--- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
+++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
@@ -275,7 +275,7 @@ out:
 	return ret;
 }
 
-static int __devexit iio_bfin_tmr_trigger_remove(struct platform_device *pdev)
+static int iio_bfin_tmr_trigger_remove(struct platform_device *pdev)
 {
 	struct bfin_tmr_state *st = platform_get_drvdata(pdev);
 
diff --git a/drivers/staging/iio/trigger/iio-trig-gpio.c b/drivers/staging/iio/trigger/iio-trig-gpio.c
index 47eabea..fcc4cb0 100644
--- a/drivers/staging/iio/trigger/iio-trig-gpio.c
+++ b/drivers/staging/iio/trigger/iio-trig-gpio.c
@@ -130,7 +130,7 @@ error_free_completed_registrations:
 	return ret;
 }
 
-static int __devexit iio_gpio_trigger_remove(struct platform_device *pdev)
+static int iio_gpio_trigger_remove(struct platform_device *pdev)
 {
 	struct iio_trigger *trig, *trig2;
 	struct iio_gpio_trigger_info *trig_info;
diff --git a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
index 879ca3b..9102b1b 100644
--- a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
+++ b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
@@ -167,7 +167,7 @@ error_free_completed_registrations:
 	return ret;
 }
 
-static int __devexit iio_trig_periodic_rtc_remove(struct platform_device *dev)
+static int iio_trig_periodic_rtc_remove(struct platform_device *dev)
 {
 	struct iio_trigger *trig, *trig2;
 	struct iio_prtc_trigger_info *trig_info;
-- 
1.8.0

