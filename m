Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bl2nam02on0079.outbound.protection.outlook.com ([104.47.38.79]:42784
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727858AbeHNOJP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 14 Aug 2018 10:09:15 -0400
From: <michael.hennerich@analog.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>
CC: <linux-iio@vger.kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 1/7] drivers: iio: Update MODULE AUTHOR email address
Date: Tue, 14 Aug 2018 13:23:17 +0200
Message-ID: <1534245797-632-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

no functional changes

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/iio/adc/ad7298.c                        | 2 +-
 drivers/iio/adc/ad7476.c                        | 2 +-
 drivers/iio/adc/ad7793.c                        | 2 +-
 drivers/iio/adc/ad7887.c                        | 2 +-
 drivers/iio/adc/ad7923.c                        | 2 +-
 drivers/iio/adc/ad799x.c                        | 2 +-
 drivers/iio/amplifiers/ad8366.c                 | 2 +-
 drivers/iio/dac/ad5446.c                        | 2 +-
 drivers/iio/dac/ad5504.c                        | 2 +-
 drivers/iio/dac/ad5686.c                        | 2 +-
 drivers/iio/dac/ad5791.c                        | 2 +-
 drivers/iio/frequency/ad9523.c                  | 2 +-
 drivers/iio/trigger/iio-trig-sysfs.c            | 2 +-
 drivers/staging/iio/adc/ad7192.c                | 2 +-
 drivers/staging/iio/adc/ad7280a.c               | 2 +-
 drivers/staging/iio/adc/ad7606.c                | 2 +-
 drivers/staging/iio/adc/ad7606_par.c            | 2 +-
 drivers/staging/iio/adc/ad7606_spi.c            | 2 +-
 drivers/staging/iio/adc/ad7780.c                | 2 +-
 drivers/staging/iio/cdc/ad7746.c                | 2 +-
 drivers/staging/iio/frequency/ad9832.c          | 2 +-
 drivers/staging/iio/frequency/ad9834.c          | 2 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c | 2 +-
 23 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
