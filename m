Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:6467 "EHLO
	VA3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754500Ab1KPHxk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Nov 2011 02:53:40 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@suse.de>
CC: Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	<devel@driverdev.osuosl.org>, <linux-iio@vger.kernel.org>,
	<device-drivers-devel@blackfin.uclinux.org>, <drivers@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] staging:iio: Add missing MODULE_DEVICE_TABLE and MODULE_ALIAS
Date: Wed, 16 Nov 2011 08:53:31 +0100
Message-ID: <1321430011-4198-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Quite a few iio drivers provide no MODULE_DEVICE_TABLE or MODULE_ALIAS or only
provide a MODULE_ALIAS while they have support for multiple device ids. This
prevents auto module loading from working correctly.

This patch fixes it by adding the missing MODULE_DEVICE_TABLEs and
MODULE_ALIAS'.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/adis16201_core.c |    1 +
 drivers/staging/iio/accel/adis16203_core.c |    1 +
 drivers/staging/iio/accel/adis16204_core.c |    1 +
 drivers/staging/iio/accel/adis16209_core.c |    1 +
 drivers/staging/iio/accel/adis16220_core.c |    1 +
 drivers/staging/iio/accel/adis16240_core.c |    1 +
 drivers/staging/iio/accel/kxsd9.c          |    4 +++-
 drivers/staging/iio/accel/lis3l02dq_core.c |    1 +
 drivers/staging/iio/accel/sca3000_core.c   |    1 +
 drivers/staging/iio/adc/ad7192.c           |    1 +
 drivers/staging/iio/adc/ad7280a.c          |    1 +
 drivers/staging/iio/adc/ad7298_core.c      |    2 +-
 drivers/staging/iio/adc/ad7476_core.c      |    2 +-
 drivers/staging/iio/adc/ad7606_par.c       |    1 -
 drivers/staging/iio/adc/ad7606_spi.c       |    2 +-
 drivers/staging/iio/adc/ad7780.c           |    1 +
 drivers/staging/iio/adc/ad7793.c           |    1 +
 drivers/staging/iio/adc/ad7887_core.c      |    2 +-
 drivers/staging/iio/adc/ad799x_core.c      |    1 -
 drivers/staging/iio/dac/ad5446.c           |    2 +-
 drivers/staging/iio/dac/ad5504.c           |    1 +
 drivers/staging/iio/dac/ad5624r_spi.c      |    1 +
 drivers/staging/iio/dac/ad5686.c           |    1 +
 drivers/staging/iio/dac/ad5791.c           |    1 +
 drivers/staging/iio/dds/ad5930.c           |    1 +
 drivers/staging/iio/dds/ad9832.c           |    2 +-
 drivers/staging/iio/dds/ad9834.c           |    2 +-
 drivers/staging/iio/dds/ad9850.c           |    1 +
 drivers/staging/iio/dds/ad9852.c           |    1 +
 drivers/staging/iio/dds/ad9910.c           |    1 +
 drivers/staging/iio/dds/ad9951.c           |    1 +
 drivers/staging/iio/gyro/adis16080_core.c  |    1 +
 drivers/staging/iio/gyro/adis16130_core.c  |    1 +
 drivers/staging/iio/gyro/adis16260_core.c  |    1 +
 drivers/staging/iio/gyro/adxrs450_core.c   |    1 +
 drivers/staging/iio/imu/adis16400_core.c   |    1 +
 drivers/staging/iio/magnetometer/hmc5843.c |    1 +
 drivers/staging/iio/meter/ade7753.c        |    1 +
 drivers/staging/iio/meter/ade7754.c        |    1 +
 drivers/staging/iio/meter/ade7758_core.c   |    1 +
 drivers/staging/iio/meter/ade7759.c        |    1 +
 drivers/staging/iio/meter/ade7854-spi.c    |    1 +
 drivers/staging/iio/resolver/ad2s1200.c    |    1 +
 drivers/staging/iio/resolver/ad2s1210.c    |    1 +
 drivers/staging/iio/resolver/ad2s90.c      |    1 +
 45 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
