Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:41865 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754311Ab2KSSnB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 19 Nov 2012 13:43:01 -0500
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 149/493] staging: iio: remove use of __devexit_p
Date: Mon, 19 Nov 2012 13:21:38 -0500
Message-Id: <1353349642-3677-149-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
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
 drivers/staging/iio/adc/adt7410.c                   | 4 ++--
 drivers/staging/iio/adc/lpc32xx_adc.c               | 2 +-
 drivers/staging/iio/adc/mxs-lradc.c                 | 2 +-
 drivers/staging/iio/adc/spear_adc.c                 | 2 +-
 drivers/staging/iio/addac/adt7316-i2c.c             | 2 +-
 drivers/staging/iio/addac/adt7316-spi.c             | 2 +-
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
 62 files changed, 64 insertions(+), 64 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
index d2a203a..bb83fd1 100644
--- a/drivers/staging/iio/accel/adis16201_core.c
+++ b/drivers/staging/iio/accel/adis16201_core.c
@@ -586,7 +586,7 @@ static struct spi_driver adis16201_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = adis16201_probe,
-	.remove = __devexit_p(adis16201_remove),
+	.remove = adis16201_remove,
 };
 module_spi_driver(adis16201_driver);
 
diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index 7d7c4d2..45d7402 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -519,7 +519,7 @@ static struct spi_driver adis16203_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = adis16203_probe,
-	.remove = __devexit_p(adis16203_remove),
+	.remove = adis16203_remove,
 };
 module_spi_driver(adis16203_driver);
 
diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
index 9b75a2b..7ab2cc0 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -577,7 +577,7 @@ static struct spi_driver adis16204_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = adis16204_probe,
-	.remove = __devexit_p(adis16204_remove),
+	.remove = adis16204_remove,
 };
 module_spi_driver(adis16204_driver);
 
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index b7a0d5c..508a861 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -592,7 +592,7 @@ static struct spi_driver adis16209_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = adis16209_probe,
-	.remove = __devexit_p(adis16209_remove),
+	.remove = adis16209_remove,
 };
 module_spi_driver(adis16209_driver);
 
diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
index 22807ac..9b26466 100644
--- a/drivers/staging/iio/accel/adis16220_core.c
+++ b/drivers/staging/iio/accel/adis16220_core.c
@@ -683,7 +683,7 @@ static struct spi_driver adis16220_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = adis16220_probe,
-	.remove = __devexit_p(adis16220_remove),
+	.remove = adis16220_remove,
 };
 module_spi_driver(adis16220_driver);
 
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index 289f819..638bbed 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -638,7 +638,7 @@ static struct spi_driver adis16240_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = adis16240_probe,
-	.remove = __devexit_p(adis16240_remove),
+	.remove = adis16240_remove,
 };
 module_spi_driver(adis16240_driver);
 
diff --git a/drivers/staging/iio/accel/kxsd9.c b/drivers/staging/iio/accel/kxsd9.c
index e8e6e3f..b432c6b 100644
--- a/drivers/staging/iio/accel/kxsd9.c
+++ b/drivers/staging/iio/accel/kxsd9.c
@@ -281,7 +281,7 @@ static struct spi_driver kxsd9_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = kxsd9_probe,
-	.remove = __devexit_p(kxsd9_remove),
+	.remove = kxsd9_remove,
 	.id_table = kxsd9_id,
 };
 module_spi_driver(kxsd9_driver);
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index d13c7e9..dbb9617 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -810,7 +810,7 @@ static struct spi_driver lis3l02dq_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = lis3l02dq_probe,
-	.remove = __devexit_p(lis3l02dq_remove),
+	.remove = lis3l02dq_remove,
 };
 module_spi_driver(lis3l02dq_driver);
 
diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index ffd1697..6955187 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -1265,7 +1265,7 @@ static struct spi_driver sca3000_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = sca3000_probe,
-	.remove = __devexit_p(sca3000_remove),
+	.remove = sca3000_remove,
 	.id_table = sca3000_id,
 };
 module_spi_driver(sca3000_driver);
diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index aeaa61d..7fad227 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -716,7 +716,7 @@ static struct spi_driver ad7192_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ad7192_probe,
-	.remove		= __devexit_p(ad7192_remove),
+	.remove		= ad7192_remove,
 	.id_table	= ad7192_id,
 };
 module_spi_driver(ad7192_driver);
diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index e7cb3b2..1623dc8 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -981,7 +981,7 @@ static struct spi_driver ad7280_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ad7280_probe,
-	.remove		= __devexit_p(ad7280_remove),
+	.remove		= ad7280_remove,
 	.id_table	= ad7280_id,
 };
 module_spi_driver(ad7280_driver);
diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index 029b39c..86325cb 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -706,7 +706,7 @@ static struct i2c_driver ad7291_driver = {
 		.name = KBUILD_MODNAME,
 	},
 	.probe = ad7291_probe,
-	.remove = __devexit_p(ad7291_remove),
+	.remove = ad7291_remove,
 	.id_table = ad7291_id,
 };
 module_i2c_driver(ad7291_driver);
diff --git a/drivers/staging/iio/adc/ad7298_core.c b/drivers/staging/iio/adc/ad7298_core.c
index 4c75114..13be112 100644
--- a/drivers/staging/iio/adc/ad7298_core.c
+++ b/drivers/staging/iio/adc/ad7298_core.c
@@ -279,7 +279,7 @@ static struct spi_driver ad7298_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ad7298_probe,
-	.remove		= __devexit_p(ad7298_remove),
+	.remove		= ad7298_remove,
 	.id_table	= ad7298_id,
 };
 module_spi_driver(ad7298_driver);
diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/staging/iio/adc/ad7606_par.c
index a53faaf..864bab8 100644
--- a/drivers/staging/iio/adc/ad7606_par.c
+++ b/drivers/staging/iio/adc/ad7606_par.c
@@ -164,7 +164,7 @@ MODULE_DEVICE_TABLE(platform, ad7606_driver_ids);
 
 static struct platform_driver ad7606_driver = {
 	.probe = ad7606_par_probe,
-	.remove	= __devexit_p(ad7606_par_remove),
+	.remove	= ad7606_par_remove,
 	.id_table = ad7606_driver_ids,
 	.driver = {
 		.name	 = "ad7606",
diff --git a/drivers/staging/iio/adc/ad7606_spi.c b/drivers/staging/iio/adc/ad7606_spi.c
index 099d347..ba7779cd 100644
--- a/drivers/staging/iio/adc/ad7606_spi.c
+++ b/drivers/staging/iio/adc/ad7606_spi.c
@@ -106,7 +106,7 @@ static struct spi_driver ad7606_driver = {
 		.pm    = AD7606_SPI_PM_OPS,
 	},
 	.probe = ad7606_spi_probe,
-	.remove = __devexit_p(ad7606_spi_remove),
+	.remove = ad7606_spi_remove,
 	.id_table = ad7606_id,
 };
 module_spi_driver(ad7606_driver);
diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index 0a1328b..a6b261e 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -283,7 +283,7 @@ static struct spi_driver ad7780_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ad7780_probe,
-	.remove		= __devexit_p(ad7780_remove),
+	.remove		= ad7780_remove,
 	.id_table	= ad7780_id,
 };
 module_spi_driver(ad7780_driver);
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index 691a7be..1fe68f7 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -556,7 +556,7 @@ static struct spi_driver ad7793_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ad7793_probe,
-	.remove		= __devexit_p(ad7793_remove),
+	.remove		= ad7793_remove,
 	.id_table	= ad7793_id,
 };
 module_spi_driver(ad7793_driver);
diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index c5fb947..edce954 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -463,7 +463,7 @@ static struct spi_driver ad7816_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = ad7816_probe,
-	.remove = __devexit_p(ad7816_remove),
+	.remove = ad7816_remove,
 	.id_table = ad7816_id,
 };
 module_spi_driver(ad7816_driver);
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 9900507..913e6f2 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -970,7 +970,7 @@ static struct i2c_driver ad799x_driver = {
 		.name = "ad799x",
 	},
 	.probe = ad799x_probe,
-	.remove = __devexit_p(ad799x_remove),
+	.remove = ad799x_remove,
 	.id_table = ad799x_id,
 };
 module_i2c_driver(ad799x_driver);