index 2b20c6c..e022082 100644
--- a/drivers/iio/adc/ad7298.c
+++ b/drivers/iio/adc/ad7298.c
@@ -385,6 +385,6 @@ static struct spi_driver ad7298_driver = {
 };
 module_spi_driver(ad7298_driver);
 
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7298 ADC");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index fbaae4774..0549686 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -328,6 +328,6 @@ static struct spi_driver ad7476_driver = {
 };
 module_spi_driver(ad7476_driver);
 
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7476 and similar 1-channel ADCs");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index d4bbe5b..4ac3ae6 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -822,6 +822,6 @@ static struct spi_driver ad7793_driver = {
 };
 module_spi_driver(ad7793_driver);
 
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7793 and similar ADCs");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index 205c0f1..9d4c246 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -362,6 +362,6 @@ static struct spi_driver ad7887_driver = {
 };
 module_spi_driver(ad7887_driver);
 
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7887 ADC");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index ffb7e08..d62dbb6 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -363,7 +363,7 @@ static struct spi_driver ad7923_driver = {
 };
 module_spi_driver(ad7923_driver);
 
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_AUTHOR("Patrick Vasseur <patrick.vasseur@c-s.fr>");
 MODULE_DESCRIPTION("Analog Devices AD7904/AD7914/AD7923/AD7924 ADC");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index e1da67d..7a5b5d0 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -892,6 +892,6 @@ static struct i2c_driver ad799x_driver = {
 };
 module_i2c_driver(ad799x_driver);
 
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD799x ADC");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index 0138337..4b76b61 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -209,6 +209,6 @@ static struct spi_driver ad8366_driver = {
 
 module_spi_driver(ad8366_driver);
 
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD8366 VGA");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index fd26a42..c342670 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -628,6 +628,6 @@ static void __exit ad5446_exit(void)
 }
 module_exit(ad5446_exit);
 
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD5444/AD5446 DAC");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index d9037ea..0ae23a2 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -369,6 +369,6 @@ static struct spi_driver ad5504_driver = {
 };
 module_spi_driver(ad5504_driver);
 
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD5501/AD5501 DAC");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index e136f0f..1a13903 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -463,6 +463,6 @@ int ad5686_remove(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(ad5686_remove);
 
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD5686/85/84 DAC");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
index 7569bf6..84ce5e6 100644
--- a/drivers/iio/dac/ad5791.c
+++ b/drivers/iio/dac/ad5791.c
@@ -467,6 +467,6 @@ static struct spi_driver ad5791_driver = {
 };
 module_spi_driver(ad5791_driver);
 
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD5760/AD5780/AD5781/AD5790/AD5791 DAC");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index ddb6a33..7699cce 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -1034,6 +1034,6 @@ static struct spi_driver ad9523_driver = {
 };
 module_spi_driver(ad9523_driver);
 
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD9523 CLOCKDIST/PLL");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/trigger/iio-trig-sysfs.c b/drivers/iio/trigger/iio-trig-sysfs.c
index 3f0dc9a..45c4897 100644
--- a/drivers/iio/trigger/iio-trig-sysfs.c
+++ b/drivers/iio/trigger/iio-trig-sysfs.c
@@ -222,7 +222,7 @@ static void __exit iio_sysfs_trig_exit(void)
 }
 module_exit(iio_sysfs_trig_exit);
 
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Sysfs based trigger for the iio subsystem");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:iio-trig-sysfs");
diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index df0499f..acdbc07 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -761,6 +761,6 @@ static struct spi_driver ad7192_driver = {
 };
 module_spi_driver(ad7192_driver);
 
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7190, AD7192, AD7193, AD7195 ADC");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index b736275..58420dc 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -987,6 +987,6 @@ static struct spi_driver ad7280_driver = {
 };
 module_spi_driver(ad7280_driver);
 
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7280A");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
index 25b9fcd..c5fe300 100644
--- a/drivers/staging/iio/adc/ad7606.c
+++ b/drivers/staging/iio/adc/ad7606.c
@@ -534,6 +534,6 @@ EXPORT_SYMBOL_GPL(ad7606_pm_ops);
 
 #endif
 
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/staging/iio/adc/ad7606_par.c
index a34c2a1..956e387 100644
--- a/drivers/staging/iio/adc/ad7606_par.c
+++ b/drivers/staging/iio/adc/ad7606_par.c
@@ -105,6 +105,6 @@ static struct platform_driver ad7606_driver = {
 
 module_platform_driver(ad7606_driver);
 
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/adc/ad7606_spi.c b/drivers/staging/iio/adc/ad7606_spi.c
index c9b1f266..ffd9d06 100644
--- a/drivers/staging/iio/adc/ad7606_spi.c
+++ b/drivers/staging/iio/adc/ad7606_spi.c
@@ -73,6 +73,6 @@ static struct spi_driver ad7606_driver = {
 };
 module_spi_driver(ad7606_driver);
 
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index 16d7207..b67412d 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -260,6 +260,6 @@ static struct spi_driver ad7780_driver = {
 };
 module_spi_driver(ad7780_driver);
 
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7780 and similar ADCs");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index f53612a..0eb28fe 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -758,6 +758,6 @@ static struct i2c_driver ad7746_driver = {
 };
 module_i2c_driver(ad7746_driver);
 
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7746/5/7 capacitive sensor driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index c73eff1..a3ce504 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -454,6 +454,6 @@ static struct spi_driver ad9832_driver = {
 };
 module_spi_driver(ad9832_driver);
 
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD9832/AD9835 DDS");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 4c6d404..1e97701 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -526,6 +526,6 @@ static struct spi_driver ad9834_driver = {
 };
 module_spi_driver(ad9834_driver);
 
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD9833/AD9834/AD9837/AD9838 DDS");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 3bcf494..09f0b82 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -816,6 +816,6 @@ static struct i2c_driver ad5933_driver = {
 };
 module_i2c_driver(ad5933_driver);
 
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD5933 Impedance Conv. Network Analyzer");
 MODULE_LICENSE("GPL v2");
-- 
2.7.4