index d3d877f..ed97da2 100644
--- a/drivers/staging/iio/accel/adis16201_core.c
+++ b/drivers/staging/iio/accel/adis16201_core.c
@@ -564,3 +564,4 @@ module_exit(adis16201_exit);
 MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
 MODULE_DESCRIPTION("Analog Devices ADIS16201 Programmable Digital Vibration Sensor driver");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("spi:adis16201");
diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index bdc44fe..41fe930 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -519,3 +519,4 @@ module_exit(adis16203_exit);
 MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
 MODULE_DESCRIPTION("Analog Devices ADIS16203 Programmable Digital Vibration Sensor driver");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("spi:adis16203");
diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
index 96d8c7b..fcab806 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -593,3 +593,4 @@ module_exit(adis16204_exit);
 MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
 MODULE_DESCRIPTION("ADIS16204 High-g Digital Impact Sensor and Recorder");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("spi:adis16204");
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index 62e6bd8..4ad33ec 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -568,3 +568,4 @@ module_exit(adis16209_exit);
 MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
 MODULE_DESCRIPTION("Analog Devices ADIS16209 Digital Vibration Sensor driver");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("spi:adis16209");
diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
index ca18f72..4baf02c 100644
--- a/drivers/staging/iio/accel/adis16220_core.c
+++ b/drivers/staging/iio/accel/adis16220_core.c
@@ -724,3 +724,4 @@ module_exit(adis16220_exit);
 MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
 MODULE_DESCRIPTION("Analog Devices ADIS16220 Digital Vibration Sensor");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("spi:adis16220");
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index 1348393..4298c40 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -621,3 +621,4 @@ module_exit(adis16240_exit);
 MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
 MODULE_DESCRIPTION("Analog Devices Programmable Impact Sensor and Recorder");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("spi:adis16240");
diff --git a/drivers/staging/iio/accel/kxsd9.c b/drivers/staging/iio/accel/kxsd9.c
index abb6071..5a543fa 100644
--- a/drivers/staging/iio/accel/kxsd9.c
+++ b/drivers/staging/iio/accel/kxsd9.c
@@ -268,8 +268,10 @@ static int __devexit kxsd9_remove(struct spi_device *spi)
 }
 
 static const struct spi_device_id kxsd9_id[] = {
-	{"kxsd9", 0}
+	{"kxsd9", 0},
+	{ },
 };