diff --git a/drivers/staging/iio/adc/adt7410.c b/drivers/staging/iio/adc/adt7410.c
index 5e93d86..9eaa338 100644
--- a/drivers/staging/iio/adc/adt7410.c
+++ b/drivers/staging/iio/adc/adt7410.c
@@ -900,7 +900,7 @@ static struct i2c_driver adt7410_driver = {
 		.name = "adt7410",
 	},
 	.probe = adt7410_i2c_probe,
-	.remove = __devexit_p(adt7410_i2c_remove),
+	.remove = adt7410_i2c_remove,
 	.id_table = adt7410_id,
 };
 
@@ -1053,7 +1053,7 @@ static struct spi_driver adt7310_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = adt7310_spi_probe,
-	.remove = __devexit_p(adt7310_spi_remove),
+	.remove = adt7310_spi_remove,
 	.id_table = adt7310_id,
 };
 
diff --git a/drivers/staging/iio/adc/lpc32xx_adc.c b/drivers/staging/iio/adc/lpc32xx_adc.c
index 10c5962..0eb80c4 100644
--- a/drivers/staging/iio/adc/lpc32xx_adc.c
+++ b/drivers/staging/iio/adc/lpc32xx_adc.c
@@ -233,7 +233,7 @@ MODULE_DEVICE_TABLE(of, lpc32xx_adc_match);
 
 static struct platform_driver lpc32xx_adc_driver = {
 	.probe		= lpc32xx_adc_probe,
-	.remove		= __devexit_p(lpc32xx_adc_remove),
+	.remove		= lpc32xx_adc_remove,
 	.driver		= {
 		.name	= MOD_NAME,
 		.owner	= THIS_MODULE,
diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index 3b467d8..f501ab2 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -579,7 +579,7 @@ static struct platform_driver mxs_lradc_driver = {
 		.of_match_table = mxs_lradc_dt_ids,
 	},
 	.probe	= mxs_lradc_probe,
-	.remove	= __devexit_p(mxs_lradc_remove),
+	.remove	= mxs_lradc_remove,
 };
 
 module_platform_driver(mxs_lradc_driver);
diff --git a/drivers/staging/iio/adc/spear_adc.c b/drivers/staging/iio/adc/spear_adc.c
index 0b83e2e..61f6735 100644
--- a/drivers/staging/iio/adc/spear_adc.c
+++ b/drivers/staging/iio/adc/spear_adc.c
@@ -424,7 +424,7 @@ MODULE_DEVICE_TABLE(of, spear_adc_dt_ids);
 
 static struct platform_driver spear_adc_driver = {
 	.probe		= spear_adc_probe,
-	.remove		= __devexit_p(spear_adc_remove),
+	.remove		= spear_adc_remove,
 	.driver		= {
 		.name	= MOD_NAME,
 		.owner	= THIS_MODULE,
diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
index 9e128dd..84ef136 100644
--- a/drivers/staging/iio/addac/adt7316-i2c.c
+++ b/drivers/staging/iio/addac/adt7316-i2c.c
@@ -132,7 +132,7 @@ static struct i2c_driver adt7316_driver = {
 		.owner  = THIS_MODULE,
 	},
 	.probe = adt7316_i2c_probe,
-	.remove = __devexit_p(adt7316_i2c_remove),
+	.remove = adt7316_i2c_remove,
 	.id_table = adt7316_i2c_id,
 };
 module_i2c_driver(adt7316_driver);
diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/iio/addac/adt7316-spi.c
index 985f7d8..e6efd4b 100644
--- a/drivers/staging/iio/addac/adt7316-spi.c
+++ b/drivers/staging/iio/addac/adt7316-spi.c
@@ -140,7 +140,7 @@ static struct spi_driver adt7316_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = adt7316_spi_probe,
-	.remove = __devexit_p(adt7316_spi_remove),
+	.remove = adt7316_spi_remove,
 	.id_table = adt7316_spi_id,
 };
 module_spi_driver(adt7316_driver);
diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index c72a6c0..3b4d987 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -658,7 +658,7 @@ static struct i2c_driver ad7150_driver = {
 		.name = "ad7150",
 	},
 	.probe = ad7150_probe,
-	.remove = __devexit_p(ad7150_remove),
+	.remove = ad7150_remove,
 	.id_table = ad7150_id,
 };
 module_i2c_driver(ad7150_driver);
diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
index 288b33e..c7b92cb 100644
--- a/drivers/staging/iio/cdc/ad7152.c
+++ b/drivers/staging/iio/cdc/ad7152.c
@@ -541,7 +541,7 @@ static struct i2c_driver ad7152_driver = {
 		.name = KBUILD_MODNAME,
 	},
 	.probe = ad7152_probe,
-	.remove = __devexit_p(ad7152_remove),
+	.remove = ad7152_remove,
 	.id_table = ad7152_id,
 };
 module_i2c_driver(ad7152_driver);
diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index e6c11d9..9466640 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -792,7 +792,7 @@ static struct i2c_driver ad7746_driver = {
 		.name = KBUILD_MODNAME,
 	},
 	.probe = ad7746_probe,
-	.remove = __devexit_p(ad7746_remove),
+	.remove = ad7746_remove,
 	.id_table = ad7746_id,
 };
 module_i2c_driver(ad7746_driver);
diff --git a/drivers/staging/iio/frequency/ad5930.c b/drivers/staging/iio/frequency/ad5930.c
index 2d541d0..35953b8 100644
--- a/drivers/staging/iio/frequency/ad5930.c
+++ b/drivers/staging/iio/frequency/ad5930.c
@@ -141,7 +141,7 @@ static struct spi_driver ad5930_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = ad5930_probe,
-	.remove = __devexit_p(ad5930_remove),
+	.remove = ad5930_remove,
 };
 module_spi_driver(ad5930_driver);
 
diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index fed3940..af39299 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -352,7 +352,7 @@ static struct spi_driver ad9832_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ad9832_probe,
-	.remove		= __devexit_p(ad9832_remove),
+	.remove		= ad9832_remove,
 	.id_table	= ad9832_id,
 };
 module_spi_driver(ad9832_driver);
diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 1b2dc74..dc962e5 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -454,7 +454,7 @@ static struct spi_driver ad9834_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ad9834_probe,
-	.remove		= __devexit_p(ad9834_remove),
+	.remove		= ad9834_remove,
 	.id_table	= ad9834_id,
 };
 module_spi_driver(ad9834_driver);
diff --git a/drivers/staging/iio/frequency/ad9850.c b/drivers/staging/iio/frequency/ad9850.c
index 74abee0..96b18d7 100644
--- a/drivers/staging/iio/frequency/ad9850.c
+++ b/drivers/staging/iio/frequency/ad9850.c
@@ -127,7 +127,7 @@ static struct spi_driver ad9850_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = ad9850_probe,
-	.remove = __devexit_p(ad9850_remove),
+	.remove = ad9850_remove,
 };
 module_spi_driver(ad9850_driver);
 
diff --git a/drivers/staging/iio/frequency/ad9852.c b/drivers/staging/iio/frequency/ad9852.c
index fd9d14a..3ce3002 100644
--- a/drivers/staging/iio/frequency/ad9852.c
+++ b/drivers/staging/iio/frequency/ad9852.c
@@ -278,7 +278,7 @@ static struct spi_driver ad9852_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = ad9852_probe,
-	.remove = __devexit_p(ad9852_remove),
+	.remove = ad9852_remove,
 };
 module_spi_driver(ad9852_driver);
 
diff --git a/drivers/staging/iio/frequency/ad9910.c b/drivers/staging/iio/frequency/ad9910.c
index 5a7ba30..6a44506 100644
--- a/drivers/staging/iio/frequency/ad9910.c
+++ b/drivers/staging/iio/frequency/ad9910.c
@@ -411,7 +411,7 @@ static struct spi_driver ad9910_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = ad9910_probe,
-	.remove = __devexit_p(ad9910_remove),
+	.remove = ad9910_remove,
 };
 module_spi_driver(ad9910_driver);
 
diff --git a/drivers/staging/iio/frequency/ad9951.c b/drivers/staging/iio/frequency/ad9951.c
index ba6f49f..81e105e 100644
--- a/drivers/staging/iio/frequency/ad9951.c
+++ b/drivers/staging/iio/frequency/ad9951.c
@@ -222,7 +222,7 @@ static struct spi_driver ad9951_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = ad9951_probe,
-	.remove = __devexit_p(ad9951_remove),
+	.remove = ad9951_remove,
 };
 module_spi_driver(ad9951_driver);
 
diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
index 87151a7..8c7fd27 100644
--- a/drivers/staging/iio/gyro/adis16060_core.c
+++ b/drivers/staging/iio/gyro/adis16060_core.c
@@ -221,7 +221,7 @@ static struct spi_driver adis16060_r_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = adis16060_r_probe,
-	.remove = __devexit_p(adis16060_r_remove),
+	.remove = adis16060_r_remove,
 };
 
 static struct spi_driver adis16060_w_driver = {
@@ -230,7 +230,7 @@ static struct spi_driver adis16060_w_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = adis16060_w_probe,
-	.remove = __devexit_p(adis16060_w_remove),
+	.remove = adis16060_w_remove,
 };
 
 static __init int adis16060_init(void)
diff --git a/drivers/staging/iio/gyro/adis16080_core.c b/drivers/staging/iio/gyro/adis16080_core.c
index a739025..1e7e50e 100644
--- a/drivers/staging/iio/gyro/adis16080_core.c
+++ b/drivers/staging/iio/gyro/adis16080_core.c
@@ -191,7 +191,7 @@ static struct spi_driver adis16080_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = adis16080_probe,
-	.remove = __devexit_p(adis16080_remove),
+	.remove = adis16080_remove,
 };
 module_spi_driver(adis16080_driver);
 
diff --git a/drivers/staging/iio/gyro/adis16130_core.c b/drivers/staging/iio/gyro/adis16130_core.c
index fbf96b0..fa4276d 100644
--- a/drivers/staging/iio/gyro/adis16130_core.c
+++ b/drivers/staging/iio/gyro/adis16130_core.c
@@ -168,7 +168,7 @@ static struct spi_driver adis16130_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = adis16130_probe,
-	.remove = __devexit_p(adis16130_remove),
+	.remove = adis16130_remove,
 };
 module_spi_driver(adis16130_driver);
 
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index e822460..11d1ef1 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -737,7 +737,7 @@ static struct spi_driver adis16260_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = adis16260_probe,
-	.remove = __devexit_p(adis16260_remove),
+	.remove = adis16260_remove,
 	.id_table = adis16260_id,
 };
 module_spi_driver(adis16260_driver);
diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
index d93527d..a3edc2d 100644
--- a/drivers/staging/iio/gyro/adxrs450_core.c
+++ b/drivers/staging/iio/gyro/adxrs450_core.c
@@ -430,7 +430,7 @@ static struct spi_driver adxrs450_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = adxrs450_probe,
-	.remove = __devexit_p(adxrs450_remove),
+	.remove = adxrs450_remove,
 	.id_table	= adxrs450_id,
 };
 module_spi_driver(adxrs450_driver);
diff --git a/drivers/staging/iio/iio_hwmon.c b/drivers/staging/iio/iio_hwmon.c
index 5d49122..b43cbb8 100644
--- a/drivers/staging/iio/iio_hwmon.c
+++ b/drivers/staging/iio/iio_hwmon.c
@@ -189,7 +189,7 @@ static struct platform_driver __refdata iio_hwmon_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = iio_hwmon_probe,
-	.remove = __devexit_p(iio_hwmon_remove),
+	.remove = iio_hwmon_remove,
 };
 
 module_platform_driver(iio_hwmon_driver);
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index b1fef14..8cde955 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -817,7 +817,7 @@ static struct i2c_driver ad5933_driver = {
 		.name = "ad5933",
 	},
 	.probe = ad5933_probe,
-	.remove = __devexit_p(ad5933_remove),
+	.remove = ad5933_remove,
 	.id_table = ad5933_id,
 };
 module_i2c_driver(ad5933_driver);
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index c3f9bb9..73b4635 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -1311,7 +1311,7 @@ static struct spi_driver adis16400_driver = {
 	},
 	.id_table = adis16400_id,
 	.probe = adis16400_probe,
-	.remove = __devexit_p(adis16400_remove),
+	.remove = adis16400_remove,
 };
 module_spi_driver(adis16400_driver);
 
diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 3b03f6f..6280ed7 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -669,7 +669,7 @@ static struct i2c_driver isl29018_driver = {
 			.of_match_table = isl29018_of_match,
 		    },
 	.probe	 = isl29018_probe,
-	.remove	 = __devexit_p(isl29018_remove),
+	.remove	 = isl29018_remove,
 	.id_table = isl29018_id,
 };
 module_i2c_driver(isl29018_driver);
diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index 33a4c3f..17e9150 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -555,7 +555,7 @@ static struct i2c_driver isl29028_driver = {
 		.of_match_table = isl29028_of_match,
 	},
 	.probe	 = isl29028_probe,
-	.remove  = __devexit_p(isl29028_remove),
+	.remove  = isl29028_remove,
 	.id_table = isl29028_id,
 };
 
diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index 954ca2c..5f7e887 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -889,7 +889,7 @@ static struct i2c_driver tsl2563_i2c_driver = {
 		.pm	= TSL2563_PM_OPS,
 	},
 	.probe		= tsl2563_probe,
-	.remove		= __devexit_p(tsl2563_remove),
+	.remove		= tsl2563_remove,
 	.id_table	= tsl2563_id,
 };
 module_i2c_driver(tsl2563_i2c_driver);
diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 6d2f4c6..c873054 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -947,7 +947,7 @@ static struct i2c_driver taos_driver = {
 	},
 	.id_table = taos_idtable,
 	.probe = taos_probe,
-	.remove = __devexit_p(taos_remove),
+	.remove = taos_remove,
 };
 module_i2c_driver(taos_driver);
 
diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
index 497a977..5c77908 100644
--- a/drivers/staging/iio/light/tsl2x7x_core.c
+++ b/drivers/staging/iio/light/tsl2x7x_core.c
@@ -2070,7 +2070,7 @@ static struct i2c_driver tsl2x7x_driver = {
 	},
 	.id_table = tsl2x7x_idtable,
 	.probe = tsl2x7x_probe,
-	.remove = __devexit_p(tsl2x7x_remove),
+	.remove = tsl2x7x_remove,
 };
 
 module_i2c_driver(tsl2x7x_driver);
diff --git a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
index 01b4b07..a2ba22d 100644
--- a/drivers/staging/iio/magnetometer/ak8975.c
+++ b/drivers/staging/iio/magnetometer/ak8975.c
@@ -510,7 +510,7 @@ static struct i2c_driver ak8975_driver = {
 		.of_match_table = ak8975_of_match,
 	},
 	.probe		= ak8975_probe,
-	.remove		= __devexit_p(ak8975_remove),
+	.remove		= ak8975_remove,
 	.id_table	= ak8975_id,
 };
 module_i2c_driver(ak8975_driver);
diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index f7edf69..233f2b8 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -755,7 +755,7 @@ static struct i2c_driver hmc5843_driver = {
 	},
 	.id_table	= hmc5843_id,
 	.probe		= hmc5843_probe,
-	.remove		= __devexit_p(hmc5843_remove),
+	.remove		= hmc5843_remove,
 	.detect		= hmc5843_detect,
 	.address_list	= normal_i2c,
 };
diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
index 8b9eceb..c9ffcdb 100644
--- a/drivers/staging/iio/meter/ade7753.c
+++ b/drivers/staging/iio/meter/ade7753.c
@@ -572,7 +572,7 @@ static struct spi_driver ade7753_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = ade7753_probe,
-	.remove = __devexit_p(ade7753_remove),
+	.remove = ade7753_remove,
 };
 module_spi_driver(ade7753_driver);
 
diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
index 76e0adee..21463eb 100644
--- a/drivers/staging/iio/meter/ade7754.c
+++ b/drivers/staging/iio/meter/ade7754.c
@@ -594,7 +594,7 @@ static struct spi_driver ade7754_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = ade7754_probe,
-	.remove = __devexit_p(ade7754_remove),
+	.remove = ade7754_remove,
 };
 module_spi_driver(ade7754_driver);
 
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index a0fef77..6950d1f 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -992,7 +992,7 @@ static struct spi_driver ade7758_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = ade7758_probe,
-	.remove = __devexit_p(ade7758_remove),
+	.remove = ade7758_remove,
 	.id_table = ade7758_id,
 };
 module_spi_driver(ade7758_driver);
diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
index cb0707c..729ce94 100644
--- a/drivers/staging/iio/meter/ade7759.c
+++ b/drivers/staging/iio/meter/ade7759.c
@@ -516,7 +516,7 @@ static struct spi_driver ade7759_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = ade7759_probe,
-	.remove = __devexit_p(ade7759_remove),
+	.remove = ade7759_remove,
 };
 module_spi_driver(ade7759_driver);
 
diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
index 0609046..16412ca 100644
--- a/drivers/staging/iio/meter/ade7854-i2c.c
+++ b/drivers/staging/iio/meter/ade7854-i2c.c
@@ -250,7 +250,7 @@ static struct i2c_driver ade7854_i2c_driver = {
 		.name = "ade7854",
 	},
 	.probe    = ade7854_i2c_probe,
-	.remove   = __devexit_p(ade7854_i2c_remove),
+	.remove   = ade7854_i2c_remove,
 	.id_table = ade7854_id,
 };
 module_i2c_driver(ade7854_i2c_driver);
diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
index 7dae035..b3845e6 100644
--- a/drivers/staging/iio/meter/ade7854-spi.c
+++ b/drivers/staging/iio/meter/ade7854-spi.c
@@ -351,7 +351,7 @@ static struct spi_driver ade7854_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = ade7854_spi_probe,
-	.remove = __devexit_p(ade7854_spi_remove),
+	.remove = ade7854_spi_remove,
 	.id_table = ade7854_id,
 };
 module_spi_driver(ade7854_driver);
diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
index 8b71eb0..bbb4c93 100644
--- a/drivers/staging/iio/resolver/ad2s1200.c
+++ b/drivers/staging/iio/resolver/ad2s1200.c
@@ -170,7 +170,7 @@ static struct spi_driver ad2s1200_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = ad2s1200_probe,
-	.remove = __devexit_p(ad2s1200_remove),
+	.remove = ad2s1200_remove,
 	.id_table = ad2s1200_id,
 };
 module_spi_driver(ad2s1200_driver);
diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 4ba4d05..5c5d01a 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -759,7 +759,7 @@ static struct spi_driver ad2s1210_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = ad2s1210_probe,
-	.remove = __devexit_p(ad2s1210_remove),
+	.remove = ad2s1210_remove,
 	.id_table = ad2s1210_id,
 };
 module_spi_driver(ad2s1210_driver);
diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index a805722..f15c0af 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -118,7 +118,7 @@ static struct spi_driver ad2s90_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = ad2s90_probe,
-	.remove = __devexit_p(ad2s90_remove),
+	.remove = ad2s90_remove,
 	.id_table = ad2s90_id,
 };
 module_spi_driver(ad2s90_driver);
diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
index 52062d7..eb976d8 100644
--- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
+++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
@@ -296,7 +296,7 @@ static struct platform_driver iio_bfin_tmr_trigger_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = iio_bfin_tmr_trigger_probe,
-	.remove = __devexit_p(iio_bfin_tmr_trigger_remove),
+	.remove = iio_bfin_tmr_trigger_remove,
 };
 
 module_platform_driver(iio_bfin_tmr_trigger_driver);
diff --git a/drivers/staging/iio/trigger/iio-trig-gpio.c b/drivers/staging/iio/trigger/iio-trig-gpio.c
index 5ff4d7f..5f53393 100644
--- a/drivers/staging/iio/trigger/iio-trig-gpio.c
+++ b/drivers/staging/iio/trigger/iio-trig-gpio.c
@@ -153,7 +153,7 @@ static int __devexit iio_gpio_trigger_remove(struct platform_device *pdev)
 
 static struct platform_driver iio_gpio_trigger_driver = {
 	.probe = iio_gpio_trigger_probe,
-	.remove = __devexit_p(iio_gpio_trigger_remove),
+	.remove = iio_gpio_trigger_remove,
 	.driver = {
 		.name = "iio_gpio_trigger",
 		.owner = THIS_MODULE,
diff --git a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
index a3de76d..079dce7 100644
--- a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
+++ b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
@@ -188,7 +188,7 @@ static int __devexit iio_trig_periodic_rtc_remove(struct platform_device *dev)
 
 static struct platform_driver iio_trig_periodic_rtc_driver = {
 	.probe = iio_trig_periodic_rtc_probe,
-	.remove = __devexit_p(iio_trig_periodic_rtc_remove),
+	.remove = iio_trig_periodic_rtc_remove,
 	.driver = {
 		.name = "iio_prtc_trigger",
 		.owner = THIS_MODULE,
-- 
1.8.0