+MODULE_DEVICE_TABLE(spi, kxsd9_id);
 
 static struct spi_driver kxsd9_driver = {
 	.driver = {
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index 6d715a6..4dbe4c7 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -821,3 +821,4 @@ module_exit(lis3l02dq_exit);
 MODULE_AUTHOR("Jonathan Cameron <jic23@cam.ac.uk>");
 MODULE_DESCRIPTION("ST LIS3L02DQ Accelerometer SPI driver");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("spi:lis3l02dq");
diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 021a08f..94bfe05 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -1241,6 +1241,7 @@ static const struct spi_device_id sca3000_id[] = {
 	{"sca3000_e05", e05},
 	{}
 };
+MODULE_DEVICE_TABLE(spi, sca3000_id);
 
 static struct spi_driver sca3000_driver = {
 	.driver = {
diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 4e643de..f48a0d4 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -1153,6 +1153,7 @@ static const struct spi_device_id ad7192_id[] = {
 	{"ad7195", ID_AD7195},
 	{}
 };
+MODULE_DEVICE_TABLE(spi, ad7192_id);
 
 static struct spi_driver ad7192_driver = {
 	.driver = {
diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index cd3397f..1af4194 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -970,6 +970,7 @@ static const struct spi_device_id ad7280_id[] = {
 	{"ad7280a", 0},
 	{}
 };
+MODULE_DEVICE_TABLE(spi, ad7280_id);
 
 static struct spi_driver ad7280_driver = {
 	.driver = {
diff --git a/drivers/staging/iio/adc/ad7298_core.c b/drivers/staging/iio/adc/ad7298_core.c
index 0be71df..093b2b2 100644
--- a/drivers/staging/iio/adc/ad7298_core.c
+++ b/drivers/staging/iio/adc/ad7298_core.c
@@ -270,6 +270,7 @@ static const struct spi_device_id ad7298_id[] = {
 	{"ad7298", 0},
 	{}
 };
+MODULE_DEVICE_TABLE(spi, ad7298_id);
 
 static struct spi_driver ad7298_driver = {
 	.driver = {
@@ -297,4 +298,3 @@ module_exit(ad7298_exit);
 MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
 MODULE_DESCRIPTION("Analog Devices AD7298 ADC");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("spi:ad7298");
diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
index a06ae9e..93b2bef 100644
--- a/drivers/staging/iio/adc/ad7476_core.c
+++ b/drivers/staging/iio/adc/ad7476_core.c
@@ -237,6 +237,7 @@ static const struct spi_device_id ad7476_id[] = {
 	{"ad7495", ID_AD7495},
 	{}
 };
+MODULE_DEVICE_TABLE(spi, ad7476_id);
 
 static struct spi_driver ad7476_driver = {
 	.driver = {
@@ -264,4 +265,3 @@ module_exit(ad7476_exit);
 MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
 MODULE_DESCRIPTION("Analog Devices AD7475/6/7/8(A) AD7466/7/8 ADC");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("spi:ad7476");
diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/staging/iio/adc/ad7606_par.c
index 688632e..cff9756 100644
--- a/drivers/staging/iio/adc/ad7606_par.c
+++ b/drivers/staging/iio/adc/ad7606_par.c
@@ -189,4 +189,3 @@ module_exit(ad7606_cleanup);
 MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
 MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:ad7606_par");
diff --git a/drivers/staging/iio/adc/ad7606_spi.c b/drivers/staging/iio/adc/ad7606_spi.c
index aede1ba..c88d97a 100644
--- a/drivers/staging/iio/adc/ad7606_spi.c
+++ b/drivers/staging/iio/adc/ad7606_spi.c
@@ -97,6 +97,7 @@ static const struct spi_device_id ad7606_id[] = {
 	{"ad7606-4", ID_AD7606_4},
 	{}
 };
+MODULE_DEVICE_TABLE(spi, ad7606_id);
 
 static struct spi_driver ad7606_driver = {
 	.driver = {
@@ -125,4 +126,3 @@ module_exit(ad7606_spi_exit);
 MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
 MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("spi:ad7606_spi");
diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index f5f7e76..635c7ba 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -272,6 +272,7 @@ static const struct spi_device_id ad7780_id[] = {
 	{"ad7781", ID_AD7781},
 	{}
 };
+MODULE_DEVICE_TABLE(spi, ad7780_id);
 
 static struct spi_driver ad7780_driver = {
 	.driver = {
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index 803c45f..362cc31 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -1036,6 +1036,7 @@ static const struct spi_device_id ad7793_id[] = {
 	{"ad7793", ID_AD7793},
 	{}
 };
+MODULE_DEVICE_TABLE(spi, ad7793_id);
 
 static struct spi_driver ad7793_driver = {
 	.driver = {
diff --git a/drivers/staging/iio/adc/ad7887_core.c b/drivers/staging/iio/adc/ad7887_core.c
index baa6e6a..8f48659 100644
--- a/drivers/staging/iio/adc/ad7887_core.c
+++ b/drivers/staging/iio/adc/ad7887_core.c
@@ -246,6 +246,7 @@ static const struct spi_device_id ad7887_id[] = {
 	{"ad7887", ID_AD7887},
 	{}
 };
+MODULE_DEVICE_TABLE(spi, ad7887_id);
 
 static struct spi_driver ad7887_driver = {
 	.driver = {
@@ -273,4 +274,3 @@ module_exit(ad7887_exit);
 MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
 MODULE_DESCRIPTION("Analog Devices AD7887 ADC");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("spi:ad7887");
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index cdee9b9..5bedb19 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -944,7 +944,6 @@ static __exit void ad799x_exit(void)
 MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
 MODULE_DESCRIPTION("Analog Devices AD799x ADC");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("i2c:ad799x");
 
 module_init(ad799x_init);
 module_exit(ad799x_exit);
diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
index 11a0be8..ef1ad11 100644
--- a/drivers/staging/iio/dac/ad5446.c
+++ b/drivers/staging/iio/dac/ad5446.c
@@ -441,6 +441,7 @@ static const struct spi_device_id ad5446_id[] = {
 	{"ad5662", ID_AD5662},
 	{}
 };
+MODULE_DEVICE_TABLE(spi, ad5446_id);
 
 static struct spi_driver ad5446_driver = {
 	.driver = {
@@ -468,4 +469,3 @@ module_exit(ad5446_exit);
 MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
 MODULE_DESCRIPTION("Analog Devices AD5444/AD5446 DAC");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("spi:ad5446");
diff --git a/drivers/staging/iio/dac/ad5504.c b/drivers/staging/iio/dac/ad5504.c
index 68a43cb..f20a5dc 100644
--- a/drivers/staging/iio/dac/ad5504.c
+++ b/drivers/staging/iio/dac/ad5504.c
@@ -378,6 +378,7 @@ static const struct spi_device_id ad5504_id[] = {
 	{"ad5501", ID_AD5501},
 	{}
 };
+MODULE_DEVICE_TABLE(spi, ad5504_id);
 
 static struct spi_driver ad5504_driver = {
 	.driver = {
diff --git a/drivers/staging/iio/dac/ad5624r_spi.c b/drivers/staging/iio/dac/ad5624r_spi.c
index 2c5524e..6cb00e1 100644
--- a/drivers/staging/iio/dac/ad5624r_spi.c
+++ b/drivers/staging/iio/dac/ad5624r_spi.c
@@ -335,6 +335,7 @@ static const struct spi_device_id ad5624r_id[] = {
 	{"ad5664r5", ID_AD5664R5},
 	{}
 };
+MODULE_DEVICE_TABLE(spi, ad5624r_id);
 
 static struct spi_driver ad5624r_driver = {
 	.driver = {
diff --git a/drivers/staging/iio/dac/ad5686.c b/drivers/staging/iio/dac/ad5686.c
index 7eaf594..bbaa928 100644
--- a/drivers/staging/iio/dac/ad5686.c
+++ b/drivers/staging/iio/dac/ad5686.c
@@ -437,6 +437,7 @@ static const struct spi_device_id ad5686_id[] = {
 	{"ad5686", ID_AD5686},
 	{}
 };
+MODULE_DEVICE_TABLE(spi, ad5686_id);
 
 static struct spi_driver ad5686_driver = {
 	.driver = {
diff --git a/drivers/staging/iio/dac/ad5791.c b/drivers/staging/iio/dac/ad5791.c
index db0bd12..79c4821 100644
--- a/drivers/staging/iio/dac/ad5791.c
+++ b/drivers/staging/iio/dac/ad5791.c
@@ -400,6 +400,7 @@ static const struct spi_device_id ad5791_id[] = {
 	{"ad5791", ID_AD5791},
 	{}
 };
+MODULE_DEVICE_TABLE(spi, ad5791_id);
 
 static struct spi_driver ad5791_driver = {
 	.driver = {
diff --git a/drivers/staging/iio/dds/ad5930.c b/drivers/staging/iio/dds/ad5930.c
index f5e368b..40807d2 100644
--- a/drivers/staging/iio/dds/ad5930.c
+++ b/drivers/staging/iio/dds/ad5930.c
@@ -159,3 +159,4 @@ module_exit(ad5930_spi_exit);
 MODULE_AUTHOR("Cliff Cai");
 MODULE_DESCRIPTION("Analog Devices ad5930 driver");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("spi:" DRV_NAME);
diff --git a/drivers/staging/iio/dds/ad9832.c b/drivers/staging/iio/dds/ad9832.c
index b58baec4..1c87820 100644
--- a/drivers/staging/iio/dds/ad9832.c
+++ b/drivers/staging/iio/dds/ad9832.c
@@ -344,6 +344,7 @@ static const struct spi_device_id ad9832_id[] = {
 	{"ad9835", 0},
 	{}
 };
+MODULE_DEVICE_TABLE(spi, ad9832_id);
 
 static struct spi_driver ad9832_driver = {
 	.driver = {
@@ -371,4 +372,3 @@ module_exit(ad9832_exit);
 MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
 MODULE_DESCRIPTION("Analog Devices AD9832/AD9835 DDS");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("spi:ad9832");
diff --git a/drivers/staging/iio/dds/ad9834.c b/drivers/staging/iio/dds/ad9834.c
index 2e29f6f..cd10479 100644
--- a/drivers/staging/iio/dds/ad9834.c
+++ b/drivers/staging/iio/dds/ad9834.c
@@ -435,6 +435,7 @@ static const struct spi_device_id ad9834_id[] = {
 	{"ad9838", ID_AD9838},
 	{}
 };
+MODULE_DEVICE_TABLE(spi, ad9834_id);
 
 static struct spi_driver ad9834_driver = {
 	.driver = {
@@ -462,4 +463,3 @@ module_exit(ad9834_exit);
 MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
 MODULE_DESCRIPTION("Analog Devices AD9833/AD9834/AD9837/AD9838 DDS");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("spi:ad9834");
diff --git a/drivers/staging/iio/dds/ad9850.c b/drivers/staging/iio/dds/ad9850.c
index a14771b..159f6f2 100644
--- a/drivers/staging/iio/dds/ad9850.c
+++ b/drivers/staging/iio/dds/ad9850.c
@@ -145,3 +145,4 @@ module_exit(ad9850_spi_exit);
 MODULE_AUTHOR("Cliff Cai");
 MODULE_DESCRIPTION("Analog Devices ad9850 driver");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("spi:" DRV_NAME);
diff --git a/drivers/staging/iio/dds/ad9852.c b/drivers/staging/iio/dds/ad9852.c
index cfceaa6..5a338d2 100644
--- a/drivers/staging/iio/dds/ad9852.c
+++ b/drivers/staging/iio/dds/ad9852.c
@@ -296,3 +296,4 @@ module_exit(ad9852_spi_exit);
 MODULE_AUTHOR("Cliff Cai");
 MODULE_DESCRIPTION("Analog Devices ad9852 driver");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("spi:" DRV_NAME);
diff --git a/drivers/staging/iio/dds/ad9910.c b/drivers/staging/iio/dds/ad9910.c
index da83d2b..a87ba84 100644
--- a/drivers/staging/iio/dds/ad9910.c
+++ b/drivers/staging/iio/dds/ad9910.c
@@ -429,3 +429,4 @@ module_exit(ad9910_spi_exit);
 MODULE_AUTHOR("Cliff Cai");
 MODULE_DESCRIPTION("Analog Devices ad9910 driver");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("spi:" DRV_NAME);
diff --git a/drivers/staging/iio/dds/ad9951.c b/drivers/staging/iio/dds/ad9951.c
index 20c1825..42aea15 100644
--- a/drivers/staging/iio/dds/ad9951.c
+++ b/drivers/staging/iio/dds/ad9951.c
@@ -240,3 +240,4 @@ module_exit(ad9951_spi_exit);
 MODULE_AUTHOR("Cliff Cai");
 MODULE_DESCRIPTION("Analog Devices ad9951 driver");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("spi:" DRV_NAME);
diff --git a/drivers/staging/iio/gyro/adis16080_core.c b/drivers/staging/iio/gyro/adis16080_core.c
index 5d7a906..ed37ef6 100644
--- a/drivers/staging/iio/gyro/adis16080_core.c
+++ b/drivers/staging/iio/gyro/adis16080_core.c
@@ -205,3 +205,4 @@ module_exit(adis16080_exit);
 MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
 MODULE_DESCRIPTION("Analog Devices ADIS16080/100 Yaw Rate Gyroscope Driver");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("spi:adis16080");
diff --git a/drivers/staging/iio/gyro/adis16130_core.c b/drivers/staging/iio/gyro/adis16130_core.c
index 749240d..8c2dd44 100644
--- a/drivers/staging/iio/gyro/adis16130_core.c
+++ b/drivers/staging/iio/gyro/adis16130_core.c
@@ -184,3 +184,4 @@ module_exit(adis16130_exit);
 MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
 MODULE_DESCRIPTION("Analog Devices ADIS16130 High Precision Angular Rate");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("spi:adis16130");
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index e86ce6a..5614a22 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -700,6 +700,7 @@ static const struct spi_device_id adis16260_id[] = {
 	{"adis16251", 1},
 	{}
 };
+MODULE_DEVICE_TABLE(spi, adis16260_id);
 
 static struct spi_driver adis16260_driver = {
 	.driver = {
diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
index 40bfb32..e832aea 100644
--- a/drivers/staging/iio/gyro/adxrs450_core.c
+++ b/drivers/staging/iio/gyro/adxrs450_core.c
@@ -397,3 +397,4 @@ module_exit(adxrs450_exit);
 MODULE_AUTHOR("Cliff Cai <cliff.cai@xxxxxxxxxx>");
 MODULE_DESCRIPTION("Analog Devices ADXRS450 Gyroscope SPI driver");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("spi:adxrs450");
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 174454a..a6da69f 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -1117,6 +1117,7 @@ static const struct spi_device_id adis16400_id[] = {
 	{"adis16405", ADIS16400},
 	{}
 };
+MODULE_DEVICE_TABLE(spi, adis16400_id);
 
 static struct spi_driver adis16400_driver = {
 	.driver = {
diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index f90d4d1..b492a0c 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -605,6 +605,7 @@ static const struct i2c_device_id hmc5843_id[] = {
 	{ "hmc5843", 0 },
 	{ }
 };
+MODULE_DEVICE_TABLE(i2c, hmc5843_id);
 
 static struct i2c_driver hmc5843_driver = {
 	.driver = {
diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
index 940fef6..62a879c 100644
--- a/drivers/staging/iio/meter/ade7753.c
+++ b/drivers/staging/iio/meter/ade7753.c
@@ -593,3 +593,4 @@ module_exit(ade7753_exit);
 MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
 MODULE_DESCRIPTION("Analog Devices ADE7753/6 Single-Phase Multifunction Meter");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("spi:ade7753");
diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
index 33f0d32..0111edb 100644
--- a/drivers/staging/iio/meter/ade7754.c
+++ b/drivers/staging/iio/meter/ade7754.c
@@ -616,3 +616,4 @@ module_exit(ade7754_exit);
 MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
 MODULE_DESCRIPTION("Analog Devices ADE7754 Polyphase Multifunction Energy Metering IC Driver");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("spi:ad7754");
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 839b48b..348df97 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -843,6 +843,7 @@ static const struct spi_device_id ade7758_id[] = {
 	{"ade7758", 0},
 	{}
 };
+MODULE_DEVICE_TABLE(spi, ade7758_id);
 
 static struct spi_driver ade7758_driver = {
 	.driver = {
diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
index b691f10..e7fcc7d 100644
--- a/drivers/staging/iio/meter/ade7759.c
+++ b/drivers/staging/iio/meter/ade7759.c
@@ -537,3 +537,4 @@ module_exit(ade7759_exit);
 MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
 MODULE_DESCRIPTION("Analog Devices ADE7759 Active Energy Metering IC Driver");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("spi:ad7759");
diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
index cfa23ba..50bc5d4 100644
--- a/drivers/staging/iio/meter/ade7854-spi.c
+++ b/drivers/staging/iio/meter/ade7854-spi.c
@@ -343,6 +343,7 @@ static const struct spi_device_id ade7854_id[] = {
 	{ "ade7878", 0 },
 	{ }
 };
+MODULE_DEVICE_TABLE(spi, ade7854_id);
 
 static struct spi_driver ade7854_driver = {
 	.driver = {
diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
index d7ad46a..fda07d4 100644
--- a/drivers/staging/iio/resolver/ad2s1200.c
+++ b/drivers/staging/iio/resolver/ad2s1200.c
@@ -160,6 +160,7 @@ static const struct spi_device_id ad2s1200_id[] = {
 	{ "ad2s1205" },
 	{}
 };
+MODULE_DEVICE_TABLE(spi, ad2s1200_id);
 
 static struct spi_driver ad2s1200_driver = {
 	.driver = {
diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 6401a62..8996c98 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -749,6 +749,7 @@ static const struct spi_device_id ad2s1210_id[] = {
 	{ "ad2s1210" },
 	{}
 };
+MODULE_DEVICE_TABLE(spi, ad2s1210_id);
 
 static struct spi_driver ad2s1210_driver = {
 	.driver = {
diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index a9200d9..b988b92 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -109,6 +109,7 @@ static const struct spi_device_id ad2s90_id[] = {
 	{ "ad2s90" },
 	{}
 };
+MODULE_DEVICE_TABLE(spi, ad2s90_id);
 
 static struct spi_driver ad2s90_driver = {
 	.driver = {
-- 
1.7.7.1


